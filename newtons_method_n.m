%==========================================================================
%
% newtons_method_n  Newton's method for finding the root of a
% differentiable, multivariate, vector-valued function.
%
%   x = newtons_method_n(f,J,x0)
%   x = newtons_method_n(f,J,x0,opts)
%   [x,k] = newtons_method_n(__)
%   [x,k,x_all] = newtons_method_n(__)
%
% See also fsolve.
%
% Copyright © 2021 Tamas Kis
% Last Update: 2022-07-06
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/Root_Finding_Methods.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) multivariate, vector-valued function,
%             f(x) (f : ℝⁿ → ℝⁿ)
%   J       - (1×1 function_handle) Jacobian of f(x) (J : ℝⁿ → ℝⁿˣⁿ)
%   x0      - (n×1 double) initial guess for root
%   opts    - (OPTIONAL) (1×1 struct) solver options
%       • k_max      - (1×1 double) maximimum number of iterations 
%                      (defaults to 200)
%       • return_all - (1×1 logical) returns estimates at all iterations if
%                      set to "true"
%       • TOL        - (1×1 double) tolerance (defaults to 10⁻¹⁰)
%
% -------
% OUTPUT:
% -------
%   x       - (n×1 double) root of f(x)
%   k       - (1×1 double) number of solver iterations
%   x_all   - (n×(k+1) double) root estimates at all iterations
%
%==========================================================================
function [x,k,x_all] = newtons_method_n(f,J,x0,opts)
    
    % ----------------------------------
    % Sets (or defaults) solver options.
    % ----------------------------------
    
    % sets maximum number of iterations (defaults to 200)
    if (nargin < 4) || isempty(opts) || ~isfield(opts,'k_max')
        k_max = 200;
    else
        k_max = opts.k_max;
    end
    
    % determines if all intermediate estimates should be returned
    if (nargin < 4) || isempty(opts) || ~isfield(opts,'return_all')
        return_all = false;
    else
        return_all = opts.return_all;
    end
    
    % sets tolerance (defaults to 10⁻¹⁰)
    if (nargin < 4) || isempty(opts) || ~isfield(opts,'TOL')
        TOL = 1e-10;
    else
        TOL = opts.TOL;
    end
    
    % ----------------
    % Newton's method.
    % ----------------
    
    % dimension of x
    n = length(x0);
    
    % sets solution estimate at the first iteration of Newton's method
    % as the initial guess
    x_curr = x0;
    
    % initializes x_new so its scope isn't limited to the while loop
    x_next = zeros(n,1);
    
    % preallocates array
    if return_all
        x_all = zeros(n,k_max+1);
    end
    
    % Newton's method
    for k = 1:k_max
        
        % stores results in arrays
        if return_all
            x_all(:,k) = x_curr;
        end
        
        % solves for y
        y = J(x_curr)\(-f(x_curr));
        
        % updates root estimate
        x_next = x_curr+y;
        
        % terminates solver if converged
        if (norm(y) < TOL)
            break;
        end
        
        % stores updated root estimate for next iteration
        x_curr = x_next;
        
    end
    
    % converged root
    x = x_next;
    
    % stores converged result and trims array
    if return_all
        x_all(:,k+1) = x;
        x_all = x_all(:,1:(k+1));
    end
    
end