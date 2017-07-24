<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:template match="/">
        <root>
            <xsl:apply-templates
                select="collection('../cdmData?select=*.xml;recurse=no')/metadata"
            />
        </root>
    </xsl:template>
    <!-- file:///Users/theodore/Documents/uwl/schemasProject/cdmData?select=*.xml;recurse=no')/metadata -->
    
    <xsl:template match="record">
        <xsl:value-of select="RepositoryCollectionGuide"/>
    </xsl:template>
</xsl:stylesheet>