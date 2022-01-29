<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dd="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries"
    xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:variable name="coll" select="collection('../dataDictionaries/xmlExpanded?select=*.xml')"/>

    <xsl:template match="/">
        <root>
            <xsl:for-each select="$coll">
                <root>
                    <dd name="{dd:migDataDictionary/dd:ddName}">
                        <xsl:for-each select="/dd:migDataDictionary/dd:properties/prop:property">
                            <xsl:if test="prop:cdm/prop:uwRequired = 'yes'">
                                <uwRequired>
                                    <xsl:value-of select="prop:labels/prop:platformIndependent"/>
                                </uwRequired>
                            </xsl:if>
                        </xsl:for-each>
                    </dd>
                </root>
            </xsl:for-each>
        </root>
    </xsl:template>

</xsl:stylesheet>
