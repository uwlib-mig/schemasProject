<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:template match="/">
        <root>
           <xsl:for-each select="collection('../cdmData?select=*.xml')">
               <xsl:apply-templates select="record[@mode='i']"/>
           </xsl:for-each>
        </root>
    </xsl:template>
    <xsl:template match="record[@mode='i']">
        <itemDate><xsl:value-of select="Date"/></itemDate>
    </xsl:template>
</xsl:stylesheet>