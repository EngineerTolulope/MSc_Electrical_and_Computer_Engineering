

function [ErrorMetrics, errors, AEs, APEs, MAPE, STD] =  ErrorMetrics(actuals, yARIMA)

%Errors
errors = yARIMA - actuals;
AEs = abs(errors);                    % Absolute Errors
APEs = 100 .* abs(errors) ./ abs(actuals);   % Absolute Percent Errors

MAPE = mean(APEs(:));           % Mean Absolute Percent Error
ME = mean(errors(:));                 % Mean Error
MAE = mean(abs(errors(:)));           % Mean Absolute Error
MSE = mean(errors(:).^2);             % Mean Squared Error
RMSE = sqrt(MSE);               % Root Mean Squared Error
STD = std(errors(:));         % Standard Deviation


Metrics = {'MAPE - Mean Absolute Percent Error'; 'ME - Mean Error'; 'MAE - Mean Absolute Error'; 'MSE - Mean Squared Error'; 'RMSE - Root Mean Squared Error'; 'Standard Deviation'};


ErrorMetrics = table(Metrics,[MAPE; ME; MAE; MSE; RMSE; STD]);

end

