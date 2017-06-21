<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        <dates>
            <xsl:for-each select="metadata/record">
                <xsl:if test="contains(Restrictions,'For information on permissions for use and reproductions')">
                    <xsl:copy-of select="Restrictions"/>
                </xsl:if>
                
            </xsl:for-each>
        </dates>
    </xsl:template>
    
</xsl:stylesheet>