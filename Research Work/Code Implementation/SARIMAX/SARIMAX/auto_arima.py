from statsmodels.tsa.arima_model import ARIMA
from statsmodels.tsa.statespace.sarimax import SARIMAX
import pmdarima as pm
import pandas as pd
import warnings
warnings.filterwarnings('ignore')

data = pd.read_csv('saintjohn.csv')
demand = data.DemandMW

# model =pm.auto_arima(demand,  test='adf', start_p=1, d=1, start_q=1, max_p=5, max_d=1, max_q=5,
#                      start_P=0, D=1, start_Q=0, max_P=2, max_D=1, max_Q=2, max_order=None, m=168, seasonal=True,
#                      stationary=False, stepwise=True, trace = True,
#                      suppress_warnings=True, error_action='ignore', return_valid_fits=True)

model =pm.auto_arima(demand, start_p=1, d=1, start_q=1, max_p=25, max_d=1, max_q=25,
                     start_P=0, D=1, start_Q=0, max_P=2, max_D=1, max_Q=2, max_order=None, m=168, seasonal=True, n_jobs = -1,
                     stationary=False, stepwise=True, trace=True, with_intercept = True,
                     suppress_warnings=True, error_action='ignore', return_valid_fits=True)

print(model.summary())

