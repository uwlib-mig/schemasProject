<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="record">
        <xsl:choose>
            <xsl:when test="standaloneDeclaration">
                <xsl:element name="record">
                    <xsl:attribute name="mode">s</xsl:attribute>
                    <xsl:copy-of select="*"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="coitems">
                <xsl:element name="record">
                    <xsl:attribute name="mode">o</xsl:attribute>
                    <xsl:copy-of select="*"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="partOfCo">
                <xsl:element name="record">
                    <xsl:attribute name="mode">i</xsl:attribute>
                    <xsl:copy-of select="*"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                ****ERROR****
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>