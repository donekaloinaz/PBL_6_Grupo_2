<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="Glaucoma_analysis.css"/> 
            </head>
            <body>
                <div class="header">
                    <img src="logo_mu.jpg" alt="Logo" class="logo"/>
					<img src="GADIN.png" alt="Logo" class="logo"/>
                    <h1>Lista de Pacientes</h1>
                </div>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Hospital</th>
                        <th>Doctor</th>
                        <th>Doctor ID</th>
                        <th>Historial Médico</th>
                        <th>Fecha de Diagnóstico</th>
                        <th>Estado de Glaucoma</th>
                        <th>Imagen Retinografia</th>
                    </tr>
                    <xsl:for-each select="Pacientes/paciente">
                        <tr>
                            <td><xsl:value-of select="Id"/></td>
                            <td><xsl:value-of select="Hospital"/></td>
                            <td>
                                <xsl:value-of select="Doctor"/>
                                <br/>
                                <img src="{Doctor_Imagen/@Imagen}" alt="Imagen del Doctor" class="doctor-img"/>
                            </td>
                            <td><xsl:value-of select="Doctor_ID"/></td>
                            <td><xsl:value-of select="Historial_medico"/></td>
                            <td><xsl:value-of select="Fecha_de_diagnostico"/></td>
                            <td><xsl:value-of select="Estado_de_glaucoma"/></td>
                            <td><img src="{Imagen/@Imagen}" alt="Imagen del nervio" class="nervio-img"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
