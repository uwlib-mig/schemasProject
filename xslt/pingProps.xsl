<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md/" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:template match="/">
        <root>
            <xsl:apply-templates
                select="collection('file:///Users/theodore/Documents/uwl/schemasProject/properties-files?select=*.xml;recurse=no')/prop:property"
            />
        </root>
    </xsl:template>
    
    <xsl:template match="prop:property">
        <xsl:value-of select="prop:labels"/>
    </xsl:template>
</xsl:stylesheet>