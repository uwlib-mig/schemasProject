<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    version="2.0">
    
    <xsl:template match="/">
        <xsl:for-each select="collection('../properties-files?select=*.xml;recurse=no')">
            <xsl:variable name="filename" select="tokenize(document-uri(.),'/')[last()]"/>
            <xsl:result-document href="../properties-files/overwrites/{$filename}">
                <xsl:apply-templates/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@xsi:schemaLocation">
        <xsl:attribute name="xsi:schemaLocation">http://faculty.washington.edu/tgis/schemasProject/xsd4md http://faculty.washington.edu/tgis/schemasProject/xsd4md/schema-4-properties.xsd</xsl:attribute>
    </xsl:template>
    
    <xsl:template match="prop:required">
        <xsl:element name="cdmRequired" namespace="http://faculty.washington.edu/tgis/schemasProject/xsd4md">no</xsl:element>
        <xsl:element name="uwRequired" namespace="http://faculty.washington.edu/tgis/schemasProject/xsd4md"><xsl:value-of select="."/></xsl:element>
    </xsl:template>
    
    <xsl:template match="prop:change">
        <xsl:copy/>
        <xsl:element name="change" namespace="http://faculty.washington.edu/tgis/schemasProject/xsd4md"><xsl:attribute name="date">2017-10-23</xsl:attribute>changed //cdm/required to //cdm/cdmRequired and //cdm/uwRequired to assist in halting use of the cdm "required" feature while, at the same time, indicating that UW-cdm collections must use, or not use, a given property; also changed @xsi:schemaLocation.</xsl:element>
    </xsl:template>
    
    
    
</xsl:stylesheet>