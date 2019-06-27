# Lab 2 - Getting external data using Logic App

## Introduction

During this lab we will create a Logic App to download weather data from an Internet API. This data will later be used to enrich the sales data we imported with Data Factory in the first lab.
In the logic app, we’ll be making the following structure. A timer will kick off the run once per day, then call the API for each city in the list then write the response to our data lake if it succeeds. If not you can send a mail or tweet to yourself.

 ![12.Overview](images/2.Overview.png)

# Setup

## Weather Data Account

Head to [openweathermap](https://openweathermap.org) and sign up for API access. This will give you an API key to use when requesting data. The service is free up to certain traffic limits which we won’t hit if using it for daily updates on a small number of cities.

![1.OpenWeatherMap](images/1.OpenWeatherMap.png)

You’ll need the key from this box later.

## Logic App


* Open the Logic App in your resource group
* Click on to the Logic App Designer
* 
*	
![3.Recurrence.png](images/3.Recurrence.png)
![4.InitialiseVar.png](images/4.InitialiseVar.png)
```json
[
  "Reading,uk",
  "London,uk",
  "Manchester,uk",
  "Portsmouth,uk"
]
```
![5.ForEach.png](images/5.ForEach.png)
![6.httpCall.png](images/6.httpCall.png)
![7.Condition.png](images/7.Condition.png)
![8.IfTrue.png](images/8.IfTrue.png)
![9.Compose.png](images/9.Compose.png)
![10.CreateBlob1.png](images/10.CreateBlob1.png)
![11.CreateBlob2.png](images/11.CreateBlob2.png)