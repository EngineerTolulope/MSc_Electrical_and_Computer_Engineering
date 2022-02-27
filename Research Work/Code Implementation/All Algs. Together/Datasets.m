toronto = readtimetable('../Datasets/Ontario/TorontoIESO.xlsx');
ottawa = readtimetable('../Datasets/Ontario/OttawaIESO.xlsx');
saintjohn = readtimetable('../Datasets/Saint John/SaintJohnEnergy.xlsx');

TR = timerange('2019-01-01','2020-01-01');  % All of 2019
toronto = toronto(TR, :);   % testing data 
ottawa = ottawa(TR, :);   % testing data 
saintjohn = saintjohn(TR, :);   % testing data 

toronto = retime(toronto, 'daily', 'mean');
ottawa = retime(ottawa, 'daily', 'mean');
saintjohn = retime(saintjohn, 'daily', 'mean');

figure;
t = tiledlayout(3,1);
t.Padding = 'compact';     % uses all the spaces in the figure window
t.TileSpacing = 'tight';
sp(1) = nexttile(1);
plot(toronto.DateTime, toronto.DemandMW, 'DisplayName','Toronto Dataset')%,'LineWidth', 2)
grid on;
title('Toronto Dataset')
xlabel('Date and Time of Occurrence')
ylabel('Load Demand (MW)')

sp(2) = nexttile(2);
plot(ottawa.DateTime, ottawa.DemandMW, 'DisplayName','Ottawa Dataset')%,'LineWidth', 2)
grid on;
title('Ottawa Dataset')
xlabel('Date and Time of Occurrence')
ylabel('Load Demand (MW)')

sp(3) = nexttile(3);
plot(saintjohn.DateTime, saintjohn.DemandMW, 'DisplayName','Saint John Dataset')%,'LineWidth', 2)
grid on;
title('Saint John Dataset')
xlabel('Date and Time of Occurrence')
ylabel('Load Demand (MW)')
