% Plot of the whole dataset
figure;
% plot actual values
plot(testdata.DateTime, testdata.DemandMW, 'DisplayName','Actual Values','LineWidth', 2)
xlabel('Date and Time of Occurrence')
ylabel('Load Demand in Megawatts')
grid on; 
legend('show')

%% Specific Month Plots
% TR = timerange('2020-10-22','2021-10-20 23:00:00', "closed");
TR = timerange('2020-12-17','2020-12-21 23:00:00', "closed");

actuals = testdata.DemandMW(TR); 
dt = testdata.DateTime(TR);

PredCNN = PredCNN(:);
PredLSTM = PredLSTM(:);
PredANN = PredANN(:);

tmp = timetable(ANNdt, PredCNN, PredLSTM, PredANN);
yCNN = tmp.PredCNN(TR);
yLSTM = tmp.PredLSTM(TR);
yANN = tmp.PredANN(TR);

clear tmp
tmp = timetable(ARIMAdt, PredMLR, PredARIMA, PredSNF);
yARIMA = tmp.PredARIMA(TR);
yMLR = tmp.PredMLR(TR);
ySNF = tmp.PredSNF(TR);


figure;
% plot actual values
plot(dt, actuals, 'DisplayName','Actuals','LineWidth',2)
title('Actuals and Forecasts')
xlabel('Date and Time of Occurrence')
ylabel('Load Demand in Megawatts')
grid on; 
hold on;

% plot of forecasts
plot(dt,yCNN, 'DisplayName', 'CNN' ,'LineWidth',2)
plot(dt,yLSTM, 'DisplayName', 'LSTM','LineWidth',2)
plot(dt,yANN, 'DisplayName', 'ANN','LineWidth',2)
plot(dt,yMLR, 'DisplayName', 'MLR','LineWidth',2)
plot(dt,yARIMA, 'DisplayName', 'SARIMAX','LineWidth',2)
plot(dt,ySNF, 'DisplayName', 'SNF','LineWidth',2)

legend('show', 'Location','best')

%% Average Hourly Value
stats = grpstats(testdata.DemandMW, testdata.DateTime.Hour, "mean");
figure;
plot(stats, '-o','LineWidth',2)
set(gca,'XTick',1:1:24)
grid on
hold on

% CNN
stats = grpstats(PredCNN, ANNdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

% LSTM
stats = grpstats(PredLSTM, ANNdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

% ANN
stats = grpstats(PredANN, ANNdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

% MLR
stats = grpstats(PredMLR, ARIMAdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

% ARIMA
stats = grpstats(PredARIMA, ARIMAdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

% SNF
stats = grpstats(PredSNF, ARIMAdt.Hour, "mean");
plot(stats, '-o','LineWidth',2)

xlabel('Daily Hours')
ylabel('Average Load Demand in Megawatts')
legend('Average Hourly Values', 'CNN', 'LSTM','ANN', 'MLR', 'ARIMA', 'SNF', 'Location','best')

%% Average Daily Value
CANNdt = ANNdt;    % DateTime of the test dataset
Othersdt = ARIMAdt;

[dnumAct, dnameAct] = weekday(testdata.DateTime, 'long');
[dnumCANN, dnameCANN] = weekday(CANNdt, 'long');
[dnumOthers, dnameOthers] = weekday(Othersdt, 'long');
labeld = {'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'};

% actuals
stats = grpstats(testdata.DemandMW, dnumAct, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
figure;
plot(stats, '-o','LineWidth',2)
set(gca,'XTick',1:1:7)
set(gca, "XTickLabel", labeld)
grid on
hold on

% CNN
stats = grpstats(PredCNN, dnumCANN, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

% LSTM
stats = grpstats(PredLSTM, dnumCANN, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

% ANN
stats = grpstats(PredANN, dnumCANN, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

% MLR
stats = grpstats(PredMLR, dnumOthers, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

% ARIMA
stats = grpstats(PredARIMA, dnumOthers, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

% SNF
stats = grpstats(PredSNF, dnumOthers, "mean");
stats = [stats(2:7); stats(1)];     % aligns for Mon - Sun
plot(stats, '-o','LineWidth',2)

xlabel('Weekdays')
ylabel('Average Load Demand in Megawatts')
legend('Daily Average', 'CNN', 'LSTM', 'ANN', 'MLR', 'ARIMA', 'SNF', 'Location','best')

%% Average Monthly Values
labelm = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug',...
          'Sep', 'Oct', 'Nov', 'Dec'};
stats = grpstats(testdata.DemandMW, testdata.DateTime.Month, "mean");
figure;
plot(stats, '-o','LineWidth',2)
set(gca,'XTick',1:1:12)
set(gca,'XTickLabel', labelm)
grid on
hold on

% CNN
stats = grpstats(PredCNN, ANNdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

% LSTM
stats = grpstats(PredLSTM, ANNdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

% ANN
stats = grpstats(PredANN, ANNdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

% MLR
stats = grpstats(PredMLR, ARIMAdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

% ARIMA
stats = grpstats(PredARIMA, ARIMAdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

% SNF
stats = grpstats(PredSNF, ARIMAdt.Month, "mean");
plot(stats, '-o','LineWidth',2)

xlabel('Months of the Year')
ylabel('Average Load Demand in Megawatts')
legend('Actuals', 'CNN', 'LSTM', 'ANN', 'MLR', 'ARIMA', 'SNF', 'Location','best')