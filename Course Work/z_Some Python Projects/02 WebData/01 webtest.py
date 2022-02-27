#!/usr/bin/env python
"""
Download a webpage listing files with a specific name pattern and identify the oldest datetime and the newest datetime
that appear on their names. You should also identify the corresponding dates where the newest and oldest files were
modified. Use the following URL as your website. The filename pattern is as follows (the date to identify is YYYMMDD):
CMC_hrdps_domain_Variable_LevelType_level_ps2.5km_YYYYMMDDHH_Phhh-mm.grib2
e.g CMC_hrdps_maritimes_ABSV_ISBL_0250_ps2.5km_2019032100_P000-00.grib2
"""

import re
import datetime
from selenium import webdriver

name_path = r">(CMC_hrdps_\w+_\w+_\w+_\d+_ps2.5km_(\d{8}[00,06,12,18]{2})_P\d{3}-\d{2}.grib2)<"  # Group 1 is the name #Group 2 is the datetime
date_path = r"\d{4}-\d{2}-\d{2} \d{2}:\d{2}"


def gethtmlsource(dataset):  # We get the html code from the webpage
    # prepare the option for the chrome driver
    options = webdriver.ChromeOptions()
    options.add_argument('headless')
    #
    driver = webdriver.Chrome(options=options)  # driver = webdriver.PhantomJS()
    driver.get(dataset)
    html = str(driver.page_source)  # This will get the initial html - before javascript
    driver.close()

    return html


def getfilenames_datetimes(html):
    # We get a list of file names/datetimes
    names = list()
    dates = list()
    matches = re.finditer(name_path, html, re.MULTILINE)
    #
    for i in matches:  # i is the value of the match
        names.append(i.group(1))
        tmp = i.group(2)
        dt = datetime.datetime(int(tmp[:4]), int(tmp[4:6]), int(tmp[6:8]), int(tmp[8:]))  # Format 2019032600
        dates.append(dt)

    return names, dates


def getmodifieddates(html):
    # We get a list of modified dates
    dates = list()
    matches = re.finditer(date_path, html, re.MULTILINE)
    #
    for i in matches:
        dates.append(i.group())  # Add a string value to the list

    return dates


def getOldAndNewDateTime(dates):  # Comparing dates Format 2019032600. gets the index
    OldestDT = dates[0]
    Oldindex = 0
    for i in range(len(dates)):
        if dates[i] < OldestDT:
            OldestDT = dates[i]
            Oldindex = i

    NewestDT = dates[len(dates) - 1]  # We can't index the len of the list
    Newindex = len(dates) - 1
    for i in range(len(dates) - 1, -1, -1):  # We can't index the len of the list, we index till zero
        if dates[i] > NewestDT:
            NewestDT = dates[i]
            Newindex = i

    return Oldindex, Newindex


def main():
    html = gethtmlsource("http://dd.weather.gc.ca/model_hrdps/maritimes/grib2/00/000/")  # Get html source page
    names, datetimes = getfilenames_datetimes(html)  # Get the names/datetimes of each file
    datemodified = getmodifieddates(html)  # Get the modified dates for each file

    Oldindex, Newindex = getOldAndNewDateTime(datetimes)  # Get the index of the oldest and newest files

    # for i in range(len(names)):
    #     print (names[i], "\t\t", datetimes[i], "\t\t", datemodified[i])

    print()
    print("The file with the Oldest date time is:- {}\t and the Date Modified is:- {}".format(names[Oldindex],
                                                                                              datemodified[Oldindex]))
    print("The file with the Newest date time is:- {}\t\t and the Date Modified is:- {}".format(names[Newindex],
                                                                                                datemodified[Newindex]))


if __name__ == "__main__":
    main()
