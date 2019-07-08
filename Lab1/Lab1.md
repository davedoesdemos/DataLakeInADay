# Lab 1 - Getting Internal data with Azure Data Factory and the integration Runtime

## Introduction

During this lab we will deploy the infrastructure as shown below. This includes a pretend data centre with database server on a network, behind a firewall.

![Infrastructure.png](images/Infrastructure.png)

Once configured, an "integration runtime" component will send data securely outwards through the firewall to Azure Data Factory, which will process and store the data in Blob Storage. The data will be queried from the SQL Server via the integration runtime.

![DataFlow.png](images/DataFlow.png)

# Setup

## Infrastructure

Once you have logged in successfully to your subscription [go here](https://github.com/davedoesdemos/DataLakeInADay/blob/master/infrastructure/readme.md) to deploy the initial infrastructure for the workshop. This includes:
* A Virtual network to represent your data centre network
* An empty SQL Server
* A blank Windows server for the integration runtime
* An empty storage account which will be our data lake
* A blank Data Factory

The username for all servers is **demogod** and you will choose your password when you click the deploy button [here](https://github.com/davedoesdemos/DataLakeInADay/blob/master/infrastructure/readme.md)

## SQL Data

We need to set up some demo data for the workshop. This will simply involve loading a SQL script in SQL Server. Browse to the server (sql-*uniquestring*)  in the Azure portal and click the Connect button to open an RDP session. When prompted, log into the SQL Server using the username **demogod** and your password. Once logged in, open SQL Server Management Studio and connect to the local server. You won't be able to connect directly from your system since there is a firewall in place, as there would be on a corporate network. Click New Query in the interface to start a new query.

Copy the sql script from [this link](https://raw.githubusercontent.com/davedoesdemos/DataLakeInADay/master/data/salesdata/createDatabase.sql) by selecting all and pressing ctrl+c. Paste this text into the query window on the virtual machine (this may take a few seconds so be patient). Press the execute button and wait for it to complete, this may take a few seconds.

You will now have an example sales database.

![sqldatabase.png](images/sqldatabase.png)

## Storage Containers

Next we need to create the containers on our data lake. Here we'll be using Blob Storage, but you may use Azure Data Lake Storage Gen1 or Gen2 in a real scenario. For what we're doing here the process is almost the same. In the Azure Portal browse for your storage account (datastore-*uniquestring*). Click Blobs

![Containers1.png](images/Containers1.png)

Now click +Container at the top to create a new container

![Containers2.png](images/Containers2.png)

Select Private (no anonymous access) and give the container a name of "raw". Click OK and repeat the process to create a new container named "model"

![Containers3.png](images/Containers3.png)

## Self Hosted Integration Runtime

Log into the integration runtime server (ir-*uniquestring*) using the username **demogod** and your password.

In Server Manager, click Local Server then disable IE Enhanced Security Configuration for administrators by clicking the word on next to the setting.
![IEEnhancedSecurityConfiguration.png](images/IEEnhancedSecurityConfiguration.png)

Now open Internet explorer and download the runtime from [https://www.microsoft.com/download/details.aspx?id=39717](https://www.microsoft.com/download/details.aspx?id=39717)

Double click the installer then Choose your language and click Next

![InstallIR1.png](images/InstallIR1.png)

Agree to the terms and click Next

![InstallIR2.png](images/InstallIR2.png)

Choose an install location (default is fine) and click Next

![InstallIR3.png](images/InstallIR3.png)

Click Install

![InstallIR4.png](images/InstallIR4.png)

The installer will continue and install the software

![InstallIR5.png](images/InstallIR5.png)

Click Finish

![InstallIR6.png](images/InstallIR6.png)

The installer will then launch the configuration manager. Here you can register the integration runtime with your data factory

![RegisterIR1.png](images/RegisterIR1.png)

Browse to your data factory in the Azure Portal and click Author and Monitor

![RegisterIR2.png](images/RegisterIR2.png)

Next, click on the pencil icon on the left of the Data Factory screen to enter the designer. Next, click Connections at the bottom left of your screen and then Integration Runtimes. Click the New button

![RegisterIR3.png](images/RegisterIR3.png)

Select "Perform data movement and dispatch activities to external computes." and click Next

![RegisterIR4.png](images/RegisterIR4.png)

Select "Self Hosted" and click Next

![RegisterIR5.png](images/RegisterIR5.png)

Give the connection a name and description and then click Next

![RegisterIR6.png](images/RegisterIR6.png)

Copy one of the secure keys

![RegisterIR7.png](images/RegisterIR7.png)

Paste the key into the configuration manager window and click Register to complete setup

![RegisterIR8.png](images/RegisterIR8.png)

Once it's registered click Finish and close the remote desktop session

![RegisterIR9.png](images/RegisterIR9.png)

![RegisterIR10.png](images/RegisterIR10.png)

Click refresh in the Azure Data Factory interface and ensure that the new connection shows as connected.

![RegisterIR11.png](images/RegisterIR11.png)

## Data Factory Connections

Now we need to create two connections in Data Factory. One is for SQL Server, and the other is for Blob Storage. In your data factory go to the connections tab and select "linked Services" then click the New button.

![AddConnections.png](images/AddConnections.png)

Now select Azure Blob Storage from the list and click Continue.

![NewLinkedBlob.png](images/NewLinkedBlob.png)

Now select your subscription and storage account from the drop down lists. Name the linked service "AzureBlobStorage" then click Finish.

![NewLinkedBlob2.png](images/NewLinkedBlob2.png)

Now click New again and this time select SQL Server. There are several SQL options so make sure it's SQL Server you select.

![NewLinkedSQL.png](images/NewLinkedSQL.png)

Now fill in the name as SQLServer. Select IntegrationRuntime1 (the one you configured earlier). SQL01 is the server name of the SQL Server - this is the Windows network name not the name of the server in the Azure portal. The runtime uses this to contact the server on the network. The database name is "sales". Select Windows Authentication and type demogod and your password. Now click test to ensure this is working. Once successful, click Finish.

![NewLinkedSQL2.png](images/NewLinkedSQL2.png)

## Data Factory Datasets

Next we need to create data sets to reference the data in various locations and formats. For now, we'll be creating the following:

* SQL Datasets
  * Customer table
  * Order table
  * Order detail table
* Storage Account
  * Customer CSV
  * Order csv
  * Order detail csv

Click the plus sign and choose Dataset

![AddDataset.png](images/AddDataset.png)

Select Azure Blob Storage and click Continue

![NewDatasetBlob.png](images/NewDatasetBlob.png)

Select DelimitedText and click Continue

![NewDatasetBlobCSV.png](images/NewDatasetBlobCSV.png)

Use the name DelimitedTextCustomers and select "AzureBlobStorage" as your linked service. set the file path to raw/customers. Tick "First row as header" and select None for schema. Click Continue

![NewDatasetBlobCSVSettings.png](images/NewDatasetBlobCSVSettings.png)

Repeat this process for OrderItems as below

![NewDatasetBlobCSVSettings2.png](images/NewDatasetBlobCSVSettings2.png)

Repeat again for Orders as below

![NewDatasetBlobCSVSettings3.png](images/NewDatasetBlobCSVSettings3.png)

Now create a new dataset but choose SQL Server instead of Blob Storage. Use the drop down to select your SQL Server linked service, and then you can select the three tables, creating one dataset for each.

![NewDatasetSQLSettings.png](images/NewDatasetSQLSettings.png)

![NewDatasetSQLSettings2.png](images/NewDatasetSQLSettings2.png)

![NewDatasetSQLSettings3.png](images/NewDatasetSQLSettings3.png)

Now click "Publish All" to save your work. You should have 6 datasets as shown here. You may also want to use folders to organise them in the interface

![datasets.png](images/datasets.png)

If you click on one of your delimited text datasets you can see on the connection tab the settings for the delimited text. Here we can choose comme delimited (default) or tab etc. as required.

## Data Factory Pipeline

Now click the add button and choose pipeline. Name the pipeline "PipelineDataCopy"

![NewPipeline.png](images/NewPipeline.png)

Now click on the parameters tab and add two parameters, runStartTime and runEndTime. Leave both blank.


![NewPipelineParams.png](images/NewPipelineParams.png)

Now, expand "Move and Transform" on the menu and drag a copy data job onto the canvas. Repeat this three times.

![NewCopyJob.png](images/NewCopyJob.png)

On the general tab for each job, rename them to CopyCustomers, CopyOrderItems and CopyOrders

![NewCopyJobGeneral.png](images/NewCopyJobGeneral.png)

On the source tab, select the appropriate SQL dataset to match the name for each job, then on the sink tab select the appropriate delimited text dataset. Change the file extension to .csv since that's how we'll be saving the data.

Next, click on the CopyOrders copy activity. This copy activity will be different to the others since we're going to select just the rows from a given date. This will be the date of the data factory run, and the pipeline will run once a day to get new order data. In this demo we won't do anything special for customers or orderitems, but in real scenarios you would try to limit the amount of data copied for those too to avoid pressure on production databases.

For this task, we'll be using the following SQL query
```SQL
SELECT * FROM [sales].[dbo].[orders] WHERE date between '2019-01-01 00:00:00' and '2019-01-02 00:00:00'
```
We will replace the two dates and times with parameters so that the query returns data between the start and end times for the pipeline run. We'll also need to escape the single quotes since Data Facory would not accept those in the query.

On the source tab of the CopyOrders activity, change the radio button from Table to Query. Click in the Query box and then click Add Dynamic Content.

Copy in the following query text. You may need to alter this if your parameter names are not identical. To do this you can remove the "pipeline().parameters.runStartTime" and use the dynamic content tool to select your parameters
```SQL
@concat('SELECT * FROM [sales].[dbo].[orders] WHERE date between ''', pipeline().parameters.runStartTime,''' and ''', pipeline().parameters.runEndTime, '''')
```

![NewCopyJobQuery.png](images/NewCopyJobQuery.png)

Next, click on the Sink tab and click edit next to the dataset. Go to the Parameters tab and create one parameter called runStartTime and leave the value blank. This will be used to name the file with the run start date so that we get a unique file name per file.

![datasetparameters.png](images/datasetparameters.png)

Click the Connection tab and then in the file box and select add dynamic content. Here paste in `@concat(formatDateTime(dataset().runStartTime, 'yyyy-MM-dd'), '.csv')` and click finish. This will create the file name with the date and a .csv extension.

![datasetFileName.png](images/datasetFileName.png)

![datasetFileName2.png](images/datasetFileName2.png)

Now click back to the copy job and you'll see you now have an empty box for the parameter of the dataset. Click here and choose runStartTime from the list of parameters in the dynamic content pane. This will pass the value from the pipeline parameter to the dataset parameter when the job runs.

![copyJobParam.png](images/copyJobParam.png)

Click Publish All to save your work.

## Trigger

Finally, we need to create a trigger and run the job. From the pipeline canvas, click Add Trigger and then New/Edit on the menu.

![newTrigger.png](images/newTrigger.png)

Click choose trigger then select new  on the drop down box.

![newTrigger2.png](images/newTrigger2.png)

Name the trigger TriggerTumblingWindow and then select "Tumbling Window" under Type. This will create one run for each time period we specify going back to the start date. Each has a start and end time which will be used in the SQL query above. This is useful because we can wipe the data lake at any point and re-collect the data if needed. We can also re-run any job if data changes and it will only affect that data. Select 1st July 2018 12:00AM as the start date and 31st December 2020 11:59PM as the end date. Use 24 hours as the recurrance. This means that each file generated will contain the orders for a 24 hour period.

![newTrigger3.png](images/newTrigger3.png)

Click Next and enter the following in the parameter value boxes. These will take the window start and end times and put them in the parameters we used previously.

runStartTime - `@formatDateTime(trigger().outputs.windowStartTime, 'yyyy-MM-dd HH:mm:ss')`

runEndTime - `@formatDateTime(trigger().outputs.windowEndTime, 'yyyy-MM-dd HH:mm:ss')`

![newTrigger4.png](images/newTrigger4.png)

Click Finish and then Publish All to save your work. This time, that will also trigger the jobs to be created. Only jobs in the past will be created, new ones will be created once per day until 31st December 2020. It is advisable to create new triggers regularly rather than choose a date far in the future here, that way you maintain control and don't forget to renew.

## Monitor

Click monitor to see the jobs which have been created. You'll start to see them turn green and completed rather than amber and in progress as they run. You will also start to see files appear in your blob storage containers.

![monitor.png](images/monitor.png)

![blobs.png](images/blobs.png)

# Next

Now you can go on to [Lab 2](../Lab2/Lab2.md)
