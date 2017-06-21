<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:prop="http://faculty.washington.edu/tgis/xml/xsd/modules/xsd4md/"
    version="2.0">
    
    <xsl:template match="/">
        <xsl:apply-templates select="collection('file:///Users/theodore/Documents/uwl/dds/properties-files?select=*.xml')"></xsl:apply-templates>
    </xsl:template>
    collection('file:///C:/temp?select=*.xml;recurse=yes')"/
</xsl:stylesheet>