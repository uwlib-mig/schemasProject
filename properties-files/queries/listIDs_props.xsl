<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:pf="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <get_info>
            <!-- BMR: TO DO
                TEST for duplicate uids
                FOR missing uids - grab filename -->
            <key>
                <xsl:text> uid | platformIndependentLabel </xsl:text>
            </key>
            <start_list/>
            <xsl:apply-templates
                select="collection('../?select=*.xml')/pf:property">
                <!-- remove p's; sort numerically -->
                <xsl:sort order="ascending" select="translate(pf:uid, 'p', '')" data-type="number"/>
            </xsl:apply-templates>
        </get_info>
    </xsl:template>

    <xsl:template match="pf:property">
        <prop>
            <xsl:value-of select="pf:uid"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="pf:labels/pf:platformIndependent"/>
        </prop>
    </xsl:template>

</xsl:stylesheet>
