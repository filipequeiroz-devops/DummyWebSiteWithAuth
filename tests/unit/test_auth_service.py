import pytest
from unittest.mock import MagicMock
from infrastructure.handler.cognito_auth import CognitoAuth


def test_should_call_cognito_signup_with_correct_data():
    # prepared mock
    mock_boto3 = MagicMock()
    user_pool_id = "us-east-1_12345"
    auth_service = CognitoAuth(mock_boto3, "pool_123", "client_123")
    
    email = "teste@guarulhos.com"
    password = "SenhaForte123!"

    # Act 
    auth_service.signup(email, password)

    # Assert (clean code verification)
    mock_boto3.sign_up.assert_called_once_with(
        ClientId='client_123',
        Username=email,
        Password=password,
        UserAttributes=[
            {
                'Name': 'email',
                'Value': email
            }
        ]
    )