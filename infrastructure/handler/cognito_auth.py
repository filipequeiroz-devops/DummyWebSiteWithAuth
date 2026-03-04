from domain.auth_interface import AuthInterface  

class CognitoAuth(AuthInterface):
    def __init__(self, cognito_client, user_pool_id):
        self.client = cognito_client
        self.user_pool_id = user_pool_id

    def signup(self, email, password):
        return self.client.sign_up(
            ClientId='dummy', 
            Username=email,
            Password=password
        )