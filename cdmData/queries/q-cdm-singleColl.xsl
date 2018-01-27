<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="/">
        <root>
            <xsl:apply-templates/>
        </root>
    </xsl:template>

    <xsl:template match="metadata">
        <countRecords>
            <xsl:value-of select="count(record)"/>
        </countRecords>
        <imageNos><xsl:value-of select="//ImageNumber"/><xsl:text>  </xsl:text></imageNos>
        <sites>
           <xsl:for-each select="record">
           <record>    
            <site><xsl:value-of select="Site"/></site>
               <title><xsl:value-of select="Title"/></title>
               <subject><xsl:value-of select="Subject"/></subject>
               <links><xsl:value-of select="Links"/></links>
               </record>
        </xsl:for-each>
        </sites>
        <objectTypes>
            <xsl:value-of select="distinct-values(//ObjectType)"/>
        </objectTypes>
        <types>
            <xsl:value-of select="distinct-values(//Type)"/>
        </types>
        <countRightsInNotes>
            <xsl:value-of select="count(//Notes[contains(text(),'RESEARCH PURPOSES')])"/>
        </countRightsInNotes>
        <countEmptyDate>
            <xsl:value-of select="count(//Date[not(text())])"/>
        </countEmptyDate>
        <countEmptyDates>
            <xsl:value-of select="count(//Dates[not(text())])"/>
        </countEmptyDates>
        <emptyDateEdtf>
            <xsl:for-each select="record">
                <xsl:if test="DateEdtf=''">
                    <record>
                        <xsl:value-of select="Title"/>
                    </record>
                </xsl:if>
            </xsl:for-each>
        </emptyDateEdtf>
    </xsl:template>

</xsl:stylesheet>
