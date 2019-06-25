# Lab 2 - Getting external data using Logic App

## Introduction

Head to [openweathermap](https://openweathermap.org) and sign up for API access. This will give you an API key to use when requesting data. The service is free up to certain traffic limits which we won’t hit if using it for daily updates.

![1.OpenWeatherMap](images/1.OpenWeatherMap.png)

You’ll need the key from this box later.
* Create a Resource Group in your Azure subscription called “Weather Data”
* This will encapsulate all components used to gather weather data
  * When you no longer need weather data, delete this resource group and everything will be tidy
  * In this RG, create a storage account. The name of this doesn’t matter, but “weatherdata<yourlastname>” should work and will be easy to spot
*	Create a Logic App in the same resource group and region called “ActualWeather”
*	In the designer, we’ll be making the following structure. A timer will kick off the run every day, then call the API and write to blob if it succeeds. If not you can send a mail or tweet to yourself.

 ![12.Overview](images/12.Overview.png)
 
*	Enter these details in the recurrence timer to run at 14:30 daily
*	This is live weather information so pick a suitable time for your application
*	You could run it hourly, but may hit the limits of the free service

 ![13.Recurrence.png](images/13.Recurrence.png)
 
 * Next, set up an array variable to house a list of locations. The list is in JSON format and can contain as many locations as you need.
 
 ![14.InitialiseVariable.png](images/14.InitialiseVariable.png)
 
 * Using this array, set up a ForEach loop to iterate over the list of locations.
 
 ![15.ForeachLoop.png](images/15.ForeachLoop.png)
 
 * Inside this ForEach loop, set up an HTTP request 
*	Set up the HTTP request as per the below. I also created a second Logic App with the forecast API to get the next 5 days as a prediction. We may need to compare sales to current weather (ice cream truck) or sales compared to expected weather (brollies).
*	I changed the units to metric, by default the temperature is in SI units (Kelvin)

 ![16.HTTPRequest.png](images/16.HTTPRequest.png)
 
* Next, set up a condition to check for success. The failure branch of this may be used to mail an error or send a tweet etc.
*	Select the StatusCode for the HTTP request in the condition box, and put 200 (http success) in the value box. This is literally the HTTP status code returned and can be any valid HTTP response. You can check for 404 errors in the same way to detect a broken API (and in production, you may want to!)

 ![17.Condition.png](images/17.Condition.png)
 
* Next, we need to Parse the returned data to get the city name with which we will name the file.

![18.ParseJSON.png](images/18.ParseJSON.png)

* Call the API manually in a browser to get a sample of the payload. We'll use this in the Parse JSON task to generate a schema. To call the API manually use the following but remember to replace <YOURAPIKEY> with your actual API key:

``` http://api.openweathermap.org/data/2.5/weather?APPID=<YOURAPIKEY>&q=reading,uk&units=metric ```

![19.SampleJSONPayload.png](images/19.SampleJSONPayload.png)

* The Parse task will return new variables for each property of the JSON file
*	I also used formatDateTime(utcNow(), ‘yyyy-MM-dd’) for the file name, prefixed with the city variable since that’s the city I’m getting weather for. I created two containers, one for actual weather and one for predicted weather.

 ![20.CreateBlob.png](images/20.CreateBlob.png)
 
*	Save it
*	Run it
*	Check your Blob storage, you should now see a JSON file with data inside
*	Each day, a new JSON file will appear with current weather

![21.files.png](images/21.files.png)
