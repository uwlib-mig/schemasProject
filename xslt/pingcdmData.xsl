<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:template match="/">
        <root>
           <xsl:for-each select="collection('../cdmData?select=*.xml')">
               <xsl:apply-templates/>
           </xsl:for-each>
        </root>
    </xsl:template>
    <xsl:template match="record">
        <titles><xsl:value-of select="Title"/></titles>
    </xsl:template>
</xsl:stylesheet>