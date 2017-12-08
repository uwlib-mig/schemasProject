<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
<xsl:output indent="yes"/>
<xsl:template match="/">
    <xsl:apply-templates>
       
    </xsl:apply-templates>
</xsl:template>

    <xsl:template match="metadata">
        <root>
            <countDateEdtf>
                <xsl:value-of select="count(//DateEdtf)"/>
            </countDateEdtf>
          <xsl:for-each select="record">
              <xsl:sort select="@mode"/>
                  <xsl:sort select="DateEdtf"/>
                      <DateEdtf mode="{@mode}">
                          <xsl:value-of select="DateEdtf"/>
                      </DateEdtf>
            </xsl:for-each>
            <numberRecords>
                <xsl:value-of select="count(record)"/>
            </numberRecords>
            <numberS>
                <xsl:value-of select="count(record[@mode = 's'])"/>
            </numberS>
            <numberO>
                <xsl:value-of select="count(record[@mode = 'o'])"/>
            </numberO>
            <numberI>
                <xsl:value-of select="count(record[@mode = 'i'])"/>
            </numberI>
            <emptyRightsUri>
                <xsl:value-of select="//RightsUri"/>
            </emptyRightsUri>
        </root>
    </xsl:template>
    
    <xsl:template match="record"/>


</xsl:stylesheet>
