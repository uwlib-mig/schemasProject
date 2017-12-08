<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
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
        <!-- we're looking for @ values that represent a CO is present in property file.
             all pertinent attribute values are no, object, item, agnostic, full.
             let's search for all but no.
        <xsl:if test="//@* = 'object'">
            <prop>
                <xsl:value-of select="prop:labels/prop:platformIndependent"/>
            </prop>
        </xsl:if>
        <xsl:if test="//@co='all'">
            <ALL>
                <xsl:value-of select="prop:labels/prop:platformIndependent"/>
            </ALL>
        </xsl:if>
        <xsl:if test="//prop:complexType">
            <xsl:value-of select="prop:xsd//prop:complexType"></xsl:value-of>
        </xsl:if>
        <xsl:if test="not(contains(prop:examples/comment(),'customization'))">
            <xsl:value-of select="prop:examples/comment()"/>
        </xsl:if>
        <xsl:if test="//@co='item'">
        <coll>    
            <xsl:value-of select="prop:labels/prop:platformIndependent"/>
        </coll>
        </xsl:if>
        <coll>
            <xsl:copy-of select="//prop:platformIndependent"></xsl:copy-of>
            <xsl:copy-of select="prop:uwRequired"></xsl:copy-of>
        </coll>-->
        <xsd>
            <xsl:copy-of select="prop:xsd"/>
        </xsd>

        <!--
            <xsl:if test="prop:cdm/prop:cdmControlledVocab='yes'">
                <propReqdInUwColls><xsl:value-of select="prop:labels/prop:platformIndependent"/> = <xsl:value-of select="prop:cdm/prop:label"/></propReqdInUwColls>
            </xsl:if>
        -->
    </xsl:template>
</xsl:stylesheet>
