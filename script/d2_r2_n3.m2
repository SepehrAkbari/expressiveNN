----------
-- Expressivity of quadratic rank-2 3D networks.
----------


R = QQ[v_11, v_12, v_13, v_21, v_22, v_23, c_200, c_020, c_002, c_110, c_101, c_011]

J = ideal(
    c_200 - (v_11^2 + v_21^2),
    c_020 - (v_12^2 + v_22^2),
    c_002 - (v_13^2 + v_23^2),
    c_110 - 2*(v_11*v_12 + v_21*v_22),
    c_101 - 2*(v_11*v_13 + v_21*v_23),
    c_011 - 2*(v_12*v_13 + v_22*v_23)
)

impl = eliminate({v_11, v_12, v_13, v_21, v_22, v_23}, J)
print gens impl