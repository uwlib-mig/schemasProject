<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mig="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries"
    xmlns:mig2="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
    
    <xsl:output indent="no"></xsl:output>
    
    <!-- version 1.0 2018-03-12 -->
    
    <xsl:template match="/">
        <xs:schema>
        
        <xs:element name="metadata">
            <xs:complexType>
                <xs:sequence>
                    <xs:element ref="record" maxOccurs="unbounded"/>
                </xs:sequence>
            </xs:complexType>
        </xs:element>
            
            <xsl:element name="xs:element">
                <xsl:attribute name="name">record</xsl:attribute>
                <xsl:attribute name="type">recordType</xsl:attribute>
            </xsl:element>
            
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
                        <xsl:when test="mig2:cdm/mig2:exportLabel">
                            <xs:element name="{mig2:cdm/mig2:exportLabel}">
                                <xsl:choose>
                                    <xsl:when test="mig2:uwRequired/mig2:uwStandalone = 'yes'">
                                        <xsl:attribute name="minOccurs">1</xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="mig2:uwRequired/mig2:uwStandalone = 'no'">
                                        <xsl:attribute name="minOccurs">0</xsl:attribute>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
                                <xsl:choose>
                                    <xsl:when
                                        test="mig2:xsd/mig2:customTypeInfo[@dd = /mig:migDataDictionary/mig:cdmCode][@level = 'standalone' or @level = 'standalone object' or @level = 'standalone item' or @level = 'standalone object item']">
                                        <xsl:choose>
                                            <xsl:when test="mig2:xsd/mig2:customTypeInfo/mig2:typeAttribute">
                                                <xsl:attribute name="type">
                                                    <xsl:value-of
                                                        select="mig2:xsd/mig2:customTypeInfo/mig2:typeAttribute"/>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:customTypeInfo/mig2:simpleType">
                                                <xs:simpleType>
                                                    <xsl:copy-of
                                                        select="mig2:xsd/mig2:customTypeInfo/mig2:simpleType/*" copy-namespaces="no"/>
                                                </xs:simpleType>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:customTypeInfo/mig2:complexType">
                                                <xs:complexType>
                                                    <xsl:copy-of
                                                        select="mig2:xsd/mig2:customTypeInfo/mig2:complexType/*" copy-namespaces="no"/>
                                                </xs:complexType>
                                            </xsl:when>
                                            <xsl:otherwise>*****ERROR*****</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    
                                    <xsl:when
                                        test="mig2:xsd/mig2:typeInfo[contains(@level,'standalone')] and not(mig2:xsd/mig2:customTypeInfo[contains(@level,'standalone')][@dd = /mig:migDataDictionary/mig:cdmCode])">
                                        
                                        <!-- @level = 'standalone' or @level = 'standalone object' or @level = 'standalone item' or @level = 'standalone object item' --><xsl:choose>
                                            <xsl:when test="mig2:xsd/mig2:typeInfo/mig2:typeAttribute">
                                                <xsl:attribute name="type">
                                                    <xsl:value-of select="mig2:xsd/mig2:typeInfo/mig2:typeAttribute"/>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:typeInfo/mig2:simpleType">
                                                <xs:simpleType>
                                                    <xsl:copy-of select="mig2:xsd/mig2:typeInfo/mig2:simpleType/*" copy-namespaces="no"/>
                                                </xs:simpleType>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:typeInfo/mig2:complexType">
                                                <xs:complexType>
                                                    <xsl:copy-of select="mig2:xsd/mig2:typeInfo/mig2:complexType/*" copy-namespaces="no"/>
                                                </xs:complexType>
                                            </xsl:when>
                                            <xsl:otherwise>*****ERROR*****</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                </xsl:choose>
                            </xs:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <xs:element name="{translate(mig2:cdm/mig2:label,' ()''','')}">
                                <xsl:choose>
                                    <xsl:when test="mig2:uwRequired/mig2:uwStandalone = 'yes'">
                                        <xsl:attribute name="minOccurs">1</xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="mig2:uwRequired/mig2:uwStandalone = 'no'">
                                        <xsl:attribute name="minOccurs">0</xsl:attribute>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
                                <xsl:choose>
                                    <xsl:when
                                        test="mig2:xsd/mig2:customTypeInfo[@dd = /mig:migDataDictionary/mig:cdmCode][@level = 'standalone' or @level = 'standalone object' or @level = 'standalone item' or @level = 'standalone object item']">
                                        <xsl:choose>
                                            <xsl:when test="mig2:xsd/mig2:customTypeInfo/mig2:typeAttribute">
                                                <xsl:attribute name="type">
                                                    <xsl:value-of
                                                        select="mig2:xsd/mig2:customTypeInfo/mig2:typeAttribute"/>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:customTypeInfo/mig2:simpleType">
                                                <xs:simpleType>
                                                    <xsl:copy-of
                                                        select="mig2:xsd/mig2:customTypeInfo/mig2:simpleType/*" copy-namespaces="no"/>
                                                </xs:simpleType>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:customTypeInfo/mig2:complexType">
                                                <xs:complexType>
                                                    <xsl:copy-of
                                                        select="mig2:xsd/mig2:customTypeInfo/mig2:complexType/*" copy-namespaces="no"/>
                                                </xs:complexType>
                                            </xsl:when>
                                            <xsl:otherwise>*****ERROR*****</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    
                                    <xsl:when
                                        test="mig2:xsd/mig2:typeInfo[contains(@level,'standalone')] and not(mig2:xsd/mig2:customTypeInfo[contains(@level,'standalone')][@dd = /mig:migDataDictionary/mig:cdmCode])">
                                        
                                        <!-- @level = 'standalone' or @level = 'standalone object' or @level = 'standalone item' or @level = 'standalone object item' --><xsl:choose>
                                            <xsl:when test="mig2:xsd/mig2:typeInfo/mig2:typeAttribute">
                                                <xsl:attribute name="type">
                                                    <xsl:value-of select="mig2:xsd/mig2:typeInfo/mig2:typeAttribute"/>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:typeInfo/mig2:simpleType">
                                                <xs:simpleType>
                                                    <xsl:copy-of select="mig2:xsd/mig2:typeInfo/mig2:simpleType/*" copy-namespaces="no"/>
                                                </xs:simpleType>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:typeInfo/mig2:complexType">
                                                <xs:complexType>
                                                    <xsl:copy-of select="mig2:xsd/mig2:typeInfo/mig2:complexType/*" copy-namespaces="no"/>
                                                </xs:complexType>
                                            </xsl:when>
                                            <xsl:otherwise>*****ERROR*****</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                </xsl:choose>
                            </xs:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:template>
    
</xsl:stylesheet>