<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dd="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="/">
        <root>
            <xsl:apply-templates
                select="collection('../?select=*.xml;recurse=no')/dd:migDataDictionary">
                <xsl:sort order="descending" select="@id"/>
            </xsl:apply-templates>
        </root>
    </xsl:template>

    <xsl:template match="dd:migDataDictionary">
        <_id>
            <xsl:value-of select="./@id"/>
        </_id>
        <_ddName>
            <xsl:value-of select="dd:ddName"/>
        </_ddName>
    </xsl:template>

    <xsl:template match="dd:properties"/>

</xsl:stylesheet>
