

function [rlsy, w] = RLS_Combiner(blfy,clfy, desired, days)
% w(1:2,1:24)=.5;    % initial weights
w(1:2,1:24)= [0.477309035321960,0.566437142643893,0.689323853218899,0.535896470012872,0.913243014740891,0.637105846440382,0.777949574660977,0.432520783597853,0.621755366436380,0.788978632891834,0.587775207045141,0.857977978356652,1.00410839754759,0.519925582821206,0.646357937259556,0.661432232183889,0.293040101082991,0.430908174745121,0.534638411703580,0.681918916166269,0.509598928359644,0.450370576384189,0.237432282169999,0.561842993954541;0.526955621993791,0.455637877239674,0.350095775277259,0.484483039206308,0.101544573843911,0.371765130696894,0.224445121627421,0.571374164784746,0.373535401677161,0.213096970408406,0.404871791911145,0.129819508805373,-0.0122691340821467,0.481935833335032,0.352356440516095,0.327183924971856,0.690840781045291,0.555903851433353,0.449285647592192,0.288243608293750,0.453524744766652,0.529264853292425,0.726121881860711,0.421973560207706];    % initial weights

delta = .00001; % small positive constant for high SNR
% large positive constant for low SNR

P = cell(1,24);     % creates a cell array to store default P values
P(1,1:24) = {eye(2)/delta};
lambda=.98;     % forgetting factor

% created based on the rls formula
for hr = 1:24
    for day =1:days
        u = [blfy(hr, day); clfy(hr, day)];  % blf and clf forecasts. u=[blf;clf];
        
        knum=P{hr} * u/lambda;
        kden=1+u' * knum;
        k=knum/kden;
        
        d= desired(hr,day); % desired(1,1);  %actual_value_of_load
        dhat = w(:,hr)' * u;    % new prediction
        e(1,hr)= d - dhat;     % error
        w(:,hr) = w(:,hr) + k * e(:, hr);   % new weight
        
        P{hr} = (P{hr}/lambda) - (k*u'*P{hr}/lambda);
        
        rlsy(hr, day) = dhat;   % the output of the combiner
    end
end

end

