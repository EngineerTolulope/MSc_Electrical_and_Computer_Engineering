%% Winter
TR = timerange('2019-01-02','2019-02-28 23:00:00', "closed");
winter = data(TR, :);
predtt = timetable(testd.DateTime, yNaive, errors);
winter.Forecast = predtt.Var1(TR);
winter.Errors = predtt.Var2(TR);

% December
TR = timerange('2019-12-01','2019-12-31 23:00:00', "closed");
tmp = data(TR, :);
tmp.Forecast = predtt.Var1(TR);
tmp.Errors = predtt.Var2(TR);
winter_d = [winter; tmp]; % winter with December included

figure;
tiledlayout(3,1)
sp(1) = nexttile;
plot(winter.DateTime, winter.DemandMW, 'DisplayName','Actuals')
hold on
plot(winter.DateTime, winter.Forecast, 'DisplayName','Forecasts')
title('Winter')
grid on
legend('show')

sp(2) = nexttile;
plot(winter.DateTime, winter.Errors, 'DisplayName','Errors - Forecasts - Actuals')
grid on
legend('show')

sp(3) = nexttile;
plot(winter.DateTime, winter.Temperature, 'DisplayName','Temperature')
grid on
legend('show')
linkaxes(sp, 'x')

mape_win = mean(abs((winter_d.Forecast - winter_d.DemandMW)./winter_d.DemandMW))*100;
rmse_win = sqrt(mean((winter_d.Forecast - winter_d.DemandMW).^2));

%% Spring
TR = timerange('2019-03-01','2019-05-31 23:00:00', "closed");
spring = data(TR, :);
%predtt = timetable(testd.DateTime, yARIMA, errors);
spring.Forecast = predtt.Var1(TR);
spring.Errors = predtt.Var2(TR);

clear sp
figure;
tiledlayout(3,1)
sp(1) = nexttile;
plot(spring.DateTime, spring.DemandMW, 'DisplayName','Actuals')
hold on
plot(spring.DateTime, spring.Forecast, 'DisplayName','Forecasts')
title('Spring')
grid on
legend('show')

sp(2) = nexttile;
plot(spring.DateTime, spring.Errors, 'DisplayName','Errors - Forecasts - Actuals')
grid on
legend('show')

sp(3) = nexttile;
plot(spring.DateTime, spring.Temperature, 'DisplayName','Temperature')
grid on
legend('show')
linkaxes(sp, 'x')

mape_spr = mean(abs((spring.Forecast - spring.DemandMW)./spring.DemandMW))*100;
rmse_spr = sqrt(mean((spring.Forecast - spring.DemandMW).^2));

%% Summer
TR = timerange('2019-06-01','2019-08-31 23:00:00', "closed");
summer = data(TR, :);
% predtt = timetable(time_outputs, yRLS(:), eRLS(:));
summer.Forecast = predtt.Var1(TR);
summer.Errors = predtt.Var2(TR);

clear sp
figure;
tiledlayout(3,1)
sp(1) = nexttile;
plot(summer.DateTime, summer.DemandMW, 'DisplayName','Actuals')
hold on
plot(summer.DateTime, summer.Forecast, 'DisplayName','Forecasts')
title('Summer')
grid on
legend('show')

sp(2) = nexttile;
plot(summer.DateTime, summer.Errors, 'DisplayName','Errors - Forecasts - Actuals')
grid on
legend('show')

sp(3) = nexttile;
plot(summer.DateTime, summer.Temperature, 'DisplayName','Temperature')
grid on
legend('show')
linkaxes(sp, 'x')

mape_sum = mean(abs((summer.Forecast - summer.DemandMW)./summer.DemandMW))*100;
rmse_sum = sqrt(mean((summer.Forecast - summer.DemandMW).^2));

%% Autumn
TR = timerange('2019-09-01','2019-11-30 23:00:00', "closed");
autumn = data(TR, :);
% predtt = timetable(time_outputs, yRLS(:), eRLS(:));
autumn.Forecast = predtt.Var1(TR);
autumn.Errors = predtt.Var2(TR);

clear sp
figure;
tiledlayout(3,1)
sp(1) = nexttile;
plot(autumn.DateTime, autumn.DemandMW, 'DisplayName','Actuals')
hold on
plot(autumn.DateTime, autumn.Forecast, 'DisplayName','Forecasts')
title('Autumn')
grid on
legend('show')

sp(2) = nexttile;
plot(autumn.DateTime, autumn.Errors, 'DisplayName','Errors - Forecasts - Actuals')
grid on
legend('show')

sp(3) = nexttile;
plot(autumn.DateTime, autumn.Temperature, 'DisplayName','Temperature')
grid on
legend('show')
linkaxes(sp, 'x')

mape_aut = mean(abs((autumn.Forecast - autumn.DemandMW)./autumn.DemandMW))*100;
rmse_aut = sqrt(mean((autumn.Forecast - autumn.DemandMW).^2));
