%==========================================================================
%
% fsolve_newton  Solves a system of nonlinear equations using Newton's 
% method.
%
%   x = fsolve_newton(f,x0)
%   x = fsolve_newton(f,x0,opts)
%
% See also fsolve, newtons_method.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-01-02
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/documentation/Newton_s_Method.pdf
%
% REFERENCES:
%   [1] Burden and Faires, "Numerical Analysis", 9th Ed. (pp. 67-78)
%   [2] https://en.wikipedia.org/wiki/Newton%27s_method
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) multivariate, vector-valued function 
%             f(x) (f:Rn->Rn)
%   x0      - (n×1 double) initial guess for solution
%   opts    - (OPTIONAL) (1×1 struct) solver options
%       • jacobian   - (function_handle) Jacobian of f(x)
%       • imax       - (1×1 double) maximimum number of iterations 
%                      (defaults to 1e6)
%       • return_all - (1×1 logical) all intermediate solution estimates
%                      are returned if set to "true"; otherwise, a faster 
%                      algorithm is used to return only the converged
%                      solution (defaults to false)
%       • TOL        - (1×1 double) tolerance (defaults to 1e-12)
%       • warnings   - (1×1 logical) true if any warnings should be 
%                      displayed, false if not (defaults to true)
%
% -------
% OUTPUT:
% -------
%   x       - (n×1 or n×i double) solution of f(x) = 0
%           	--> If "return_all" is specified as "true", then "x" 
%                   will be a matrix, where the first column is the 
%                   initial guess, the last column is the converged
%                   solution, and the other columns are intermediate 
%                   estimates of the solution.
%               --> Otherwise, "x" is a single vector storing the
%                   converged solution.
%
% -----
% NOTE:
% -----
%   --> "i" is the number of iterations it took for the solution to
%       converge.
%
%==========================================================================
function x = fsolve_newton(f,x0,opts)
    
    % ----------------------------------
    % Sets (or defaults) solver options.
    % ----------------------------------
    
    % sets function handle for Jacobian (approximates using complex-step
    % approximation if not input)
    if (nargin == 3) && ~isempty(opts) && isfield(opts,'jacobian')
        J = @(x) opts.jacobian(x);
    else
        J = @(x) ijacobian(f,x);
    end

    % sets maximum number of iterations (defaults to 1e6)
    if (nargin < 4) || isempty(opts) || ~isfield(opts,'imax')
        imax = 1e6;
    else
        imax = opts.imax;
    end
    
    % determines return value (defaults to only return converged solution)
    if (nargin < 4) || isempty(opts) || ~isfield(opts,'return_all')
        return_all = false;
    else
        return_all = opts.return_all;
    end
    
    % sets tolerance (defaults to 1e-12)
    if (nargin < 4) || isempty(opts) || ~isfield(opts,'TOL')
        TOL = 1e-12;
    else
        TOL = opts.TOL;
    end
    
    % determines if warnings should be displayed (defaults to true)
    if (nargin < 4) || isempty(opts) || ~isfield(opts,'warnings')
        warnings = true;
    else
        warnings = opts.warnings;
    end
    
    % -----------------------------------------------
    % "Return all" implementation of Newton's method.
    % -----------------------------------------------
    
    if return_all
        
        % preallocates x
        x = zeros(length(x0),imax);

        % inputs initial guess for solution into x matrix
        x(:,1) = x0;

        % initializes the error so the loop will be entered
        err = 2*TOL;
    
        % Newton's method
        i = 1;
        while (err > TOL) && (i < imax)

            % solves for y
            y = J(x(:,i))\(-f(x(:,i)));

            % updates estimate of solution
            x(:,i+1) = x(:,i)+y;

            % calculates error
            err = norm(x(:,i+1)-x(:,i));

            % increments loop index
            i = i+1;

        end
        
        % returns converged solution along with intermediate solution 
        % estimates
        x = x(:,1:i);

    % -----------------------------------------
    % "Fast" implementation of Newton's method.
    % -----------------------------------------
    
    else
        
        % sets solution estimate at the first iteration of Newton's method
        % as the initial guess
        x_old = x0;
        
        % initializes x_new so its scope isn't limited to the while loop
        x_new = zeros(size(x0));
        
        % initializes the error so the loop will be entered
        err = 2*TOL;
        
        % Newton's method
        i = 1;
        while (err > TOL) && (i < imax)

            % solves for y
            y = J(x_old)\(-f(x_old));

            % updates estimate of solution
            x_new = x_old+y;

            % calculates error
            err = norm(x_new-x_old);

            % stores current solution estimate for next iteration
            x_old = x_new;

            % increments loop index
            i = i+1;

        end
        
        % returns converged solution
        x = x_new;
      
    end

    % ---------------------------------------------------------
    % Displays warning if maximum number of iterations reached.
    % ---------------------------------------------------------

    if (i == imax) && warnings
        warning(strcat('The method failed after i=',num2str(imax),...
            ' iterations.'));
    end
    
end