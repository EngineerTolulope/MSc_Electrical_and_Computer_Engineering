# scipy
import scipy

print(('scipy: {}'.format(scipy.__version__)))
# numpy
import numpy

print(('numpy: {}'.format(numpy.__version__)))
# matplotlib
import matplotlib

print(('matplotlib: {}'.format(matplotlib.__version__)))
# pandas
import pandas

print(('pandas: {}'.format(pandas.__version__)))
# scikit-learn
import sklearn

print(('sklearn: {}'.format(sklearn.__version__)))
# statsmodels
import statsmodels

print(('statsmodels: {}'.format(statsmodels.__version__)))

from pandas import read_csv

# series = read_csv('robberies.csv', header=0, index_col=0)
# split_point = len(series) - 12
# dataset, validation = series[0:split_point], series[split_point:]
# print('\nDataset %d, Validation %d' % (len(dataset), len(validation)))
# dataset.to_csv(
#     'dataset.csv')  # <span class="crayon-sy">,</span> <span class="crayon-v">index</span><span class="crayon-o">=</span><span class="crayon-t">False</span>)
# validation.to_csv(
#     'validation.csv')  # <span class="crayon-sy">,</span> <span class="crayon-v">index</span><span class="crayon-o">=</span><span class="crayon-t">False</span>)

# Performance Measure, using root mean squared error
"""
from sklearn.metrics import mean_squared_error
from math import sqrt
...
test = ...
predictions = ...
mse = mean_squared_error(test, predictions)
rmse = sqrt(mse)
print('RMSE: %.3f' % rmse)  """

# Persistence
from pandas import read_csv
from sklearn.metrics import mean_squared_error
from math import sqrt

# load data
series = read_csv('dataset.csv')
# prepare data
X = series.values
# X = X.astype('float32')
train_size = int(len(X) * 0.50)
train, test = X[0:train_size], X[train_size:]
# walk-forward validation
history = [x for x in train]
predictions = list()
for i in range(len(test)):
    # predict
    yhat = history[-1]
    predictions.append(yhat)
    # observation
    obs = test[i]
    history.append(obs)
    print(('>Predicted={}, Expected={}'.format(yhat, obs)))
# report performance
mse = mean_squared_error(test, predictions)
rmse = sqrt(mse)
print(('RMSE: %.3f' % rmse))


from pandas import read_csv
from statsmodels.tsa.stattools import adfuller

# create a differe
def difference(dataset):
	diff = list()
	for i in range(1, len(dataset)):
		value = dataset[i] - dataset[i - 1]
		diff.append(value)
	return Series(diff)

series = read_csv('dataset.csv')
X = series.values
# difference data
stationary = difference(X)
stationary.index = series.index[1:]
# check if stationary
result = adfuller(stationary)
print('ADF Statistic: %f' % result[0])
print('p-value: %f' % result[1])
print('Critical Values:')
for key, value in result[4].items():
	print('\t%s: %.3f' % (key, value))
# save
stationary.to_csv('stationary.csv')