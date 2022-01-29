<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output indent="yes"/>
    <xsl:template match="/">
        <root>
            <xsl:for-each select="collection('../properties-files?select=*.xml')">
                <xsl:apply-templates/>
            </xsl:for-each>
        </root>
    </xsl:template>
    
    <xsl:template match="prop:property">
        <namespaces prop="{prop:labels/prop:platformIndependent}">
            <xsl:for-each select="namespace::*">
                <n><xsl:value-of select="."/></n>
            </xsl:for-each>
        </namespaces>     
    </xsl:template>
</xsl:stylesheet>