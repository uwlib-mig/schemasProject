<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="EarliestDate"/>
    <xsl:template match="LatestDate"/>
    <xsl:template match="RepositoryCollectionGuide">
        <RepositoryCollectionGuide>
            <xsl:value-of select="substring-after(.,'http://')"/>
        </RepositoryCollectionGuide>
    </xsl:template>
    <xsl:template match="Dates">
        <xsl:choose>
            <xsl:when test=". = ''">
                <Dates>0</Dates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>