#!/usr/bin/enjuyv python
# coding: utf-8
# # Time Series Forescasting
# In[16]:
import pandas as pd
from pandas import datetime
import matplotlib.pyplot as plt


# In[13]:
def parser(x):
    return datetime.strptime(x, '%Y-%m')


sales = pd.read_csv('sales-cars.csv', index_col=0, parse_dates=[0], date_parser=parser)
# In[14]:
sales.head()
# In[12]:
sales.Month[1]
# In[17]:
sales.plot()
# Stationary means mean, variance and covariance is constant over periods.
# In[23]:
from statsmodels.graphics.tsaplots import plot_acf

plot_acf(sales)
# In[ ]:
# In[ ]:
# ### Converting series to stationary
# In[ ]:
# In[18]:
sales.head()
# In[24]:
sales.shift(1)
# In[20]:
sales_diff = sales.diff(periods=1)
# integrated of order 1, denoted by d (for diff), one of the parameter of ARIMA model
# In[22]:
sales_diff = sales_diff[1:]
sales_diff.head()
# In[25]:
plot_acf(sales_diff)
# In[26]:
sales_diff.plot()
# In[70]:
X = sales.values
train = X[0:27]  # 27 data as train data
test = X[26:]  # 9 data as test data
predictions = []
# In[63]:
train.size
# # Autoreggresive AR Model
# In[ ]:
# In[41]:
from statsmodels.tsa.ar_model import AR
from sklearn.metrics import mean_squared_error

model_ar = AR(train)
model_ar_fit = model_ar.fit()
# In[50]:
predictions = model_ar_fit.predict(start=26, end=36)
# In[51]:
test
# In[52]:
plt.plot(test)
plt.plot(predictions, color='red')
# In[49]:
sales.plot()
# # ARIMA model
# In[53]:
from statsmodels.tsa.arima_model import ARIMA

# In[102]:
# p,d,q  p = periods taken for autoregressive model
# d -> Integrated order, difference
# q periods in moving average model
model_arima = ARIMA(train, order=(9, 2, 0))
model_arima_fit = model_arima.fit()
print(model_arima_fit.aic)
# In[103]:
predictions = model_arima_fit.forecast(steps=10)[0]
predictions
# In[104]:
plt.plot(test)
plt.plot(predictions, color='red')
# In[97]:
mean_squared_error(test, predictions)
# In[82]:
import itertools

p = d = q = range(0, 5)
pdq = list(itertools.product(p, d, q))
pdq
# In[86]:
import warnings

warnings.filterwarnings('ignore')
for param in pdq:
    try:
        model_arima = ARIMA(train, order=param)
        model_arima_fit = model_arima.fit()
        print(param, model_arima_fit.aic)
    except:
        continue
# In[ ]:
