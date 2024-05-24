<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Lista de Pacientes</title>
                <link rel="stylesheet" type="text/css" href="Glaucoma_analysis.css"/> 
            </head>
            <body>
                <h1>Lista de Pacientes</h1>
                <table>
                    <tr>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>ID</th>
                        <th>Teléfono</th>
                        <th>Email</th>
                        <th>Doctor</th>
                        <th>Fecha de Diagnóstico</th>
                        <th>Estado de Glaucoma</th>
                        <th>Imagen</th>
                    </tr>
                    <xsl:for-each select="Pacientes/paciente">
                        <tr>
                            <td><xsl:value-of select="Nombre"/></td>
                            <td><xsl:value-of select="Apellido"/></td>
                            <td><xsl:value-of select="Id"/></td>
                            <td><xsl:value-of select="Mobile_phone"/></td>
                            <td><xsl:value-of select="Email"/></td>
                            <td><xsl:value-of select="Doctor"/></td>
                            <td><xsl:value-of select="Fecha_de_diagnostico"/></td> <!-- Agregado -->
                            <td><xsl:value-of select="Estado_de_glaucoma"/></td> <!-- Agregado -->
                            <td><img src="{Imagen/@Imagen}" alt="Imagen del nervio" style="width:100px; height:auto;"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
