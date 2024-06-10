function isUserAuthenticated() {
    return !!localStorage.getItem('userToken'); 
}

function checkAuthentication(event) {
    event.preventDefault();
    if (!isUserAuthenticated()) {
        alert("Por favor, regístrate o inicia sesión para acceder a los productos.");
        window.location.href = 'login.html'; 
        window.location.href = '#products';
    }
}
