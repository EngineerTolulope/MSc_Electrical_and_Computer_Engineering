#!/usr/bin/env python
# coding: utf8

"""Download data from a database source and generate a file (for example, csv) or a graph.
As an example you can access a MySQL database and retrieve all the contents of a table named `tl` and store them in a csv file. Here are the details to access the database:
MySQL server: livinglablm.ad.unb.ca
Database: historiandb
User: smartgrid
Password: historian
Tablename: tl
"""

import mysql.connector
import csv

def main():
    #Create a CSV File
    csvFile = open('TableTL.csv', 'w', newline='')
    writer = csv.writer(csvFile)

    # SET MYSQL CONNECTION
    mydb = mysql.connector.connect(
        host='livinglablm.ad.unb.ca',
        user='smartgrid',
        password='historian',
        database='historiandb')
    cur = mydb.cursor()

    colnames = list()
    query= "select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'tl'"
    cur.execute(query)
    for i in cur.fetchall():
        colnames.append(i[3]) #Stores all the column names in a list
    writer.writerow(colnames) #Writes into the csv file

    query = "SELECT * FROM tl"
    cur.execute(query)
    for i in cur.fetchall():
        print(i)
        writer.writerow(i)


    csvFile.close()
    cur.close()
    mydb.close()




if __name__ == '__main__':
    main()
