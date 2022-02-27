#!/usr/bin/env python
# coding: utf8

""" I would like you to explore this a bit further. Could you please retrieve power demand and power consumption from the
    Physics building at UNB. I would like to get the following information from this building:
1-	Monthly power consumption during 2018
2-	Monthly maximum power demand during 2018
3-	Hourly maximum power demand  in the last 24 hours

Hint: In order to get that information, you will need to retrieve TLnstances of the IUC Physics  208v and 600v
    power demand variables from TL table of the historian database. Once you have TLinstances, you can query
    TLDATA table with the selected TLinstances to get the data associated with power demand and consumption for the time
     periods suggested here.
"""

import mysql.connector
import csv


def main():
    # SET MYSQL CONNECTION
    mydb = mysql.connector.connect(
        host='livinglablm.ad.unb.ca',
        user='smartgrid',
        password='historian',
        database='historiandb')
    cur = mydb.cursor()

    # Gets the TLnstances of the IUC Physics  208v and 600v power demand variables
    query = "SELECT TLInstance, Name, Description FROM tl WHERE (Name LIKE '%Physics 208v Power Demand%') OR (Name LIKE '%Physics 600v Power Demand%') "
    cur.execute(query)
    tmp_li = cur.fetchall()
    phy208vIns = (tmp_li[0])[0] #173
    phy600vIns = (tmp_li[1])[0] #175
    cur.reset()

    #Stores all TLDATA column names to a list
    colnames = list()
    query = "select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'TLDATA'"
    cur.execute(query)
    for i in cur.fetchall():
        colnames.append(i[3])  # Stores all the column names in a list
    cur.reset()

    #
    # query = "SELECT * FROM TLDATA WHERE TLInstance IN (173,174,175,176)" #= {}  OR TLInstance = {}".format(phy208vIns, phy600vIns)
    # cur.execute(query)
    #
    # with open('TLData.csv', 'w', newline='') as csvFile:
    #     writer = csv.writer(csvFile)
    #     writer.writerow(colnames)
    #     writer.writerows( cur.fetchall())

    query = "Show tables"
    cur.execute(query)

    for i in cur.fetchall():
        print (i)


    cur.close()
    mydb.close()


if __name__ == '__main__':
    main()
