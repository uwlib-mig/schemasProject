<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        <root>
            <xsl:apply-templates/>
        </root>
    </xsl:template>
    
    <xsl:template match="metadata">
        
        <uniqueValues><xsl:value-of select="distinct-values(record/Review)"/></uniqueValues>
       <xsl:for-each-group select="record" group-by="Review">
             <xsl:choose>
                 <xsl:when test="current-grouping-key()='KDK'">
                     <KDK> <xsl:value-of select="count(current-group())"/></KDK>
                 </xsl:when>
                 <xsl:when test="current-grouping-key()='kk'">
                     <kk> <xsl:value-of select="count(current-group())"/></kk>
                 </xsl:when>
                 <xsl:when test="current-grouping-key()='KK'">
                     <KK> <xsl:value-of select="count(current-group())"/></KK>
                 </xsl:when>
                 <xsl:when test="current-grouping-key()='WN'">
                     <WN> <xsl:value-of select="count(current-group())"/></WN>
                 </xsl:when>
             </xsl:choose>           
       </xsl:for-each-group>
        
    </xsl:template>
    
</xsl:stylesheet>