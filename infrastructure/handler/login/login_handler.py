import json
import boto3
import os

def lambda_handler(event, context):
    # 1. Recupera os dados do corpo da requisição (vinda do seu HTML/JS)
    try:
        body      = json.loads(event['body'])
        email     = body['email']
        password  = body['password']
    except (KeyError, json.JSONDecodeError):
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Dados inválidos. Envie email e password.'})
        }

    client = boto3.client('cognito-idp')
    
    # 2. IDs recuperados das variáveis de ambiente que o Terraform vai injetar
    user_pool_id = os.environ['COGNITO_USER_POOL_ID']
    client_id = os.environ['COGNITO_CLIENT_ID']

    try:
        # 3. Tenta realizar a autenticação
        response = client.admin_initiate_auth(
            UserPoolId=user_pool_id,
            ClientId=client_id,
            AuthFlow='ADMIN_NO_SRP_AUTH', # Fluxo simplificado para server-side
            AuthParameters={
                'USERNAME': email,
                'PASSWORD': password
            }
        )

        # O segredo do login bem-sucedido é o ID Token ou Access Token
        tokens = response['AuthenticationResult']

        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json'
            },
            'body': json.dumps({
                'message': 'Login realizado com sucesso!',
                'id_token': tokens['IdToken'],       # Usado para identificar o usuário
                'access_token': tokens['AccessToken'] # Usado para autorizar chamadas de API
            })
        }

    except client.exceptions.NotAuthorizedException:
        return {
            'statusCode': 401,
            'body': json.dumps({'error': 'E-mail ou senha incorretos.'})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }