function [xZero, abortFlagg, iters] = myNewton(varargin)
%myNewton - Calculates zero of a given function using the NewtonRaphson
%           procedure
%
% Syntax:  [output1, output2, output3] = myNewton('Input1Name', input1value, 'Input2Name', input2value,...
%                    'Input3Name', input3value, 'Input4Name', input4value, 'Input5Name', input5value,...
%                    'Input6Name', input6value, 'Input7Name', input7value)
%                    --number of input variables may vary--
%
% Inputs:
%    Function - function that the zero should be calculated of
%    Derivative - derivative of function that the zero should be calculated of
%    StartValue - start value for first iteration
%    MaxIter - max. number of iterations 
%    Feps - accuracy of abort criteria
%    Xeps - accuracy of abort criteria
%    LivePlot - indicates waether the calculation should be visualized
%
% Outputs:
%    xZero - calculated zero of the given function
%    abortFlagg - abort criteria responsible for breaking the loop
%    iters - number of iterations needed to calculate the zero
%
% Example: 
%    [xZero, abortFlagg, iters] = myNewton('Function', @MyPoly, 'LivePlot', 'on');
%
% Other m-files required: numDiff.m
% Subfunctions: none
% MAT-files required: none
%
% See also: numDiff.m
% Author: 7314712
% email address: inf20112@lehre.dhbw-stuttgart.de 
% April 2022; Last revision: 02.04.2022
%------------- BEGIN CODE --------------

for i = 1:nargin
    % input argument handling
    if strcmp(varargin{i}, 'Function')
        func = varargin{i+1};
    elseif strcmp(varargin{i}, 'Derivative')
        dfunc = varargin{i+1};
    elseif strcmp(varargin{i}, 'StartValue')
        x0 = varargin{i+1};
    elseif strcmp(varargin{i}, 'MaxIter')
        maxIter = varargin{i+1};
    elseif strcmp(varargin{i}, 'Feps')
        feps = varargin{i+1};
    elseif strcmp(varargin{i}, 'Xeps')
        xeps = varargin{i+1};
    elseif strcmp(varargin{i}, 'LivePlot')
        livePlot = varargin{i+1};
    end
end

% throwing an error if the function is missing 
if ~exist('func','var')
    error('No valid function');
end

% using default values for missing params
if ~exist('x0','var')
    x0 = 0;
    disp('Using default StartValue (x0 = 0)');
end
if ~exist('maxIter','var')
    maxIter = 50;
    disp('Using default MaxIter (maxIter = 50)');
end
if ~exist('feps','var')
    feps = 1e-6;
    disp('Using default Feps (feps = 1e-6)');
end
if ~exist('xeps','var')
    xeps = 1e-6;
    disp('Using default Xeps (xeps = 1e-6)');
end
if ~exist('livePlot','var')
    livePlot = 'off';
    disp('Using default livePlot (livePlot = off');
end

if ~exist('dfunc','var')
    % choosing numerical procedure
    method = questdlg('Which numerical procedure should be used?',...
        'Numerical procedure',...
        'Vorwärtsdifferenzen', 'Rückwärtsdifferenzen', 'Zentraldifferenzen',... 
        'Vorwärtsdifferenzen');
    display(append('Calculating derivative using ', method));
end



% Start of algorithm
if strcmp(livePlot, 'on')
    h = figure('Name', 'Newton Visualization');
    ax1 = subplot(2,1,1);
    plot(ax1,0,x0,'bo');
    ylabel('xValue');
    hold on;
    grid on;
    xlim('auto');
    ylim('auto');
    ax2 = subplot(2,1,2);
    semilogy(ax2,0,func(x0),'rx');
    ylabel('Function Value');
    hold on;
    grid on;
    xlim('auto');
    ylim('auto');
end

xOld = x0;
abortFlagg = 'maxIter';
for i = 1:maxIter
    f = func(xOld);
    if f < feps
        abortFlagg = 'feps';
        break;
    end
    
    if exist('method','var')
        df = numDiff('Function', func, 'xValue', xOld, 'Method', method);
    else
        df = dfunc(xOld);
    end
    
    if f == 0
        abortFlagg = 'df is zero';
        break;
    end
    xNew = xOld - f/df;
    if abs(xOld-xNew) < xeps
        abortFlagg = 'xeps';
        break;
    end
    xOld = xNew;
    if strcmp(livePlot, 'on')
        plot(ax1, i, xNew, 'bo');
        semilogy(ax2, i, func(xNew), 'rx');
    end
end
iters = i;
xZero = xNew;
%------------- END OF CODE --------------
end