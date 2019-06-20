# Lab 1 - Getting Internal data with Azure Data Factory and the integration Runtime

## Introduction

# Setup

## Infrastructure

Once you have logged in successfully to your subscription [go here](https://github.com/davedoesdemos/DataLakeInADay/blob/master/infrastructure/readme.md) to deploy the initial infrastructure for the workshop. This includes:
* A Virtual network to represent your data centre network
* An empty SQL Server
* A blank server for the integration runtime
* A storage account which will be our data lake
* A blank Data Factory

The username for all servers is **demogod** and you will choose your password when you click the deploy button [here](https://github.com/davedoesdemos/DataLakeInADay/blob/master/infrastructure/readme.md)

## SQL Data

We need to set up some demo data for the workshop. This will simply involve loading a SQL script in SQL Server.

Log into the SQL Server (sql-*uniquestring*) using the username **demogod** and your password.

Copy the sql script from [this link](https://raw.githubusercontent.com/davedoesdemos/DataLakeInADay/master/data/salesdata/createDatabase.sql)

Open SQL Server Management Studio and click New Query

Paste the script in and execute

You will now have an example sales database.

## Self Hosted Integration Runtime

Log into the integration runtime server (ir-*uniquestring*) using the username **demogod** and your password.

In Server Manager, click Local Server then disable IE Enhanced Security Configuration for administrators by clicking the word on next to the setting.
![IEEnhancedSecurityConfiguration.png](images/IEEnhancedSecurityConfiguration.png)

Now open Internet explorer and download the runtime from [https://www.microsoft.com/download/details.aspx?id=39717](https://www.microsoft.com/download/details.aspx?id=39717)