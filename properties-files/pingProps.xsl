<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:prop="http://faculty.washington.edu/tgis/xml/xsd/modules/xsd4md/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    version="2.0">
    
    <xsl:template match="/">
        <xsl:apply-templates select="collection('file:///Users/theodore/Documents/uwl/schemasProject/properties-files?select=*.xml')/prop:property"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="prop:property">
        <xsl:value-of select="xsi:schemaLocation"/>
        <xsl:value-of select="prop:labels"/>
    </xsl:template>
    
</xsl:stylesheet>