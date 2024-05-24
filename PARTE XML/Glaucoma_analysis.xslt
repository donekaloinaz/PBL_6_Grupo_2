<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
			<link rel="stylesheet" type="text/css" href="Estilo.css"/> 
            <head>
                <title>Lista de Pacientes</title>
            </head>
            <body>
                <h2>Lista de Pacientes</h2>
                <table border="1">
                    <tr>
                        <th>Nombre</th>
						<th>Apellido</th>
                        <th>ID</th>
						<th>Mobile phone</th>
						<th>Email</th>
                        <th>Doctor</th>
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
							<td style="text-align:center; vertical-align:middle;">
									<Imagen>
										<xsl:attribute name="src">
											<xsl:value-of select="Imagen"/>
										</xsl:attribute>
										<xsl:attribute name="style">
											<xsl:text>width:100px;height:auto;</xsl:text> 
										</xsl:attribute>
									</Imagen>
								</td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>