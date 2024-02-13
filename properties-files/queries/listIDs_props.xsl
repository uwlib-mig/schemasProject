<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:pf="http://faculty.washington.edu/tgis/schemasProject/xsd4md" exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:result-document href="property_lists.xml">
            <prop_lists>
                <!-- TO DO
                TEST for duplicate uids > FOR missing uids - grab filename
                add leading zeros to PIDs as needed -->
                <by_pid>
                    <xsl:apply-templates select="collection('../?select=*.xml')/pf:property"
                        mode="by_pid">
                        <xsl:sort order="ascending" select="translate(pf:uid, 'p', '')"
                            data-type="number"/>
                    </xsl:apply-templates>
                </by_pid>
                <by_label>
                    <xsl:apply-templates select="collection('../?select=*.xml')/pf:property"
                        mode="by_label">
                        <xsl:sort order="ascending" select="pf:labels/pf:platformIndependent"
                            data-type="text"/>
                    </xsl:apply-templates>
                </by_label>
            </prop_lists>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="pf:property" mode="by_pid">
        <property>
            <xsl:value-of select="pf:uid"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="pf:labels/pf:platformIndependent"/>
        </property>
    </xsl:template>

    <xsl:template match="pf:property" mode="by_label">
        <property>
            <xsl:value-of select="pf:uid"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="pf:labels/pf:platformIndependent"/>
        </property>
    </xsl:template>

</xsl:stylesheet>
