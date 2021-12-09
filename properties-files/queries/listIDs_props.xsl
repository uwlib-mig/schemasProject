<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:pf="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <get_info>
            <!-- BMR: TO DO, add any needed tests
                for duplicate uids
                for missing uids: grab the filename
                etc. -->
            <xsl:apply-templates
                select="collection('../?select=*.xml')/pf:property">
                <!-- remove p's; sort numerically -->
                <xsl:sort order="descending" select="translate(pf:uid, 'p', '')" data-type="number"/>
            </xsl:apply-templates>
        </get_info>
    </xsl:template>

    <xsl:template match="pf:property">
        <prop_uid_platformIndependentLabel>
            <xsl:value-of select="pf:uid"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="pf:labels/pf:platformIndependent"/>
        </prop_uid_platformIndependentLabel>
    </xsl:template>

</xsl:stylesheet>
