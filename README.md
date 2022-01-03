# `fsolve_newton` [![View Newton’s Method for Systems of Equations (fsolve_newton) on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/104415-newton-s-method-for-systems-of-equations-fsolve_newton)

Solves a system of nonlinear equations using Newton's method.

**NOTE:** This function requires the [Numerical Differentiation Toolbox](https://www.mathworks.com/matlabcentral/fileexchange/97267-numerical-differentiation-toolbox).


## Syntax

`x = fsolve_newton(f,x0)`\
`x = fsolve_newton(f,x0,opts)`


## Description

`x = fsolve_newton(f,x0)` returns the solution of the system of nonlinear equations <img src="https://latex.codecogs.com/svg.latex?\inline&space;\mathbf{f}(\mathbf{x})=\mathbf{0}" title="" /> where the function <img src="https://latex.codecogs.com/svg.latex?\inline&space;\mathbf{f}:\mathbb{R}^{n}\to\mathbb{R}^{n}" title="" />  is specified by the function handle `f` and where `x0` is an initial guess of the solution. The default tolerance and maximum number of iterations are `TOL = 1e-12` and `imax = 1e6`, respectively.

`x = fsolve_newton(f,x0,opts)` does the same as the syntax above, but allows for the specification of optional solver parameters. `opts` is a structure that has the following fields:
   - `jacobian` &rightarrow; function handle (defined as a function of `x`) for the Jacobian of `f` (<img src="https://latex.codecogs.com/svg.latex?\inline&space;\mathbf{J}(\mathbf{x})" title="" />)
   - `imax` &rightarrow; maximum number of iterations (defaults to <img src="https://latex.codecogs.com/svg.latex?\inline&space;10^{6}" title="" />)
   - `return_all` &rightarrow; all intermediate solution estimates are returned if set to `true`; otherwise, only the converged solution is returned (defaults to `false`)
   - `TOL` &rightarrow; tolerance (defaults to <img src="https://latex.codecogs.com/svg.latex?\inline&space;10^{-12}" title="" />)
   - `warnings` &rightarrow; `true` if any warnings should be displayed, `false` if not (defaults to `true`)


## Examples and Additional Documentation

   - See "EXAMPLES.mlx" or the "Examples" tab on the File Exchange page for examples. 
   - See ["Newton_s_Method.pdf"](https://tamaskis.github.io/documentation/Newton_s_Method.pdf) (also included with download) for the technical documentation.
