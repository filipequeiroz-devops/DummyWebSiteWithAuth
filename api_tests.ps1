#I've created this file to test the API endpoints using PowerShell. You can run this script in a PowerShell terminal to test the signup, confirmation, login, and protected routes of your API.
function confirm_endpoint {
    $body = @{
        email = "filipe.queiroz.abreu@gmail.com"
        code  = "552668"
    } | ConvertTo-Json
    
    Invoke-RestMethod -Uri "https://2h1wm5fwje.execute-api.us-east-1.amazonaws.com/production/confirm" `
        -Method Post `
        -ContentType "application/json" `
        -Body $body
}

function authenticate_endpoint {
    $body = @{
        email     = "filipe.queiroz.abreu@gmail.com"
        password  = "SenhaForte@2026"
    } | ConvertTo-Json
    
    Invoke-RestMethod -Uri "https://2h1wm5fwje.execute-api.us-east-1.amazonaws.com/production/login" `
        -Method Post `
        -ContentType "application/json" `
        -Body $body
}

function get_token {
    $response = authenticate_endpoint

    $token = $response.token

    return $token
}



$token = get_token

function authorization_endpoint {
    param($token)

    $headers = @{
        "Authorization" = "$token"
        "Content-Type"  = "application/json"
        "Accept"        = "application/json"

    } 
    
    Invoke-RestMethod -Uri "https://2h1wm5fwje.execute-api.us-east-1.amazonaws.com/production/meu-perfil" `
        -Method Get `
        -Headers $headers
}

authorization_endpoint $token