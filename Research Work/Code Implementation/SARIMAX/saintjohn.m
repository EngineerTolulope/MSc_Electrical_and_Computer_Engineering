% -1 or 1 Normalization

% y = (x - min) / (max - min)
tmp = timetable2table(data);
maxdp = max(table2array(tmp(:, 2:end)));    % takes the max and min of each variable in the dataset
mindp = min(table2array(tmp(:, 2:end)));
tmp.DateTime = [];
normalize = 2.*((table2array(tmp) - mindp) ./ (maxdp - mindp)) - 1;

% creating the normalized dataset
newdata = data;
newdata.DemandMW = normalize(:, 1);
newdata.Temperature = normalize(:, 2);
newdata.Humidity = normalize(:, 3);
newdata.Dewpoint = normalize(:, 4);
newdata.WindDirection = normalize(:, 5);
newdata.WindSpeed = normalize(:, 6);

TR = timerange('2018-01-01','2019-01-01');

% For Checking Normalization
demand_minus1 = buffer(newdata.DemandMW(TR),24*7*4,24*7*4-24);
demand_minus1 = demand_minus1(:, 28:end);
temperature_minus1 = buffer(newdata.Temperature(TR),24*7*4,24*7*4-24);
temperature_minus1 = temperature_minus1(:, 28:end);

% Finds the minimum zone and it's index
avg = mean(demand_minus1);
avg = abs(avg);
[mini, index] = min(avg);
clear demand_minus1 temperature_minus1

%% Actual values we are using
% clear demand temperature
demand = buffer(ndata.DemandMW(TR),24*7*4,24*7*4-24);
demand = demand(:, 28:end);
temperature = buffer(ndata.Temperature(TR),24*7*4,24*7*4-24);
temperature = temperature(:, 28:end);

% Demand and Temperature for the model
fitd = demand(:,33);
fitd(:, 2) = temperature(:,33);

%% Getting the data ready
% w=5;Y = buffer(demandMW.DemandMW,24*7*w,24*7*w-24);

TR = timerange('2020-09-23','2021-10-20 23:00:00', "closed");

demand = buffer(ndata.DemandMW(TR),24*7*4,24*7*4-24);
demand = demand(:, 28:end);
temperature = buffer(ndata.Temperature(TR),24*7*4,24*7*4-24);
temperature = temperature(:, 28:end);

dt = datenum(ndata.DateTime(TR));
bufferdt = buffer(dt,24*7*4,24*7*4-24);
bufferdt = bufferdt(:, 28:end);

dt_table = table();
for i = 1:width(bufferdt)
    dt_table.(i) = datestr(bufferdt(:, i));
end

% TR = timerange('2018-12-31','2019-12-31');
% actual_demand = buffer(ndata.DemandMW(TR), 24); % day before's demand

TR = timerange('2020-10-20','2021-10-20 23:00:00', "closed");
actual_temp = buffer(ndata.Temperature(TR), 24);
%%  Prediction

% Model = SARIMAX_Model;

clear yARIMA
for i = 1:(width(bufferdt)-1)
    Tmp_Model = SaintJohnModeller([demand(:, i), temperature(:, i)]);
    
    yARIMA(:, i) = forecast(Tmp_Model, 24, demand(:, i), 'X0', temperature(:, i),'XF', actual_temp(:, i+1));
end


% Denormalization
actuals = testd.DemandMW * (maxdp(1) - mindp(1)) + mindp(1);
yARIMA = yARIMA(:) * (maxdp(1) - mindp(1)) + mindp(1);
[Metrics, errors, AEs, APEs, MAPE] = ErrorMetrics(actuals, yARIMA);
