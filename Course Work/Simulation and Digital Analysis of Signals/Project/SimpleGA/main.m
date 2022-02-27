%% Population Initialization
M = 100; %Number of chromosomes
N = randi([5 10]); %Number of cells in each chromosome
x=0;
for i = 1:M
    for j=1:N
        x(j,i) = randi([-100 100]);
    end
end

%% Evaluation / Fitness Computation
iterations =50; %Number of times it should be repeated
for tmp = 1:iterations
    
    y = x.^2 - 15*x -7600; %Calculating each cell's value.
    
    y_avg = mean(y, 1); %Gets the average of each chromosome
    totaly = sum(y_avg); %Gets the total mean
    prob_fs = y_avg / totaly; %Fittness probability of each chromosome
    cumprob = cumsum(prob_fs); %Gets the cummulative probabilty
    
    %% Roulette wheel selection
    tmpx=zeros(N,M);
    for i=1:M
        rnum = rand; %Generates a random number between 0 and 1
        for j=1:M
            if rnum <= cumprob(j) %Checks through to select one for the new population
                tmpx(:,i) = x(:, j); %Copies only the column
                break;
            end
        end
    end
    x=tmpx;
    
    %% Crossover
    pc = 0.25; %Crossover rate
    CrossNum = pc * M; %Number of times to crossover
    for i=1:CrossNum
        a= randi([1 M]); %Selecting pairs to crossover
        b= randi([1 M]);
        while a==b; b= randi([1 M]); end
        
        opc = randi([2 N]); %Selecting crossover position
        tmpx = x;
        x(opc:N, a) = tmpx(opc:N, b); %Takes the tail and exchange them
        x(opc:N, b) = tmpx(opc:N, a);
    end
    
    %% Mutation
    
    
    break;
end


