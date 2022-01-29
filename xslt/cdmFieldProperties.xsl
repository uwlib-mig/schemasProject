<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:variable name="cdmProps" select="document('https://server16786.contentdm.oclc.org/dmwebservices/index.php?q=dmGetCollectionFieldInfo/ayp/xml')"/>
    
    
    <xsl:template match="/">
        <xsl:apply-templates select="$cdmProps/*"/>
    </xsl:template>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>