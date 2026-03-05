/*call lambda for validation*/

async function cadastrar() {
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const API_URL = "Shttps://ypqkp5lblh.execute-api.us-east-1.amazonaws.com/signup";
    
    const response = await fetch(API_URL, {
        method: 'POST',
        body: JSON.stringify({ email, password })
    });
    
    const result = await response.json();
    alert(JSON.stringify(result));
}