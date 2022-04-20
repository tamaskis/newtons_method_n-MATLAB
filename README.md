# `newtons_method_n`

Newton's method for finding the root of a differentiable, multivariate, vector-valued function.


## Syntax

`x = newtons_method_n(f,J,x0)`\
`x = newtons_method_n(f,J,x0,opts)`


## Description

`x = newtons_method_n(f,J,x0)` returns the root of a function <img src="https://latex.codecogs.com/svg.latex?\inline&space;\mathbf{f}(\mathbf{x})" title="" /> specified by the function handle `f`, where `J` is the Jacobian of <img src="https://latex.codecogs.com/svg.latex?\inline&space;\mathbf{f}(\mathbf{x})" title="" /> (i.e. <img src="https://latex.codecogs.com/svg.latex?\inline&space;\mathbf{J}(\mathbf{x})=\frac{\partial\mathbf{f}}{\partial\mathbf{x}}" title="" />) and `x0` is an initial guess of the root.

`x = fsolve_newton(f,J,x0)` returns the solution of the system of nonlinear equations <img src="https://latex.codecogs.com/svg.latex?\inline&space;\mathbf{f}(\mathbf{x})=\mathbf{0}" title="" /> where the function <img src="https://latex.codecogs.com/svg.latex?\inline&space;\mathbf{f}:\mathbb{R}^{n}\to\mathbb{R}^{n}" title="" />  is specified by the function handle `f` and where `x0` is an initial guess of the solution. The default tolerance and maximum number of iterations are `TOL = 1e-12` and `imax = 1e6`, respectively.

`x = newtons_method_n(f,J,x0,opts)` does the same as the syntax above, but allows for the specification of optional solver parameters. `opts` is a structure with the following fields:
   - `k_max` &rightarrow; maximum number of iterations (defaults to 200)
   - `return_all` &rightarrow; returns estimates at all iteration if set to `true` (defaults to `false`)
   - `TOL` &rightarrow; tolerance (defaults to <img src="https://latex.codecogs.com/svg.latex?\inline&space;10^{-10}" title="" />)

`[x,k] = newtons_method_n(__)` also returns the number of iterations (`k`) performed of Newton's method.

`[x,k,x_all] = newtons_method_n(__)` does the same as the previous syntaxes, but also returns an array (`x_all`) storing the root estimates at each iteration. This syntax requires that `opts.return_all` be set to true.


## Examples and Additional Documentation

   - See "EXAMPLES.mlx" or the "Examples" tab on the File Exchange page for examples. 
   - See ["Root_Finding_Methods.pdf"](https://tamaskis.github.io/documentation/Root_Finding_Methods.pdf) (also included with download) for the technical documentation.
