function isUserAuthenticated() {
    // Aquí deberías implementar la lógica para verificar si el usuario está autenticado
    // Esto puede incluir verificar un token en el almacenamiento local, una cookie, etc.
    // Por ejemplo:
    return !!localStorage.getItem('userToken'); // Esto es solo un ejemplo. Adapta según tu implementación de autenticación.
}

function checkAuthentication(event) {
    event.preventDefault();
    if (!isUserAuthenticated()) {
        alert("Por favor, regístrate o inicia sesión para acceder a los productos.");
        // Redirigir a la página de registro o inicio de sesión
        window.location.href = 'login.html'; // Cambia 'login.html' por la URL de tu página de registro/inicio de sesión
    } else {
        // Redirigir a la sección de productos
        window.location.href = '#products';
    }
}
