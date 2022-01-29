<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"></xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="EarliestDrawingDate"/>
    <xsl:template match="LatestDrawingDate"/>
    
</xsl:stylesheet>