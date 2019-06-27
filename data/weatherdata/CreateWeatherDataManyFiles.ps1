# This script creates one file for each city on each date (so thousands of files!!) with random weather data for all cities on all dates from the two CSV files. One file must have one column with city names, the other one column with dates.

$citycsv = import-csv C:\path\to\file\weather\Cities.csv
$datecsv = import-csv C:\path\to\file\weather\dates.csv
  
foreach($cityline in $citycsv)
{
   $city = $cityline.City  
   foreach($dateline in $datecsv)
   {
     $date = $dateline.Date
     $dateparts = $date.Split("/")
     $datesafe = $dateparts[2] + '-' + $dateparts[1] + '-' + $dateparts[0]
     
     $Temperature = Get-Random -Minimum -4 -Maximum 45
     $Pressure = Get-Random -Minimum 900 -Maximum 1040
     $Windspeed = Get-Random -Minimum 0 -Maximum 32
     $WindDirection = Get-Random -Minimum 0 -Maximum 359

     Add-Content "C:\path\to\file\weather\weatherdata\$city$datesafe.csv" "City, Temperature, Pressure, Windspeed, WindDirection"
     Add-Content "C:\path\to\file\weather\weatherdata\$city$datesafe.csv" "$city, $date $Temperature, $Pressure, $Windspeed, $WindDirection"
   }
}

  
   