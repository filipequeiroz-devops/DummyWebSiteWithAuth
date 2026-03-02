#arquivo para verificar se os recursos criados estão funcionando corretamente, como a tabela do DynamoDB. Ele pode ser executado para listar as tabelas existentes no DynamoDB e verificar se a tabela de usuários foi criada com sucesso.
import boto3

def list_dynamodb_tables():
    # Cria um cliente do DynamoDB
    dynamodb = boto3.client('dynamodb')

    # Lista as tabelas do DynamoDB
    response = dynamodb.list_tables()

    # Retorna a lista de tabelas
    return response['TableNames']