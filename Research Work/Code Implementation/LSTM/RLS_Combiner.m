

function [rlsy, w] = RLS_Combiner(blfy,clfy, desired, days)
% w(1:2,1:24)=.5;    % initial weights
w(1:2, 1:24) = [0.521961241361521	0.477204640333893	0.263611615424017	0.625386649631638	0.385398752635947	0.0306188443356658	0.465936758581949	0.130150998224278	0.105062833163304	0.671613285893966	0.782040378109992	1.07545413798763	1.44473371869886	1.13744756348265	0.984734002721840	0.471261702403886	0.629735719585163	0.354372961230988	0.141487889059140	0.105839713714912	0.0394228375196602	0.218126638761378	1.08384734309604	0.663780050287519
0.485399653264810	0.545808440262799	0.735686174099227	0.383750456712370	0.612482184841822	0.943306679855383	0.490220213020724	0.834875510182764	0.867067005420858	0.297848160603828	0.184203824755722	-0.113372097885003	-0.478870966195723	-0.155958812765976	-0.00413831050316284	0.505960534208255	0.354035253626982	0.626923894044184	0.832763264650731	0.864951649484901	0.929561191737628	0.749920804319007	-0.117289973283557	0.314525932851808];

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

