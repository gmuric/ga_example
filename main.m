clear;
%size of the playground
n = 18;
m = 32;

%maximum number of steps
steps = 22;

%coordinates of the goal
x_goal = 1;
y_goal = 17;

%coordinates of the start
x_start = 16;
y_start = 1;

%obstacle
square = [ 0 0; 0 n; m n; m 0; 0 0;];
obstacle1 = [ 0 8; 17 8; 17 8.3; 0 9.5; 0 8; ];
obstacle3 = [32 13; 15 13; 15 10; 14.6 10; 13 15; 32 13.6; 32 13;];
obstacle = [obstacle1; [NaN NaN]; obstacle3];
%obstacle = [];

numberOfVariables = steps;
lb = ones(numberOfVariables,1)*0;        % lower bound for variable value
ub = ones(numberOfVariables,1)*pi;       % upper bound for variable value


opts = gaoptimset(...
    'PopulationSize', 30, ...
    'Generations', 500, ...
    'EliteCount', 0, ...
    'TolFun', 0.001, ...
    'StallGenLimit', 5000,...
    'MutationFcn', {@mutationuniform, 0.2},...
    'PlotFcns', @(options,state,flag) gaplotshortroute(options,state,flag,m,n,x_goal,y_goal,x_start,y_start,obstacle,square));
        
    
FitnessFunction = @(x) GA_solution_short_route(x,x_start,y_start,x_goal,y_goal,obstacle,square);

[x,Fval,exitFlag,Output] = ga(FitnessFunction,numberOfVariables, [], [], [], [], lb, ub, [], [], opts);