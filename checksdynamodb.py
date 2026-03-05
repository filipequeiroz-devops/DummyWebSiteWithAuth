# This script is used to check the contents of DynamoDB tables using boto3.
# It is not necessarly part of this project, but I wantes to have it here for easy access and testing.

import boto3
import datetime
import pandas as pd

def returns_table_ensaio():
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('EmailsEnsaiosLocaisGuarulhos')
    
    response = table.scan()
    items = response['Items']
    
    for item in items:
        print(item['Emails'])

def returns_table_cv_visitors_ip():
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('cv-visitors-ip')
    
    response = table.scan()
    items = response['Items']
    
    dici = {}
    dates = []
    countrys = []
    regions = []

    for item in items:
        dates.append(datetime.datetime.fromisoformat(item['visit-time']).date())
        countrys.append(item['country'])
        regions.append(item['region'])

        dici['Date']       = dates
        dici['Countrys']   = countrys
        dici['Region']     = regions

    print(pd.DataFrame(dici).sort_values(by='Date', ascending=False))

def returns_all_tables():
    dynamodb = boto3.client('dynamodb')
    response = dynamodb.list_tables()
    print(response['TableNames'])

if __name__ == "__main__":
    returns_table_cv_visitors_ip()