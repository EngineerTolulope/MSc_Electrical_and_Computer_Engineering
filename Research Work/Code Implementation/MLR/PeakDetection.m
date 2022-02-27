



function [DailyPeak, MonthlyPeak] = PeakDetection(testsetdt,actuals, forecast)

acttt = timetable(testsetdt, actuals(:));
predtt = timetable(testsetdt, forecast(:));


% Getting the daily peak and the time it occurred 
[group, date] = discretize(testsetdt, 'day');

% Actuals
[pks, row] = splitapply(@max, acttt, group);
DailyPeak = timetable(testsetdt(row).Hour, pks, 'RowTimes', ...
    date(1:end-1), 'VariableName', {'ActPkHr', 'ActPk'});

% Forecasts
[pks, row] = splitapply(@max, predtt, group);
DailyPeak.PredPkHr = predtt.testsetdt(row).Hour;
DailyPeak.PredPk = round(pks);

DailyPeak.TimeDiff = DailyPeak.PredPkHr - DailyPeak.ActPkHr; 
DailyPeak.ValueDiff = DailyPeak.PredPk - DailyPeak.ActPk; 

DailyPeak.APEs = 100 .* abs(DailyPeak.ValueDiff)./ abs(DailyPeak.ActPk);


%% Monthly Peak
% 
% [group, date] = discretize(DailyPeak.Time, 'month');
% 
% % Actuals
% [pks, row] = splitapply(@max, DailyPeak.ActPk, group);
% tmp = retime(DailyPeak, "monthly","max");
% tmp1 = tmp; tmp1.Time.Day = row;        % creates the day the peak happen
% 
% MonthlyPeak = timetable();
% MonthlyPeak.ActDayofPk = tmp1.Time; 
% MonthlyPeak.Time = tmp.Time;
% MonthlyPeak.ActPk = tmp.ActPk;
% 
% % Forecasts
% 
% % [pks, row] = splitapply(@max, DailyPeak.PredPk, group);
% % tmp1 = tmp; tmp1.Time.Day = row;  
% % 
% % MonthlyPeak.PredDayofPk = tmp1.Time; 
% % MonthlyPeak.PredPk = tmp.PredPk;
% 
% % MonthlyPeak.DayDiff = days(MonthlyPeak.PredDayofPk - MonthlyPeak.ActDayofPk);
% 
% MonthlyPeak.PredPkofActDay = DailyPeak.PredPk(MonthlyPeak.ActDayofPk);
% MonthlyPeak.ValueDiff = MonthlyPeak.PredPkofActDay -   MonthlyPeak.ActPk;
% MonthlyPeak.APEs = 100 .* abs(MonthlyPeak.ValueDiff)./ abs(MonthlyPeak.ActPk);
% 
% end

