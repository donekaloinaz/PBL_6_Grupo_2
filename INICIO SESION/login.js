document.addEventListener("DOMContentLoaded", function() {
    var form = document.getElementById("loginForm");
    form.addEventListener("submit", function(event) {
        event.preventDefault(); // Evita que el formulario se envíe automáticamente

        // Obtener los valores del correo electrónico y contraseña ingresados
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;

        // Verificar si el correo electrónico está registrado y si la contraseña coincide
        if (localStorage.getItem(email) === password) {
            alert("Inicio de sesión exitoso. ¡Bienvenido!");
            // Redirigir al usuario a la página web creada después de un inicio de sesión exitoso
            window.location.href = "productos.html";
        } else {
            alert("Correo electrónico o contraseña incorrectos. Por favor, inténtalo de nuevo.");
        }

        // Limpiar los campos del formulario después de enviar
        document.getElementById("email").value = "";
        document.getElementById("password").value = "";
    });
});
