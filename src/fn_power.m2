----------
-- Expressivity ideal of X^d activation networks.
----------


-- multinomial coefficient helper
factorial = n -> if n == 0 then 1 else product(toList(1..n));
multinomial = alpha -> factorial(sum alpha) // product(apply(alpha, factorial));

-- generates weak compositions of d into n parts
genAlphas = (d, n) -> (
    if n == 1 then return {{d}};
    if d == 0 then return {toList(n:0)};
    flatten apply(toList(0..d), i -> 
        apply(genAlphas(d - i, n - 1), c -> prepend(i, c))
    )
);

-- main method
build_ideal = method(Options => {TermOrder => Lex})

-- default quadratic activation
build_ideal(ZZ, ZZ) := o -> (n, r) -> build_ideal(n, r, 2, TermOrder => o.TermOrder)

-- executable
build_ideal(ZZ, ZZ, ZZ) := o -> (n, r, d) -> (
    
    -- c_i: coeff of i-th monomial
    -- v_ij: weight of j-th input in i-th neuron
    vNames = flatten apply(toList(1..r), i -> 
        apply(toList(1..n), j -> "v_" | toString i | toString j)
    );
    
    alphas = reverse genAlphas(d, n);
    cNames = apply(alphas, a -> "c_" | concatenate(apply(a, toString)));
    
    allNames = join(vNames, cNames);
    varStr = allNames#0;
    for idx from 1 to #allNames - 1 do (
        varStr = varStr | ", " | allNames#idx;
    );
    
    -- polynomial ring
    ringDef = "QQ[" | varStr | ", MonomialOrder => " | toString(o.TermOrder) | "]";
    R := value(ringDef);
    
    -- retrieving variables by index
    getV = (i, j) -> R_((i - 1) * n + (j - 1));
    getC = idx -> R_(r * n + idx);

    -- constructing ideal generators
    -- f(x) = sum_{i=1}^r (v_{i1}x_1 + ... + v_{in}x_n)^d
    gensList = apply(0..#alphas - 1, idx -> (
        alpha = alphas#idx;
        cVar = getC(idx);
        coeff = multinomial(alpha);
        
        poly := 0_R;
        for i from 1 to r do (
            term := 1_R;
            for j from 1 to n do (
                if alpha#(j-1) > 0 then 
                    term = term * (getV(i, j))^(alpha#(j-1));
            );
            poly = poly + term;
        );
        cVar - (coeff * poly)
    ));
    
    J := ideal gensList;
    
    -- v_ij elimination 
    vVarsList := take(gens R, r * n);
    impl := eliminate(vVarsList, J);
    
    return impl;
)