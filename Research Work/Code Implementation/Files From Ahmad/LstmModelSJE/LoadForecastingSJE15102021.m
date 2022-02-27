
clear;
close all;
clc;
load HisForecastedWeather2.mat 
load HistoricTemperature2.mat 
load NewdataF2.mat 


% Read holidays dates and create the predictor
HolidayC=zeros(1, length(HisForecastedWeather2.FTemperature));

HolidaysTT=timetable(HisForecastedWeather2.DateTime,HolidayC');

%HT = readtimetable('HolidaysNBTill2025.csv');
HT = readtimetable('HolidaysNBTill2025N.csv');

% substitute zero by one on holidays dates
for i=2:length(HT.Var1)
isLeapDay = month(HolidaysTT.Time)==month(HT.Time(i)) & day(HolidaysTT.Time)==day(HT.Time(i)) & year(HolidaysTT.Time)==year(HT.Time(i)); 
HolidaysTT.Var1(isLeapDay) = 1;  % . 
end

Holi=buffer(HolidaysTT.Var1,24);

% Prediction code
% Normalizing the variables
s=1;
tmpL = timetable2table(NewdataF2);
tmpL.DateTime = [];

tmpT = timetable2table(HistoricTemperature2);
tmpT.DateTime = [];

tmpFT = timetable2table(HisForecastedWeather2); % before
tmpFT.DateTime = [];

maxdpL = max(table2array(tmpL));
mindpL = min(table2array(tmpL));

maxdpT = max(table2array(tmpT));
mindpT = min(table2array(tmpT));

maxdpFT = max(table2array(tmpFT));
mindpFT = min(table2array(tmpFT));

% y = (x - min) / (max - min)
normalizeL = (table2array(tmpL) - mindpL) ./ (maxdpL - mindpL);
normalizeT = (table2array(tmpT) - mindpT) ./ (maxdpT - mindpT);
normalizeFT = (table2array(tmpFT) - mindpFT) ./ (maxdpFT - mindpFT);

ndataL = NewdataF2;
ndataL.DemandKW = normalizeL;

ndataT = HistoricTemperature2;
ndataT.Temperature = normalizeT;

ndataFT = HisForecastedWeather2;
ndataFT.FTemperature = normalizeFT;

p=buffer(ndataL.DemandKW,24);
temp=buffer(ndataT.Temperature,24);
Ftemp=buffer(ndataFT.FTemperature,24);

d = buffer(weekday(ndataFT.DateTime),24);

d = d(1, :);

N = length(d)-s;

dcode=zeros(7,N);

for i=1:size(dcode,2)

 dcode(d(i+s),i)=1;

end

In=p(:,1:end);% correct, activate and desactivate below line

TempToday=temp(:,1:end);
TempTom=Ftemp(:,2:end);
HoliIn=Holi(:,2:end);% Holiday predictor

% Inputs Creation
%inputs = [In; TempToday;TempTom;dcode]; % original
inputs = [In; TempToday;TempTom;dcode;HoliIn]; % oNew

% Target variables
Rblf_outputs = p(:,s+1:end);

blf_outputs = p(:,s+1:end-1);

% Create training set

train_test_boundary = ceil(.75 * size(inputs,2));

% index of train samples
trainInd = 1:train_test_boundary;

% input and outputs of the training set
trainX = inputs(:,trainInd);
trainblfY = blf_outputs(:,trainInd);


% index of test samples
testInd = train_test_boundary+1:(size(inputs,2)-2);
RtestInd = train_test_boundary+1:(size(inputs,2)-1);

testX = inputs(:,testInd);
RtestX = inputs(:,RtestInd);

testblfY = blf_outputs(:,testInd);

% norm/denormalize functions
denorm = @(x,M,m)(x*(M-m)+m);
m =mindpL; M= maxdpL;


%use LSTM

numFeatures = 103; % with decode
numResponses = 24;
numHiddenUnits = 100;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];


 options = trainingOptions('adam', ...
     'MaxEpochs',300, ...
     'GradientThreshold',1, ...
     'InitialLearnRate',0.005, ...
     'LearnRateSchedule','piecewise', ...
     'LearnRateDropPeriod',125, ...
     'LearnRateDropFactor',0.2, ...
     'Verbose',0, ...
     'MiniBatchSize',24, ...
     'Shuffle','never', ...
     'ValidationPatience',10, ...
     'Plots','training-progress');


%LSTM
netLSTMblf = trainNetwork(trainX,trainblfY,layers,options);

netLSTMblf = resetState(netLSTMblf);
netLSTMblf = predictAndUpdateState(netLSTMblf,trainX);


YPredblf = [];
numTimeStepsTest = size(testX,2);
for i = 1:numTimeStepsTest
   [netLSTMblf,YPredblf(:,i)] = predictAndUpdateState(netLSTMblf,testX(:,i),'ExecutionEnvironment','cpu');
end

fLSTMblf = denorm(YPredblf, M,m);

% errors from LSTM network (each day is a column)
testY = denorm(testblfY, M,m);
eLSTMblf = fLSTMblf-testY;
apeLSTMblf = abs(eLSTMblf)./testY; 
mapeLSTMblf = mean(apeLSTMblf)*100;
mean(mapeLSTMblf)

dt= buffer(datenum(ndataL.DateTime),24);
testdt=(dt(:,testInd));
figure;
plot(datetime(datevec(testdt(:)))+days(1), fLSTMblf(:)/1000,'LineWidth',2, 'DisplayName','Forecasting'); hold on;
plot(datetime(datevec(testdt(:)))+days(1), denorm(testblfY(:),M,m)/1000,'LineWidth',2, 'DisplayName', 'Testset');
ylabel( 'Load (MW)');
legend ('show');






