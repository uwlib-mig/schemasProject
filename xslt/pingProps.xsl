<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output indent="yes"/>
    <xsl:template match="/">
        <root>
            <xsl:for-each select="collection('../properties-files?select=*.xml')">
                <xsl:sort select="prop:property"/>
                <xsl:apply-templates/>
            </xsl:for-each>
        </root>
    </xsl:template>
    
    <xsl:template match="prop:property">
        <xsl:if test="prop:cdm/prop:cdmControlledVocab='yes'">
            <propReqdInUwColls><xsl:value-of select="prop:labels/prop:platformIndependent"/> = <xsl:value-of select="prop:cdm/prop:label"/></propReqdInUwColls>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>