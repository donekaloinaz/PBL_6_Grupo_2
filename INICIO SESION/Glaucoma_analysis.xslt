<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Lista de Pacientes</title>
                <link rel="stylesheet" type="text/css" href="Glaucoma_analysis.css"/>
                <style>
					body {
						margin-top: 70px; /* Ajusta este valor según sea necesario */
						box-sizing: border-box; /* Incluye el margen en el cálculo total del tamaño del cuerpo */
					}
					header {
						width: 100%;
						background: #ff9999;
						position: fixed;
						top: 0;
						display: flex;
						align-items: center;
						justify-content: space-between;
						padding: 0rem 1rem;
						z-index: 1000;
						transition: .2s;
					}
					footer {
						background-color: #333;
						color: #fff;
						padding: 20px;
						text-align: center;
						width:100%;
					}

					footer p {
						margin-bottom: 10px;
					}

					footer a {
						color: #fff;
						text-decoration: none;
						margin: 0 10px;
					}

					footer a:hover {
						text-decoration: none;
					}
				</style>
            </head>
            <body>
                <header>
                    <h2><a href="web.html">GADIN</a></h2>
                </header>

                <h1>Lista de Pacientes</h1>
                <img src="logo_mu.jpg" alt="Logo" class="logo"/>
                <table>
                    <tr>
                        <th>Paciente ID</th>
                        <th>Hospital</th>
                        <th>Doctor</th>
                        <th>Doctor ID</th>
                        <th>Doctor Imagen</th>
                        <th>Historial Médico</th>
                        <th>Fecha de Diagnóstico</th>
                        <th>Tipo de Glaucoma</th>
                        <th>Estado</th>
                        <th>Regla ISNT</th>
                        <th>Relación Copa-Disco</th>
                        <th>Imagen</th>
                    </tr>
                    <xsl:for-each select="Pacientes/paciente">
                        <tr>
                            <td><xsl:value-of select="@ID"/></td>
                            <td><xsl:value-of select="Hospital"/></td>
                            <td><xsl:value-of select="Doctor"/></td>
                            <td><xsl:value-of select="Doctor_ID"/></td>
                            <td><img src="{Doctor_Imagen/@Imagen}" alt="Imagen del Doctor" style="width:100px; height:auto;"/></td>
                            <td><xsl:value-of select="Historial_medico"/></td>
                            <td><xsl:value-of select="Fecha_de_diagnostico"/></td>
                            <td><xsl:value-of select="Parametros_Glaucoma/Tipo_de_Glaucoma"/></td>
                            <td><xsl:value-of select="Parametros_Glaucoma/Estado"/></td>
                            <td><xsl:value-of select="Parametros_Glaucoma/Regla_ISNT"/></td>
                            <td><xsl:value-of select="Parametros_Glaucoma/Relación_Copa-Disco"/></td>
                            <td><img src="{Parametros_Glaucoma/Imagen/@Imagen}" alt="Imagen"/></td>
                        </tr>
                    </xsl:for-each>
                </table>

                <footer>
                    <p>2024 GADIN. Todos los derechos reservados.</p>
					<p><a href="politica.html">Política de Privacidad</a> | <a href="contacto.html">Contacto</a></p>
					<p>(+34)635467896</p>
					<div class="icons">
						<a href="#" class="fab fa-facebook-f"></a>
						<a href="#" class="fab fa-twitter"></a>
						<a href="#" class="fab fa-instagram"></a>
					</div>
                </footer>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
