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
M2 --eval_ideal.m2 <n=2> <r=2> <d=2> <TermOrder="Grevlex">
cd ../
```
where `n` is the input dimension, `r` is the rank (number of neurons), and `d` is the degree of the activation function in $\sigma(z) = z^d$. You can also specify a term order using `TermOrder => <order>`. All parameters are optional.

## Contributing

To contribute to this project, you can fork this repository and create pull requests. You can also open an issue if you find a bug or wish to make a suggestion.

## License

This project is licensed under the [GNU General Public License (GPL)](LICENSE).