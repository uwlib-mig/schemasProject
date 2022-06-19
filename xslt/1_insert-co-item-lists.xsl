<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs" 
    version="2.0">
    
    <xsl:output method="xml" indent="yes"/>

    <xsl:variable name="collectionId">p16786coll9</xsl:variable>
    <xsl:variable name="base"
        select="concat('https://server16786.contentdm.oclc.org/cgi-bin/showfile.exe?CISOROOT=/', $collectionId, '&amp;CISOPTR=')"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="cdmfilename">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
        <xsl:if test="contains(.,'.cpd')">
            <coitems>
                <xsl:for-each select="document(concat($base,../cdmnumber))/cpd/page">
                    <cdmnumberRef>
                        <xsl:value-of select="pageptr"/>
                    </cdmnumberRef>
                </xsl:for-each>
            </coitems>
        </xsl:if> 
    </xsl:template>
    
</xsl:stylesheet>
