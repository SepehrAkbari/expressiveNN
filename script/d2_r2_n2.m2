----------
-- Expressivity of quadratic rank-2 2D networks.
----------


R = QQ[v_11, v_12, v_21, v_22, c_20, c_02, c_11]

J = ideal(
    c_20 - (v_11^2 + v_21^2),
    c_02 - (v_12^2 + v_22^2),
    c_11 - 2*(v_11*v_12 + v_21*v_22)
)

impl = eliminate({v_11, v_12, v_21, v_22}, J)
print gens impl
