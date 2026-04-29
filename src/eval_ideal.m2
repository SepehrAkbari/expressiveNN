----------
-- Expressivity ideal of X^d activation networks.
----------

load "fn_power.m2"


-- default parameters
paramN = 2 -- #input variables
paramR = 2 -- network rank (#neurons)
paramD = 2 -- power activation degree

args = {}
idx = position(commandLine, arg -> arg == "--script")
if idx =!= null and idx + 2 < #commandLine then (
    for i from idx + 2 to #commandLine - 1 do (
        args = append(args, commandLine#i)
    )
)

if #args >= 1 then paramN = value(args#0)
if #args >= 2 then paramR = value(args#1)
if #args >= 3 then paramD = value(args#2)

-- print("n: " | toString(paramN) | ", r: " | toString(paramR) | ", d: " | toString(paramD))
-- print("")

I = build_ideal(paramN, paramR, paramD, TermOrder => Lex)
<< "Generators: " << gens I << endl