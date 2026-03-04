#simple python script to list DynamoDB tables using boto3, validating if dynamo db and other resources are properly set up and accessible
#so i don't have to go to AWS console to check if the table is created and accessible, i can just run this script to verify

import boto3

REGION = 'us-east-1' 

def list_dynamodb_tables():
    dynamodb = boto3.client('dynamodb')

    # Lists all dynamodb tables
    response = dynamodb.list_tables()

    return response['TableNames']

def list_lambda_functions():
    lambda_client = boto3.client('lambda')

    # Lists all lambda funcionations
    response = lambda_client.list_functions()

    # Return lambda funcion
    return [function['FunctionName'] for function in response['Functions']]

if __name__ == "__main__":
    tables = list_lambda_functions()
    print("Funções Lambda:")
    for table in tables:
        print(table)