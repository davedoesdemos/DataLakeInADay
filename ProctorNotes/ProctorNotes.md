# Proctor Notes

## Introduction

These notes are aimed at people running the workshop for a day. They should help you to guide the day to meet expectations and cover the right products, as well as keep the day moving and plan for timing and breaks.

## Schedule

* 09:00 - arrive and breakfast
* 09:30 - Set up infrastructure (deploy takes ~14 minutes)
* 10:00 - Session 1 (starts as soon as deploy begins)
* 10:30 - **Coffee Break**
* 11:00 - Lab 1 ()
* 12:00 - **Lunch**
* 13:00 - Lab 2
* 14:00 - Session 2
* 14:30 - **Coffee Break**
* 15:00 - Lab 3a or Lab 3b
* 16:00 - Lab 4
* 17:00 - Lab 5 (Loading to Power BI is generally low priority so drop if short of time)

## Infrastructure

The infrastructure is all hard coded so should not present any unusual problems. If any of the infrastructure fails to deploy, simply deploy the missing resource(s) manually. Everything in the template is a plain and empty default configuration and the particular SKU is unimportant to the outcome of the labs so pick something cheap but fast enough not to slow up the labs. Some of the low end virtual machines for instance are unresponsive and so while they would work fine, make the labs slow and frustrating.

When deploying, select East US as the region since this has been tested and contains all required SKUs. Other regions might work but have not been tested.

The username is **demogod** and it's advisable to suggest to the class to enter "Password123$" as their password when deploying - write this on a whiteboard to help them, but be sure to note it's not secure and that the demo subscription will be removed at the end of the day. This will avoid any issues with non-compliant passwords or time wasted choosing something suitable. It will also avoid forgotten passwords during the day.

## Labs

* For Lab 2, you may want to get an API key for everyone to use to save time. Go to [openweathermap](https://openweathermap.org) and sign up in advance. You can email the key to attendees, or place it on a OneDrive. Delete the account afterwards, or delete the key you gave out to prevent misuse.

* May be an error when creating the Blob connection from Logic App - this needs you to go to Subscriptions, resource providers and set up the Microsoft.web provider. This seems to be a recent change.

* The Schema in the Logic App may need some instances of Integer changing to number - this causes the first run to fail and is to show the class that the infered schema may not always be perfect. This is intentionally left as an error to enhance learning.