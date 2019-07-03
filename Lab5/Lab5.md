# Lab 5 - Load into Power BI

## Introduction

In this final lab, we will bring our data into Power BI and create a dashboard to visualise and dig in to the information.

![architecture.png](images/architecture.png)

# Setup

## Data Lake

Download the weather data from [here](https://github.com/davedoesdemos/DataLakeInADay/raw/master/data/weatherdata/weather.csv) and copy this file into your data lake to replace the .csv file under /model/weather. This file has weather for all cities in the demo whereas we only processed weather for 4 cities in the previous labs. For several years of data in hundreds of cities it would have been unmanageable in a demo to create sample data or even process it. This is the purpose of big data processing, however, and so these large numbers of files are not an issue in a production environment since we process them in parallel accross large clusters.

## Power BI

### Blob Storage

Open Power BI Desktop and create a new empty file. Click "Get Data" on the menu and select Azure Blob Storage from the list then press connect

![blob.png](images/blob.png)

In the Azure Portal, browse to your storage account and then click properties on the menu. Copy the "Primary Blob Service Endpoint" field

![endpoint.png](images/endpoint.png)

Paste this url into the Power BI dialog box then click ok

![endpoint2.png](images/endpoint2.png)

In the Azure Portal click on Access Keys and copy one of your storage account access keys

![accesskeys.png](images/accesskeys.png)

Paste this in to Power BI and click next

Use the navigator to select the model container and click Load

![navigator.png](images/navigator.png)

In Power BI click the model button on the left and then Edit Queries on the menu

![model.png](images/model.png)

In the query editor, right click "model" and copy. Right click model again and click Paste. Do this to create 6 copies of the model. We will expand each one into a single table with the exception of the orders fact table, which we'll get from SQL Data Warehouse.

![copies.png](images/copies.png)

Now on each of the copies of the model, click the yellow "Binary" text on the lines containing .csv in the extension column. This will expand out a single file in your data model. Rename the model to the same as the file so that you can identify what data is where.

![expand.png](images/expand.png)

You should end up with a list as below

![allmodels.png](images/allmodels.png)

### SQL DW

Next, click New source and select Azure SQL Data Warehouse.

![sqldw.png](images/sqldw.png)

In the Azure portal, browse to your SQL data warehouse (DW01) and copy the Server Name from the overview page. Paste this into the Power BI dialog, and enter DW01 as the database. Select Direct Query and click OK.

![dwConnection.png](images/dwConnection.png)

Enter the credentials for **demogod** and click connect

![credentials.png](images/credentials.png)

Select the orders table and click OK

![ordersTable.png](images/ordersTable.png)

Click close and apply on the menu

![closeandapply.png](images/closeandapply.png)

### Modeling

Click on the orders table and then the total column. Set the data type to Decimal Number and currency. 

![columntype.png](images/columntype.png)

Repeat this to set quantity to whole number, and price each to decimal number and currency.

Next, click on aggrItemDate and then click "is hidden" in the properties pane

![hidden.png](images/hidden.png)

Repeat this step for the aggrItemDate table.

Next, create the following relationships:

| Table 1 | Column 1 | Cardinality 1 | Cardinality 2 | Column 2 | Table 2 |
|---------|----------|---------------|---------------|----------|---------|
| Weather | City | Many | Many | City | Orders |
| Items | Item | One | Many | item | Orders |
| Customers | customer_id | One | Many | customer_id | Orders |
| Customers | city | Many | One | City | Cities |
| Cities | city | One | Many | city | aggrCityDate |
| AggrItemDate | item | Many | One | item | Items |

Next, click on the aggrCityDate ellipsis menu and select Manage Aggregations. Set the aggregations as below:

![aggregations.png](images/aggregations.png)

Click on aggrItemDate and set the aggregations as below:

![aggregations2.png](images/aggregations2.png)

### Report

Go to the report tab in Power BI and add a matrix visualisation. From the orders table, drag City, date and order_id to the Rows box and then Item to the Values box, then set the values to count of item

![Matrix1.png](images/Matrix1.png)

On the report, right click a city and select Drill Down

![drilldown.png](images/drilldown.png)

You'll then see the next level of detail. If you look in the query log of SQL Data Warehouse, you won't see any query at this point since all data has come from our aggregations.

If you now drill down to a row which shows a large number of items, Power BI is forced to expand out with a query to the fact table and so will send a query to SQL Data Warehouse. 

![drilldown2.png](images/drilldown2.png)

You may need to sort queries by start time in the monitoring pane

![queryLog.png](images/queryLog.png)

Now, add in temperature from the weather table and set to "average of temperature" in the Values box for the matrix. 

![addTemp.png](images/addTemp.png)

You'll now be able to see the weather information we collected from the Internet as you drill down for the city. This demonstrates how simple it is to bring in external data sources and merge with your own information, regardless of scale or size.