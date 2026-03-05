import json
import boto3
import os

def lambda_handler(event, context):
    try:
        body     = json.loads(event['body'])
        email    = body['email']
        password = body['password']
        
        client = boto3.client('cognito-idp')
        
        response = client.initiate_auth(
            ClientId=os.environ['COGNITO_CLIENT_ID'],
            AuthFlow='USER_PASSWORD_AUTH',
            AuthParameters={
                'USERNAME': email,
                'PASSWORD': password
            }
        )
        
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({
                'message': 'Login realizado com sucesso!',
                'token': response['AuthenticationResult']['IdToken'] # Este é o seu JWT
            })
        }
    except Exception as e:
        return {
            'statusCode': 400,
            'headers': { 'Access-Control-Allow-Origin': '*' },
            'body': json.dumps({'error': str(e)})
        }