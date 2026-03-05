import pytest
import boto3
import os
from infrastructure.handler.cognito_auth import CognitoAuth

def test_should_register_user_in_aws_real():
    
    user_pool_id = os.getenv("COGNITO_USER_POOL_ID")
    client_id = os.getenv("COGNITO_CLIENT_ID")
    region = os.getenv("AWS_REGION", "us-east-1")

    # Real cliente
    cognito_client = boto3.client('cognito-idp', region_name=region)
    auth_service = CognitoAuth(cognito_client, user_pool_id, client_id)

    # Test data
    email = "filipe.teste@guarulhos.com"
    password = "SenhaForte123!"

    # Subscribe action
    try:
        response = auth_service.signup(email, password)
        assert "UserSub" in response
    except cognito_client.exceptions.UsernameExistsException:
        pytest.fail("O usuário já existe na AWS. Apague-o no console e tente de novo.")