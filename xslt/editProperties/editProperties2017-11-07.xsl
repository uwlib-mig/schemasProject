<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md" version="2.0">

    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>

    <!-- re-do the xsd for items so they do not output, using new features of the schema-4-properties.xsd -->

    <xsl:template match="/">
        <xsl:for-each select="collection('../../properties-files?select=*.xml;recurse=no')">
            <xsl:variable name="filename" select="tokenize(document-uri(.), '/')[last()]"/>
            <xsl:result-document href="../../properties-files/overwrites/{$filename}">
                <xsl:apply-templates/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="prop:xsd">
        <xsl:choose>
            <xsl:when test="prop:typeInfo/@level = 'standalone object item'">
                <xsl:element name="xsd"
                    namespace="http://faculty.washington.edu/tgis/schemasProject/xsd4md">
                    <xsl:apply-templates select="prop:typeInfo"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="prop:typeInfo">
        <xsl:element name="typeInfo"
            namespace="http://faculty.washington.edu/tgis/schemasProject/xsd4md">
            <xsl:attribute name="level">standalone object</xsl:attribute>
            <xsl:apply-templates select="@level"/>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
        <xsl:element name="typeInfo"
            namespace="http://faculty.washington.edu/tgis/schemasProject/xsd4md">
            <xsl:attribute name="level">item</xsl:attribute>
            <xsl:element name="empty"
                namespace="http://faculty.washington.edu/tgis/schemasProject/xsd4md"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@level"/>

</xsl:stylesheet>
