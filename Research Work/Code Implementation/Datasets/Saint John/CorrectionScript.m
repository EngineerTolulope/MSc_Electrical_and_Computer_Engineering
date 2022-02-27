clear all
clc
nd = readtimetable('sje_total_demand.csv');
data = readtimetable('SaintJohnEnergy.xlsx');
[tf, rows] = overlapsrange(nd, data);
over_nd = nd(rows, :);
[tf, rows] = overlapsrange(data, nd);
over_data = data(rows, :);

bias = mean(over_nd.value - over_data.DemandMW);    % mean difference

corrected = nd;
corrected.timestamp = corrected.timestamp-hours(.5);
corrected.value = corrected.value - bias;
% corrected = removevars(corrected, 'units');
newc = retime(corrected, "hourly", "linear");


figure; plot(data.DateTime, data.DemandMW)
hold on
plot(newc.timestamp, newc.value)
writetimetable(newdata, 'newSJE_corr.xlsx')