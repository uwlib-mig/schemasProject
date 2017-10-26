<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dd="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries"
    xmlns:prop="http://faculty.washington.edu/tgis/xml/xsd/modules/xsd4md/" version="2.0">

    <xsl:variable name="lookupDoc"
        select="document('https://server16786.contentdm.oclc.org/dmwebservices/index.php?q=dmGetCollectionFieldInfo/ayp/xml')"/>
    <xsl:variable name="localDoc" select="document('/Users/theodore/Documents/uwl/schemasProject/dataDictionaries/xmlExpanded/ayp-expanded.xml')"/>

    <xsl:key name="lookup" match="field" use="name"/>
    <xsl:key name="lookup2" match="prop:cdm" use="prop:label"/>

    <xsl:template match="/">
        <root>
            <xsl:for-each select="dd:migDataDictionary/dd:properties/prop:property">
                <xsl:if test="key('lookup', prop:cdm/prop:label, $lookupDoc)">
                    <match>
                        <local>
                            <xsl:value-of select="prop:cdm/prop:label"/>
                        </local>
                        <external>
                            <xsl:value-of
                                select="key('lookup', prop:cdm/prop:label, $lookupDoc)/name"/>
                        </external>
                    </match>
                </xsl:if>
                <xsl:if test="not(key('lookup', prop:cdm/prop:label, $lookupDoc))">
                    <fail>
                        <xsl:value-of select="prop:cdm/prop:label"/>
                    </fail>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="$lookupDoc/fields/field">
                <xsl:if test="key('lookup2',name,$localDoc)">
                    <matchExternal>
                        <external>
                            <xsl:value-of select="name"/>
                        </external>
                    </matchExternal>
                </xsl:if>
                <xsl:if test="not(key('lookup2',name,$localDoc))">
                    <failExternal>
                        <fail>
                            <xsl:value-of select="name"/>
                        </fail>
                    </failExternal>
                </xsl:if>
            </xsl:for-each>
        </root>
    </xsl:template>
    
</xsl:stylesheet>
