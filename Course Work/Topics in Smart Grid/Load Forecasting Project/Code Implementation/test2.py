#!/usr/bin/env python
# coding: utf-8

import pandas as pd
from pandas import datetime
import matplotlib.pyplot as plt

train = pd.read_csv('2016-2019.csv', index_col=0, parse_dates=[0])

#Removing Outliers
for count, value in enumerate(train.P, start=0): #Can improve it.
    if value <= 100 or value >= 20000:
        train.P[count] = train.P[count-672] #Takes previous week's value
# train.to_csv('./NewData.csv') #Stores new data


train_diff = train.diff(periods=1)

#Test and train data
train = X[0:105199] #2016-2018
test = X[105199:]   #2019 remaining

# print(train)

# train.plot()
# plt.show()

from statsmodels.graphics.tsaplots import plot_acf


