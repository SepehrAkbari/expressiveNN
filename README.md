# Neural Network Expressivity

Neural network architectures using polynomial activation functions can be analyzed using tools from algebraic geometry, which provides insights into their expressivity and approximation capabilities.

## Usage

To install Macaulay2, follow the instructions [here](https://github.com/Macaulay2/M2/wiki).

To reproduce paper results, run:

```bash
cd script
M2 --script d2_r2_n2.m2
M2 --script d2_r2_n3.m2
cd ../
```

To apply the framework to other architectures, run:

```bash
cd src
M2 --script eval_ideal.m2 [n] [r] [d]
cd ../
```
where `n` is the input dimension (default = 2), `r` is the rank or number of neurons (default = 2), and `d` is the degree of the activation function in $\sigma(z) = z^d$ (default = 2). The default term order used is Lexicographic order, you can also specify a term order using `TermOrder => <order>` inside the script. All parameters are optional.

## Contributing

To contribute to this project, you can fork this repository and create pull requests. You can also open an issue if you find a bug or wish to make a suggestion.

## License

This project is licensed under the [GNU General Public License (GPL)](LICENSE).