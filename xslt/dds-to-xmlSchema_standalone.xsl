<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mig="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries"
    xmlns:mig2="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
    
    <!-- version 0.1 2017-07-26 -->

    <xsl:template match="/">
        <xs:schema>
            <xs:element name="metadata">
                <xs:complexType>
                    <xs:sequence>
                        <xs:element name="record" maxOccurs="unbounded" type="recordType"/>
                    </xs:sequence>
                </xs:complexType>
            </xs:element>
            <xs:complexType name="recordType">
                <xs:sequence>
                    <xsl:apply-templates select="mig:migDataDictionary/mig:properties"/>
                </xs:sequence>
            </xs:complexType>
        </xs:schema>
    </xsl:template>

    <xsl:template match="mig:migDataDictionary/mig:properties">
        <xsl:for-each select="mig2:property">
<xsl:choose> 
    <xsl:when test="not(mig2:cdm/mig2:exportLabel)">
            <!-- below: need to strip all punctuaion and space -->
            <xs:element name="{translate(mig2:cdm/mig2:label,' ()''','')}">
                <xsl:if test="mig2:cdm/mig2:uwRequired != 'yes'">
                    <xsl:attribute name="minOccurs">0</xsl:attribute>
                </xsl:if>
                <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
                <xsl:choose>
                    <xsl:when test="mig2:xsd/mig2:typeAttribute">
                        <xsl:attribute name="type" select="mig2:xsd/mig2:typeAttribute"/>
                    </xsl:when>
                    <xsl:when test="mig2:xsd/mig2:simpleType">
                        <xs:simpleType>
                            <xsl:copy-of select="mig2:xsd/mig2:simpleType/*" copy-namespaces="no"/>
                        </xs:simpleType>
                    </xsl:when>
                    <xsl:when test="mig2:xsd/mig2:complexType">
                        <xs:complexType>
                            <xsl:copy-of select="mig2:xsd/mig2:complexType/*" copy-namespaces="no"/>
                        </xs:complexType>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                        <xsl:text> </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xs:element>
    </xsl:when>
    <xsl:when test="mig2:cdm/mig2:exportLabel">
        <xs:element name="{mig2:cdm/mig2:exportLabel}">
            <xsl:if test="mig2:cdm/mig2:required != 'yes'">
                <xsl:attribute name="minOccurs">0</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
            <xsl:choose>
                <xsl:when test="mig2:xsd/mig2:typeAttribute">
                    <xsl:attribute name="type" select="mig2:xsd/mig2:typeAttribute"/>
                </xsl:when>
                <xsl:when test="mig2:xsd/mig2:simpleType">
                    <xs:simpleType>
                        <xsl:copy-of select="mig2:xsd/mig2:simpleType/*" copy-namespaces="no"/>
                    </xs:simpleType>
                </xsl:when>
                <xsl:when test="mig2:xsd/mig2:complexType">
                    <xs:complexType>
                        <xsl:copy-of select="mig2:xsd/mig2:complexType/*" copy-namespaces="no"/>
                    </xs:complexType>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                    <xsl:text> </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xs:element>
    </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
