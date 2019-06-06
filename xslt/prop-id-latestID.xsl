<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    version="2.0">
    <xsl:output indent="yes"/>
    
    <xsl:template match="/">
        <root>
        <xsl:for-each select="collection('/Users/theodore/sch/properties-files?select=*.xml')">
            <xsl:sort select="./prop:property/prop:uid"></xsl:sort>
            <id><xsl:value-of select="./prop:property/prop:uid"/></id>
        </xsl:for-each>
        </root>
    </xsl:template>
    
</xsl:stylesheet>