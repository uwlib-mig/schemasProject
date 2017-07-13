<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:dds="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries"
    xmlns:prop="http://faculty.washington.edu/tgis/xml/xsd/modules/xsd4md/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    version="2.0">
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@xsi:schemaLocation">
        <xsl:attribute name="xsi:schemaLocation">http://faculty.washington.edu/tgis/schemasProject/xsd4md/ http://faculty.washington.edu/tgis/schemasProject/xsd4md/schema-4-properties-0.1.xsd</xsl:attribute>
    </xsl:template>
    
    <!-- problem here: the transform outputs with the new namespace and old namespaces; 
        however xsi:schemaLocation remains unchanged; how change that? -->
    <xsl:template match="prop:*">
        <xsl:element name="{local-name()}" namespace="http://faculty.washington.edu/tgis/schemasProject/xsd4md/">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    
    
</xsl:stylesheet>