<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:output indent="yes"/>

    <xsl:key name="insertCO" match="record" use="coitems/cdmnumberRef"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="cdmnumber">
        <xsl:copy-of select="."/>
        <xsl:if test="not(contains(../cdmfilename, '.cpd'))">
            <xsl:choose>
                <xsl:when test="key('insertCO', .)">
                    <partOfCo>
                        <cdmnumberCoRef>
                            <xsl:value-of select="key('insertCO', .)/cdmnumber"/>
                        </cdmnumberCoRef>
                        <cdmfilenameRef>
                            <xsl:value-of select="key('insertCO', .)/cdmfilename"/>
                        </cdmfilenameRef>
                    </partOfCo>
                </xsl:when>
                <xsl:otherwise>
                    <standaloneDeclaration>
                        <xsl:text>Not contained in a compound object. This is a standalone item.</xsl:text>
                    </standaloneDeclaration>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
