# Proctor Notes

## Introduction

These notes are aimed at people running the workshop for a day. They should help you to guide the day to meet expectations and cover the right products, as well as keep the day moving and plan for timing and breaks.

## Booking

To book this in the MTC (MS Staff only) please follow the instructions in [DataLakeInADayBookingInstructions.pdf](DataLakeInADayBookingInstructions.pdf)

**Location:** The lab will take place at the UK MTC (Reading or London)
**How to book:**
* Agree with your customer 2 or 3 possible days  
* Summit a request through aka.ms/mtcrequest  (please summit your request at least with 4 weeks in advance)
* Wait the confirmation from MTC 
* A qualification call from the MTC will be scheduled, where we are going to explain you all about the lab
* After the call will send you the agenda of the day
* When you received  the agenda you can now confirm the date with the customer 

**What to expect during the day:**
* Full day lab from 9:30 am – 4:30 pm
* Food will be provided: breakfast, lunch and some snacks during the breaks 
* Azure tenant for the day 
* If you decide to book at the MTC Reading, the computers will be provided as well, if you want!

## Accounts

Do this BEFORE the day of the workshop. Getting a whole class to set up accounts takes a lot of time.

To request Azure passes, go to [https://requests.microsoftazurepass.com/](https://requests.microsoftazurepass.com/) and submit requests for enough passes to fill the class.
The deployment will cost approximately $30 per day

Go to [http://aka.ms/azurepasssetup](http://aka.ms/azurepasssetup) for instructions on creating accounts and subscriptions for everyone in the class. Use generic user names and a standard password to keep things simple in the class.

## Schedule

Mention to delegates that labs are self paced and so no coffee breaks are scheduled in. Coffee and sanwiches will be ordered at specific times and will be mentioned but there are not specific breaks for these.

* 09:30 - arrive and breakfast
* 10:00 - Set up infrastructure (deploy takes ~14 minutes)
* 10:30 - Session 1 (starts as soon as deploy begins)
* 11:00 - Lab 1 ()
* 12:00 - **Lunch**
* 12:45 - session 2
* 13:15 - Lab 2
* 14:45 - Lab 3a or Lab 3b
* 15:15 - Lab 4
* 15:45 - Lab 5 (Loading to Power BI is generally low priority so drop if short of time)
* 16:15 - Finish

## Infrastructure

The infrastructure is all hard coded so should not present any unusual problems. If any of the infrastructure fails to deploy, simply deploy the missing resource(s) manually. Everything in the template is a plain and empty default configuration and the particular SKU is unimportant to the outcome of the labs so pick something cheap but fast enough not to slow up the labs. Some of the low end virtual machines for instance are unresponsive and so while they would work fine, make the labs slow and frustrating.

When deploying, select East US as the region since this has been tested and contains all required SKUs. Other regions might work but have not been tested.

The username is **demogod** and it's advisable to suggest to the class to enter "Password123$" as their password when deploying - write this on a whiteboard to help them, but be sure to note it's not secure and that the demo subscription will be removed at the end of the day. This will avoid any issues with non-compliant passwords or time wasted choosing something suitable. It will also avoid forgotten passwords during the day.

## Labs

* For Lab 2, you may want to get an API key for everyone to use to save time. Go to [openweathermap](https://openweathermap.org) and sign up in advance. You can email the key to attendees, or place it on a OneDrive. Delete the account afterwards, or delete the key you gave out to prevent misuse.

* May be an error when creating the Blob connection from Logic App - this needs you to go to Subscriptions, resource providers and set up the Microsoft.web provider. This seems to be a recent change.

* The Schema in the Logic App may need some instances of Integer changing to number - this causes the first run to fail and is to show the class that the infered schema may not always be perfect. This is intentionally left as an error to enhance learning.

## UK MTC

The UK MTC can run these workshops. Please make a request as usual through the MTC. These will generally be held in the training room where there is space for 20 delegates and computers are provided so they won't need their own laptops. We are also able to provide 
