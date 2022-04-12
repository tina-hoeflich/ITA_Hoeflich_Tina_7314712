classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL 
    % Class representing an implementation of linear regression model
    
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            %LINEARREGRESSIONMODEL Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            % perform varargin
            for i = 1:length(varargin)
                if strcmp(varargin{i},'Data')
                   obj.trainingData = varargin{i + 1};
                elseif strcmp(varargin{i},'Optimizer')
                    obj.optimizer = varargin{i + 1};
                end %if
            end %for 
            
            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            m = obj.trainingData.numOfSamples; 
            
            % ========= YOUR CODE HERE =========
            % compute the costs
            % therefore use the hypothesis function as well
            % returns the cost value J
            J = (1 / (2*m)) * sum((obj.hypothesis() - obj.trainingData.commandVar).^2);
            
        end
        
        function hValue = hypothesis(obj)
            X = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature];
            
            % ========= YOUR CODE HERE =========
            % compute hypothesis values for each sample
            % therefore compute the matrix multiplication with X
            
            hValue = obj.theta(1) + obj.theta(2) * X(:,2);
            % oder: hValue = X * obj.theta 
           
            
            
            
        end
        
        function h = showOptimumInContour(obj)
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            cost_tuple = zeros(length(theta0_vals),length(theta1_vals));
            for k = 1:length(theta0_vals) 
                for i = 1:length(theta1_vals)
                    obj.setTheta(theta0_vals(k),theta1_vals(i));
                    cost_tuple(i,k) = obj.costFunction(); 
                end%for i
            end%for k
            
            % plot the costs with the contour command
            contour(theta0_vals,theta1_vals,cost_tuple);
            
            % adding x and y label
            xlabel('\theta_0');
            ylabel('\theta_1');
            
            % adding the optimum theta value to the plot (red X, MarkerSize: 10, LineWidth: 2)
            hold on
            plot(obj.thetaOptimum(1),obj.thetaOptimum(2),'rx','MarkerSize',10,'LineWidth',2);
            
        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
           
       
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            cost_tuple = zeros(length(theta0_vals),length(theta1_vals));
            for k = 1:length(theta0_vals) 
                for i = 1:length(theta1_vals)
                    obj.setTheta(theta0_vals(k),theta1_vals(i));
                    cost_tuple(i,k) = obj.costFunction(); 
                end%for i
            end%for k
            
           % plot the costs with the surf command
           surf(theta0_vals,theta1_vals,cost_tuple);
           
           % adding x and y label
           xlabel('\theta_0');
           ylabel('\theta_1');

        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");

        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           
           % ========= YOUR CODE HERE =========
           % adding the final trained model plot to the figure ('b-')
           % update the legend
           hold on
           plot(obj.trainingData.feature,(obj.theta(1) + obj.theta(2).*obj.trainingData.feature),'b-');
           legend('Training Data','Linear Regression Model')
           hold off
        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end


