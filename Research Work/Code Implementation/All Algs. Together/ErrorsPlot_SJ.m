%% Average Hourly Value

APEsCNN = APEsCNN(:);
APEsLSTM = APEsLSTM(:);
APEsANN = APEsANN(:);

figure;
set(gca,'XTick',1:1:24)
grid on
hold on

% CNN
stats = grpstats(APEsCNN, ANNdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

% LSTM
stats = grpstats(APEsLSTM, ANNdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

% ANN
stats = grpstats(APEsANN, ANNdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

% MLR
stats = grpstats(APEsMLR, ARIMAdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

% ARIMA
stats = grpstats(APEsARIMA, ARIMAdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

% SNF
stats = grpstats(APEsSNF, ARIMAdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

xlabel('Daily Hours')
ylabel('MAPE Percentage Values')
legend('CNN', 'LSTM','ANN', 'MLR', 'SARIMAX', 'SNF', 'Location','best')
title('All Forecasters'' Hourly MAPE Values')
%% Average Daily Value
CANNdt = ANNdt;    % DateTime of the test dataset
Othersdt = ARIMAdt;

[dnumCANN, dnameCANN] = weekday(CANNdt, 'long');
[dnumOthers, dnameOthers] = weekday(Othersdt, 'long');
labeld = {'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'};

% actuals
figure;
set(gca,'XTick',1:1:7)
set(gca, "XTickLabel", labeld)
grid on
hold on

% CNN
stats = grpstats(APEsCNN, dnumCANN, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

% LSTM
stats = grpstats(APEsLSTM, dnumCANN, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

% ANN
stats = grpstats(APEsANN, dnumCANN, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

% MLR
stats = grpstats(APEsMLR, dnumOthers, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

% ARIMA
stats = grpstats(APEsARIMA, dnumOthers, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

% SNF
stats = grpstats(APEsSNF, dnumOthers, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

xlabel('Weekdays')
ylabel('MAPE Percentage Values')
legend('CNN', 'LSTM', 'ANN', 'MLR', 'SARIMAX', 'SNF', 'Location','best')
title('All Forecasters'' Daily MAPE Values')
%% Average Monthly Values
labelm = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug',...
          'Sep', 'Oct', 'Nov', 'Dec'};

figure;
set(gca,'XTick',1:1:12)
set(gca,'XTickLabel', labelm)
grid on
hold on

% CNN
stats = grpstats(APEsCNN, ANNdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

% LSTM
stats = grpstats(APEsLSTM, ANNdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

% ANN
stats = grpstats(APEsANN, ANNdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

% MLR
stats = grpstats(APEsMLR, ARIMAdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

% ARIMA
stats = grpstats(APEsARIMA, ARIMAdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

% SNF
stats = grpstats(APEsSNF, ARIMAdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

xlabel('Months of the Year')
ylabel('MAPE Percentage Values')
legend('CNN', 'LSTM', 'ANN', 'MLR', 'SARIMAX', 'SNF', 'Location','best')
title('All Forecasters'' Monthly MAPE Values')