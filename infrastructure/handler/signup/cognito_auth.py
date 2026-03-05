import json
import boto3
import os

def lambda_handler(event, context):
    # O API Gateway manda os dados como uma string JSON no 'body'
    body = json.loads(event['body'])
    email = body['email']
    password = body['password']
    
    client = boto3.client('cognito-idp')
    
    try:
        response = client.sign_up(
            ClientId=os.environ['COGNITO_CLIENT_ID'],
            Username=email,
            Password=password,
            UserAttributes=[{'Name': 'email', 'Value': email}]
        )
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*', # Importante para o HTML funcionar!
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'message': 'Usuário criado!', 'id': response['UserSub']})
        }
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': str(e)})
        }