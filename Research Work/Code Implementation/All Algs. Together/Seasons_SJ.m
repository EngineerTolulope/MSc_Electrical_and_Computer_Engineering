%% Winter
TR = timerange('2020-12-01','2021-02-28 23:00:00', "closed");
winter = testdata(TR, :);
predtt = timetable(testdata.DateTime, PredARIMA, eARIMA);
winter.Forecast = predtt.Var1(TR);
winter.Errors = predtt.Var2(TR);


% figure;
% tiledlayout(3,1)
% sp(1) = nexttile;
% plot(winter.DateTime, winter.DemandMW, 'DisplayName','Actuals')
% hold on
% plot(winter.DateTime, winter.Forecast, 'DisplayName','Forecasts')
% title('Winter')
% grid on
% legend('show')
% 
% sp(2) = nexttile;
% plot(winter.DateTime, winter.Errors, 'DisplayName','Errors - Forecasts - Actuals')
% grid on
% legend('show')
% 
% sp(3) = nexttile;
% plot(winter.DateTime, winter.Temperature, 'DisplayName','Temperature')
% grid on
% legend('show')
% linkaxes(sp, 'x')

mape_win = mean(abs((winter.Forecast - winter.DemandMW)./winter.DemandMW))*100;
rmse_win = sqrt(mean((winter.Forecast - winter.DemandMW).^2));

%% Spring
TR = timerange('2021-03-01','2021-05-31 23:00:00', "closed");
spring = testdata(TR, :);
%predtt = timetable(testd.DateTime, yARIMA, errors);
spring.Forecast = predtt.Var1(TR);
spring.Errors = predtt.Var2(TR);

% clear sp
% figure;
% tiledlayout(3,1)
% sp(1) = nexttile;
% plot(spring.DateTime, spring.DemandMW, 'DisplayName','Actuals')
% hold on
% plot(spring.DateTime, spring.Forecast, 'DisplayName','Forecasts')
% title('Spring')
% grid on
% legend('show')
% 
% sp(2) = nexttile;
% plot(spring.DateTime, spring.Errors, 'DisplayName','Errors - Forecasts - Actuals')
% grid on
% legend('show')
% 
% sp(3) = nexttile;
% plot(spring.DateTime, spring.Temperature, 'DisplayName','Temperature')
% grid on
% legend('show')
% linkaxes(sp, 'x')

mape_spr = mean(abs((spring.Forecast - spring.DemandMW)./spring.DemandMW))*100;
rmse_spr = sqrt(mean((spring.Forecast - spring.DemandMW).^2));

%% Summer
TR = timerange('2021-06-01','2021-08-31 23:00:00', "closed");
summer = testdata(TR, :);
% predtt = timetable(time_outputs, yRLS(:), eRLS(:));
summer.Forecast = predtt.Var1(TR);
summer.Errors = predtt.Var2(TR);

% clear sp
% figure;
% tiledlayout(3,1)
% sp(1) = nexttile;
% plot(summer.DateTime, summer.DemandMW, 'DisplayName','Actuals')
% hold on
% plot(summer.DateTime, summer.Forecast, 'DisplayName','Forecasts')
% title('Summer')
% grid on
% legend('show')
% 
% sp(2) = nexttile;
% plot(summer.DateTime, summer.Errors, 'DisplayName','Errors - Forecasts - Actuals')
% grid on
% legend('show')
% 
% sp(3) = nexttile;
% plot(summer.DateTime, summer.Temperature, 'DisplayName','Temperature')
% grid on
% legend('show')
% linkaxes(sp, 'x')

mape_sum = mean(abs((summer.Forecast - summer.DemandMW)./summer.DemandMW))*100;
rmse_sum = sqrt(mean((summer.Forecast - summer.DemandMW).^2));

%% Autumn
TR = timerange('2020-10-21','2020-11-30 23:00:00', "closed");
autumn = testdata(TR, :);
% predtt = timetable(time_outputs, yRLS(:), eRLS(:));
autumn.Forecast = predtt.Var1(TR);
autumn.Errors = predtt.Var2(TR);

 % Autumn of 2021
TR = timerange('2021-09-01','2021-10-20 23:00:00', "closed");
tmp = testdata(TR, :);
tmp.Forecast = predtt.Var1(TR);
tmp.Errors = predtt.Var2(TR);
autumn_d = [autumn; tmp];


% clear sp
% figure;
% tiledlayout(3,1)
% sp(1) = nexttile;
% plot(autumn.DateTime, autumn.DemandMW, 'DisplayName','Actuals')
% hold on
% plot(autumn.DateTime, autumn.Forecast, 'DisplayName','Forecasts')
% title('Autumn')
% grid on
% legend('show')
% 
% sp(2) = nexttile;
% plot(autumn.DateTime, autumn.Errors, 'DisplayName','Errors - Forecasts - Actuals')
% grid on
% legend('show')
% 
% sp(3) = nexttile;
% plot(autumn.DateTime, autumn.Temperature, 'DisplayName','Temperature')
% grid on
% legend('show')
% linkaxes(sp, 'x')

mape_aut = mean(abs((autumn_d.Forecast - autumn_d.DemandMW)./autumn_d.DemandMW))*100;
rmse_aut = sqrt(mean((autumn_d.Forecast - autumn_d.DemandMW).^2));
