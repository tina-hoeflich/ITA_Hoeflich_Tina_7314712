function df = numDiff(varargin)
%numDiff - Calculates the derivative of a given function at a given point
%          with a given numerical procedure
%
% Syntax:  output1 = numDiff('Input1Name', input1value, 'Input2Name', input2value,...
%                    'Input3Name', input3value)
%
% Inputs:
%    Function - function that should be derived
%    xValue - point where the derivative should be calculated
%    Method - numerical procedure that should be used to calculate the
%             derivative
%
% Outputs:
%    df - value of calculated derivative at point x
%
% Example: 
%    df = numDiff('Function', @MyPoly, 'xValue', 1, 'Method', 'Zentraldifferenzen')
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: myNewton.m
% Author: 7314712
% email address: inf20112@lehre.dhbw-stuttgart.de 
% April 2022; Last revision: 02.04.2022
%------------- BEGIN CODE --------------

for i = 1:nargin
    if strcmp(varargin{i}, 'Function')
        f = varargin{i+1};
    elseif strcmp(varargin{i}, 'xValue')
        x = varargin{i+1};
    elseif strcmp(varargin{i}, 'Method')
        method = varargin{i+1};  
    end
end   
   
if ~exist('f', 'var')
    error('No valid function');
end
if ~exist('x', 'var')
    error('No valid xValue')
end

switch method
    case 'Vorwärtsdifferenzen'
        h = 1e-8;
        df = (f(x+h) - f(x)) / h;
    case 'Rückwärtsdifferenzen'
        h = 1e-8;
        df = (f(x) - f(x-h)) / h;
    case 'Zentraldifferenzen'
        h = 1e-6;
        df = (f(x+h) - f(x-h)) / (2 * h);
    otherwise
        error('No valid method selected');
end
%------------- END OF CODE --------------
end