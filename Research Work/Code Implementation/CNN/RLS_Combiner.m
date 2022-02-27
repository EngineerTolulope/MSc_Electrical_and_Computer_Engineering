

function [rlsy, w] = RLS_Combiner(blfy,clfy, desired, days)
% w(1:2,1:24)=.5;    % initial weights
w(1:2, 1:24) = [0.310745298862457	0.0796960145235062	0.455042451620102	1.11004221439362	0.943485379219055	0.122264757752419	0.427012532949448	0.651972413063049	0.748573660850525	0.582474827766419	0.161534935235977	0.367083877325058	-0.0434319861233234	0.193424731492996	0.187132686376572	0.474081635475159	0.444336563348770	0.213111862540245	0.0435031205415726	0.309437692165375	0.110052980482578	0.0734146386384964	0.0259034037590027	0.0877933204174042
0.685727536678314	0.958507001399994	0.577628374099731	-0.103254579007626	0.0657880976796150	0.871284782886505	0.572845101356506	0.376889288425446	0.272698819637299	0.428374409675598	0.838447451591492	0.630982995033264	1.04192221164703	0.803450584411621	0.795704603195190	0.510789275169373	0.533048033714294	0.760622918605804	0.925854861736298	0.664557218551636	0.868358492851257	0.915697395801544	0.946122169494629	0.877092123031616];

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

