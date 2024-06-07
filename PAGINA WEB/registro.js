document.addEventListener("DOMContentLoaded", function() {
    var form = document.getElementById("loginForm");
    form.addEventListener("submit", function(event) {
        event.preventDefault(); // Evita que el formulario se envíe automáticamente

        // Obtener los valores del correo electrónico y contraseña ingresados
        var email = document.getElementById("email").value;
        var password = document.getElementById("password").value;

        // Verificar si el correo electrónico ya está registrado
        if (localStorage.getItem(email)) {
            alert("Ya hay una cuenta registrada con este correo electrónico.");
        } else {
            // Si el correo electrónico no está registrado, guardar el correo electrónico y la contraseña en el almacenamiento local
            localStorage.setItem(email, password);
            alert("Registro exitoso. Serás redirigido a la página de inicio de sesión.");
            // Redirigir al usuario a la página de inicio de sesión después de un registro exitoso
            window.location.href = "login.html";
        }

        // Limpiar los campos del formulario después de enviar
        document.getElementById("email").value = "";
        document.getElementById("password").value = "";
    });
});
