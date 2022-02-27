

function [ErrorMetrics, eBLF, blf_AEs, blf_APEs, eCLF, clf_AEs, clf_APEs,...
         eRLS, rls_AEs, rls_APEs, blf_MAPE, clf_MAPE, rls_MAPE, blf_STD, clf_STD, rls_STD] = ...
         ErrorMetrics(actuals, yBLF, yCLF, yRLS)

%BLF errors
eBLF = yBLF - actuals;
blf_AEs = abs(eBLF);                    % blf Absolute Errors
blf_APEs = 100 .* abs(eBLF) ./ abs(actuals);   % blf Absolute Percent Errors

blf_MAPE = mean(blf_APEs(:));           % blf Mean Absolute Percent Error
blf_ME = mean(eBLF(:));                 % blf Mean Error
blf_MAE = mean(abs(eBLF(:)));           % blf Mean Absolute Error
blf_MSE = mean(eBLF(:).^2);             % blf Mean Squared Error
blf_RMSE = sqrt(blf_MSE);               % blf Root Mean Squared Error


% CLF errors
eCLF = yCLF - actuals;
clf_AEs = abs(eCLF);                    % clf absolute errors
clf_APEs = 100*(abs(eCLF) ./ abs(actuals)); % clf Absolute Percent Errors

clf_MAPE = mean(clf_APEs(:));     % clf Mean Absolute Percent Error
clf_ME = mean(eCLF(:));                 % clf Mean Error
clf_MAE = mean(abs(eCLF(:)));           % clf Mean Absolute Error
clf_MSE = mean(eCLF(:).^2);             % clf Mean Squared Error
clf_RMSE = sqrt(clf_MSE);               % clf Root Mean Squared Error

% RLS errors
eRLS = yRLS - actuals;
rls_AEs = abs(eRLS);                    % rls absolute errors
rls_APEs = 100 * (abs(eRLS) ./ abs(actuals));   % rls absolute percent errors

rls_MAPE = mean(rls_APEs(:));        % rls Mean Absolute Percent Error
rls_ME = mean(eRLS(:));                 % rls Mean Error
rls_MAE = mean(abs(eRLS(:)));           % rls Mean Absolute Error
rls_MSE = mean(eRLS(:).^2);             % rls Mean Squared Error
rls_RMSE = sqrt(rls_MSE);               % rls Root Mean Squared Error

% Standard Deviation
blf_STD = std(eBLF(:));
clf_STD = std(eCLF(:));
rls_STD = std(eRLS(:));


Metrics = {'MAPE - Mean Absolute Percent Error'; 'ME - Mean Error'; 'MAE - Mean Absolute Error'; 'MSE - Mean Squared Error'; 'RMSE - Root Mean Squared Error'; 'Standard Deviation'};
BLF = [blf_MAPE; blf_ME; blf_MAE; blf_MSE; blf_RMSE; blf_STD];
CLF = [clf_MAPE; clf_ME; clf_MAE; clf_MSE; clf_RMSE; clf_STD];
RLS = [rls_MAPE; rls_ME; rls_MAE; rls_MSE; rls_RMSE; rls_STD];

ErrorMetrics = table(Metrics,BLF, CLF, RLS);
end

