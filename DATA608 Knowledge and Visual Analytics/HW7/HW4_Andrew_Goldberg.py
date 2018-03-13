import pandas as pd
import numpy as np
from bokeh.charts import output_notebook, show, Bar, TimeSeries, Scatter
from bokeh.layouts import row
from bokeh.plotting import figure, output_file, show
from bokeh.charts.attributes import CatAttr
from bokeh.palettes import Blues8, brewer, Viridis, grey
import matplotlib.pyplot as plt
output_notebook()

hudData = pd.read_csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture4/Data/riverkeeper_data_2013.csv")

hudData['Date'] = pd.to_datetime(hudData['Date'])
hudData = hudData.assign(Symbols = hudData['EnteroCount'].str.extract('([<>])'))
hudData = hudData.assign(EnteroCountNum = hudData['EnteroCount'].str.extract('([1234567890]+)'))
hudData

q1Data = hudData.sort_values(by='Date', ascending = False).drop_duplicates(['Site'])
q1Data['EnteroCountNum'] = pd.to_numeric(q1Data['EnteroCountNum'])
q1Data

#hudData['Date'] = pd.to_datetime(hudData['Date'])
#q1Data = hudData.sort_values(by='Date', ascending = False).drop_duplicates(['Site'])
#q1Data = q1Data.assign(Symbols = q1Data['EnteroCount'].str.extract('([<>])'))
#q1Data = q1Data.assign(EnteroCountNum = q1Data['EnteroCount'].str.extract('([1234567890]+)'))
#q1Data['EnteroCountNum'] = pd.to_numeric(q1Data['EnteroCountNum'])

topSites = q1Data.sort(['EnteroCountNum'], ascending = False).head(10)
botSites = q1Data.sort(['EnteroCountNum'], ascending = True).head(10)
bwSites = pd.concat([topSites, botSites])

bestSites = Bar(topSites, label=CatAttr(columns=['Site'], sort=False), values='EnteroCountNum', ylabel='Entero Bacteria Count', xlabel='Watershed Site', title = 'Best places to swim', legend=False, color='green')
show(bestSites)

worstSites = Bar(botSites, label=CatAttr(columns=['Site'], sort=False), values='EnteroCountNum', ylabel='Entero Bacteria Count', xlabel='Watershed Site', title = 'Worst places to swim', legend=False, color='red')
show(worstSites)

earliest = hudData['Date'].min()
latest = hudData['Date'].max()
rng = pd.date_range(start=earliest, end=latest, freq='M')
#q2Data = hudData.assign(DateRange = hudData['EnteroCount'].str.extract('([<>])'))
DateMarker = [0]*((hudData['Date'].count()))
q2Data = hudData
q2Data['DateMarker'] = DateMarker

for i in q2Data.index.tolist():
    for j in rng:
       if (pd.date_range(start=j, periods=4, freq='M'))[0] <= q2Data['Date'][i] <= (pd.date_range(start=j, periods=4, freq='M'))[1]:
            q2Data.DateMarker[i] = j

sites = ['Gowanus Canal', 'Hudson above Mohawk River', 'Wappingers Creek', 'Upper Sparkill Creek', 'Saw Mill River', 'Newburgh Launch Ramp']
q2DataCut = q2Data[q2Data['Site'].isin(sites)]
#q2DataCut = q2DataCut.sort_values('EnteroCountNum')
vir = Viridis[256]
ts2 = TimeSeries(q2DataCut,
                x='Date', y='Site',
                color='Site', dash='Site', builder_type='point', title="Timeseries Points", ylabel='Watershed', xlabel='Dates of Water Quality Tests', legend=False)
show(ts2)

#sites = ['Gowanus Canal', 'Hudson above Mohawk River', 'Wappingers Creek', 'Upper Sparkill Creek', 'Saw Mill River', 'Newburgh Launch Ramp']
#q2DataCut = q2Data[q2Data['Site'].isin(sites)]
#plot = figure(width=300, height=300)
#plot.circle(x=q2DataCut.Date, y=q2DataCut['Site'], size=5)
#show(plot)
#ts2 = TimeSeries(q2DataCut,
#                x='Date', y='Site',
#                color='EnteroCountNum', dash='Site', fill_color='Blues8', builder_type='point', title="Timeseries Points", ylabel='Entero Count', xlabel='Dates of Water Quality Tests', legend=False)
#show(ts2)

#Bokeh
q3Scatter = Scatter(hudData, x='EnteroCountNum', y='FourDayRainTotal')
show(q3Scatter)

hudData['EnteroCountNum'] = pd.to_numeric(hudData['EnteroCountNum'])

import seaborn as sns
%matplotlib inline
sns.pairplot(hudData, x_vars=['EnteroCountNum'], y_vars=['FourDayRainTotal'], size = 7, aspect=.7, kind='reg')
hud1 = sns.regplot(x="EnteroCountNum", y="FourDayRainTotal", data=hudData)
q2DataCut['EnteroCountNum'] = pd.to_numeric(q2DataCut['EnteroCountNum'])
q3b = sns.FacetGrid(q2DataCut, col="Site")
g3b = q3b.map(sns.regplot, 'EnteroCountNum', 'FourDayRainTotal')