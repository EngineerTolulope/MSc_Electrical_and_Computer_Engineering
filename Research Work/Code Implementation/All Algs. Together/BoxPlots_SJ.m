CANNdt = ANNdt;    % DateTime of the test dataset
Othersdt = ARIMAdt;

%% Overall box plots
eCNN = eCNN(:); eLSTM = eLSTM(:); eANN = eANN(:); 
reMLR = eMLR(25:end); reARIMA = eARIMA(25:end); reSNF = eSNF(25:end);  % reduced errors

errors = [eCNN, eLSTM, eANN, reMLR, reARIMA, reSNF];
label = {'CNN', 'LSTM', 'ANN', 'MLR', 'SARIMAX', 'SNF'};

figure;
% bh = boxplot(errors, label);
% set(bh,'LineWidth', 2);
boxplot(errors, label)
grid
xlabel('The Algorithms')
ylabel('Errors (Forecasts - Actuals) in MW')
title('Each Forecaster''s Error Distribution')
%% Hourly Distribution Boxplot
CANNtime24 = ANNdt.Hour + 1; % Time = 1...24 hrs
Otherstime24 = ARIMAdt.Hour + 1;

errors = [eCNN(:), eLSTM(:), eANN(:)];
maxy = max(errors(:));
miny = min(errors(:));

figure;
% ylim([min max])
% hold on
% % ylim('manual')

boxplot(eCNN, CANNtime24);
grid
title("The CNN Forecaster")
xlabel('Daily Hours')
ylabel('Errors in Megawatts')
ylim([miny maxy])


boxplot(eLSTM, CANNtime24);
grid
xlabel('Daily Hours')
ylabel('Errors in Megawatts')
title("The LSTM Forecaster")
ylim([miny maxy])


boxplot(eANN, CANNtime24)
grid
xlabel('Daily Hours')
ylabel('Errors in Megawatts')
title("The ANN Forecaster")
ylim([miny maxy])


boxplot(eMLR, Otherstime24)
grid
xlabel('Daily Hours')
ylabel('Errors in Megawatts')

boxplot(eARIMA, Otherstime24)
grid
xlabel('Daily Hours')
ylabel('Errors in Megawatts')

boxplot(eSNF, Otherstime24)
grid
xlabel('Daily Hours')
ylabel('Errors in Megawatts')
%% Daily Distribution Boxplot

[dnumCANN, dnameCANN] = weekday(CANNdt, 'long');
[dnumOthers, dnameOthers] = weekday(Othersdt, 'long');
label = {'Mon', 'Tues', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'};

xtick = [7,1,2,3,4,5,6];    % the position we want them displayed as, i.e Mon - Sun

figure;
boxplot(eCNN, dnumCANN,'positions', xtick)
set(gca, 'XTickLabel', label)
grid
xlabel('Weekdays')
ylabel('Errors in Megawatts')
title("The CNN Forecaster")
ylim([miny maxy])



figure;
boxplot(eLSTM, dnumCANN,'positions', xtick)
set(gca, 'XTickLabel', label)
grid
xlabel('Weekdays')
ylabel('Errors in Megawatts')
title("The LSTM Forecaster")
ylim([miny maxy])



figure;
boxplot(eANN, dnumCANN,'positions', xtick)
set(gca, 'XTickLabel', label)
grid
xlabel('Weekdays')
ylabel('Errors in Megawatts')
title("The ANN Forecaster")
ylim([miny maxy])


figure;
boxplot(eMLR, dnumOthers,'positions', xtick)
set(gca, 'XTickLabel', label)
grid
xlabel('Weekdays')
ylabel('Errors in Megawatts')

figure;
boxplot(eARIMA, dnumOthers,'positions', xtick)
set(gca, 'XTickLabel', label)
grid
xlabel('Weekdays')
ylabel('Errors in Megawatts')

figure;
boxplot(eSNF, dnumOthers,'positions', xtick)
set(gca, 'XTickLabel', label)
grid
xlabel('Weekdays')
ylabel('Errors in Megawatts')
%% Monthly Distribution Boxplot
label = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug',...
          'Sep', 'Oct', 'Nov', 'Dec'};

figure;
boxplot(eCNN, CANNdt.Month,'labels', label)
grid
xlabel('Months of the Year')
ylabel('Errors in Megawatts')
title("The CNN Forecaster")
ylim([miny maxy])


boxplot(eLSTM, CANNdt.Month,'labels', label)
grid
xlabel('Months of the Year')
ylabel('Errors in Megawatts')
title("The LSTM Forecaster")
ylim([miny maxy])



boxplot(eANN, CANNdt.Month,'labels', label)
grid
xlabel('Months of the Year')
ylabel('Errors in Megawatts')
title("The ANN Forecaster")
ylim([miny maxy])


boxplot(eMLR, Othersdt.Month,'labels', label)
grid
xlabel('Months of the Year')
ylabel('Errors in Megawatts')


boxplot(eSNF, Othersdt.Month,'labels', label)
grid
xlabel('Months of the Year')
ylabel('Errors in Megawatts')

%% Seasonal Distribution Boxplot
% CANN_errors = testdata(CANNdt, "DemandMW");
% CANN_errors = removevars(CANN_errors, 'DemandMW');
% CANN_errors.eCNN = eCNN;
% CANN_errors.eANN = eANN;
% 
% % Winter
% TR = timerange('2019-01-02','2019-02-28 23:00:00', "closed");
% first = CANN_errors(TR, :);
% TR = timerange('2019-12-01','2019-12-31 23:00:00', "closed");
% second = CANN_errors(TR, :);
% CANN_winter = [first; second];
% 
% % Spring
% TR = timerange('2019-03-01','2019-05-31 23:00:00', "closed");
% CANN_spring = CANN_errors(TR, :);
% 
% % Summer
% TR = timerange('2019-06-01','2019-08-31 23:00:00', "closed");
% CANN_summer = CANN_errors(TR, :);
% 
% % Autumn / Fall
% TR = timerange('2019-09-01','2019-11-30 23:00:00', "closed");
% CANN_autumn = CANN_errors(TR, :);
% 
% label = {'CNN', 'ANN', 'MLR', 'ARIMA', 'SNF'};
% errorsCNN = [CANN_winter.eCNN, CANN_spring.eCNN, CANN_summer.eCNN, CANN_autumn.eCNN];
% % Can't do boxplots of this because of they are not the same lengths
