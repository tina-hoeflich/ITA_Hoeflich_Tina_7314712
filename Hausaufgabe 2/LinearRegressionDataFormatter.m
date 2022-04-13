classdef LinearRegressionDataFormatter < matlab.mixin.SetGet
%% DATAPRERPERATOR Class to model the training data for lineare
%regression model object
%
% Example: 
% see: runScript.m
% 
% See also: LinearRegressionModel.m, GradientDescentOptimizer.m
% Author: Jannik Wiessler, 7314712
% email address: inf20112@lehre.dhbw-stuttgart.de, jannik.wiessler@daimler.com
% April 2022; Last revision: 13.04.2022
%%
%------------- BEGIN CODE --------------

    properties (Access = public)
        feature
        featureName
        commandVar
        commandVarName
        numOfSamples
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        function obj = LinearRegressionDataFormatter(varargin)
            %DATAPRERPERATOR Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            % perform the varargin
            for i = 1:length(varargin)
                if strcmp(varargin{i},'Data')
                   obj.data = importdata(varargin{i + 1});
                elseif strcmp(varargin{i},'Feature')
                    obj.featureName = varargin{i + 1};
                elseif strcmp(varargin{i},'CommandVar')
                    obj.commandVarName = varargin{i + 1};
                end %if
            end %for 
            
            
            obj.mapFeature();
            obj.mapCommandVar();
            obj.mapNumOfSamples();
        end
    end
    
    methods (Access = private)
        function mapFeature(obj)
            obj.feature = obj.data.(obj.featureName);
        end
        
        function mapCommandVar(obj)
            obj.commandVar = obj.data.(obj.commandVarName);
        end
        
        function mapNumOfSamples(obj)
           obj.numOfSamples = length(obj.feature); 
        end
    end
end

