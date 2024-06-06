<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
			
                <title>Lista de Pacientes</title>
                <link rel="stylesheet" type="text/css" href="Glaucoma_Analysis.css"/>
            </head>
            <body>
				
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
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
	