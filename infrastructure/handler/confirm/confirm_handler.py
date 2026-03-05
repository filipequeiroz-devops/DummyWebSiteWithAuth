import json
import boto3
import os

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])
        email = body['email']
        code = body['code']
        
        client = boto3.client('cognito-idp')
        
        # Chama o Cognito para confirmar o usuário
        client.confirm_sign_up(
            ClientId=os.environ['COGNITO_CLIENT_ID'],
            Username=email,
            ConfirmationCode=code
        )
        
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'message': 'Conta confirmada com sucesso!'})
        }
    except Exception as e:
        print(f"Erro: {str(e)}") # Log importante para o CloudWatch
        return {
            'statusCode': 400,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({'error': str(e)})
        }