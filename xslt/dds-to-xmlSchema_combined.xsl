<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mig="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries"
    xmlns:mig2="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
    
    <xsl:output indent="no"></xsl:output>

    <!-- version 1.0 2017-07-26 -->

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
                <xsl:element name="xs:alternative">
                    <xsl:attribute name="type">s-recordType</xsl:attribute>
                    <xsl:attribute name="test">@mode='s'</xsl:attribute>
                </xsl:element>
                <xsl:element name="xs:alternative">
                    <xsl:attribute name="type">o-recordType</xsl:attribute>
                    <xsl:attribute name="test">@mode='o'</xsl:attribute>
                </xsl:element>
                <xsl:element name="xs:alternative">
                    <xsl:attribute name="type">i-recordType</xsl:attribute>
                    <xsl:attribute name="test">@mode='i'</xsl:attribute>
                </xsl:element>
            </xsl:element>

            <xs:complexType name="s-recordType">
                <xs:sequence>
                    <xsl:apply-templates select="mig:migDataDictionary/mig:properties" mode="s"/>
                </xs:sequence>
                <xsl:element name="xs:attribute">
                    <xsl:attribute name="name">mode</xsl:attribute>
                    <xsl:attribute name="type">allowedModes</xsl:attribute>
                </xsl:element>
            </xs:complexType>

            <xs:complexType name="o-recordType">
                <xs:sequence>
                    <xsl:apply-templates select="mig:migDataDictionary/mig:properties" mode="o"/>
                </xs:sequence>
                <xsl:element name="xs:attribute">
                    <xsl:attribute name="name">mode</xsl:attribute>
                    <xsl:attribute name="type">allowedModes</xsl:attribute>
                </xsl:element>
            </xs:complexType>

            <xs:complexType name="i-recordType">
                <xs:sequence>
                    <xsl:apply-templates select="mig:migDataDictionary/mig:properties" mode="i"/>
                </xs:sequence>
                <xsl:element name="xs:attribute">
                    <xsl:attribute name="name">mode</xsl:attribute>
                    <xsl:attribute name="type">allowedModes</xsl:attribute>
                </xsl:element>
            </xs:complexType>
            
            <xs:simpleType name="allowedModes">
                <xs:restriction base="xs:string">
                    <xs:enumeration value="s"/>
                    <xs:enumeration value="o"/>
                    <xs:enumeration value="i"/>
                </xs:restriction>
            </xs:simpleType>
            
        </xs:schema>
        
    </xsl:template>

    <xsl:template match="mig:migDataDictionary/mig:properties" mode="s">
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

    <xsl:template match="mig:migDataDictionary/mig:properties" mode="o">
        <xsl:for-each select="mig2:property">
            <xsl:choose>
                <xsl:when test="mig2:cdm/mig2:exportLabel">
                    <xs:element name="{mig2:cdm/mig2:exportLabel}">
                        <xsl:choose>
                            <xsl:when test="mig2:uwRequired/mig2:uwObject = 'yes'">
                                <xsl:attribute name="minOccurs">1</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="mig2:uwRequired/mig2:uwObject = 'no'">
                                <xsl:attribute name="minOccurs">0</xsl:attribute>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
                        <xsl:choose>
                            <xsl:when
                                test="mig2:xsd/mig2:customTypeInfo[@dd = /mig:migDataDictionary/mig:cdmCode][contains(@level,'object')]">
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
                                test="mig2:xsd/mig2:typeInfo[contains(@level,'object')] and not(mig2:xsd/mig2:customTypeInfo[contains(@level,'standalone')][@dd = /mig:migDataDictionary/mig:cdmCode])">
                                <xsl:choose>
                                    <xsl:when test="mig2:xsd/mig2:typeInfo/mig2:typeAttribute">
                                        <xsl:attribute name="type">
                                            <xsl:value-of select="mig2:xsd/mig2:typeInfo/mig2:typeAttribute"
                                            />
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
                            <xsl:when test="mig2:uwRequired/mig2:uwObject = 'yes'">
                                <xsl:attribute name="minOccurs">1</xsl:attribute>
                            </xsl:when>
                            <xsl:when test="mig2:uwRequired/mig2:uwObject = 'no'">
                                <xsl:attribute name="minOccurs">0</xsl:attribute>
                            </xsl:when>
                        </xsl:choose>
                        <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
                        <xsl:choose>
                            <xsl:when
                                test="mig2:xsd/mig2:customTypeInfo[@dd = /mig:migDataDictionary/mig:cdmCode][contains(@level,'object')]">
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
                                test="mig2:xsd/mig2:typeInfo[contains(@level,'object')] and not(mig2:xsd/mig2:customTypeInfo[contains(@level,'standalone')][@dd = /mig:migDataDictionary/mig:cdmCode])">
                                <xsl:choose>
                                    <xsl:when test="mig2:xsd/mig2:typeInfo/mig2:typeAttribute">
                                        <xsl:attribute name="type">
                                            <xsl:value-of select="mig2:xsd/mig2:typeInfo/mig2:typeAttribute"
                                            />
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
    
    <xsl:template match="mig:migDataDictionary/mig:properties" mode="i">
        <xsl:for-each select="mig2:property">
            <xsl:choose>
                <xsl:when test="mig2:cdm/mig2:exportLabel">
                        <xsl:choose>
                            <xsl:when test="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:empty and not(mig2:xsd/mig2:customTypeInfo[@dd = /mig:migDataDictionary/mig:cdmCode][contains(@level,'item')])">
                                <xs:element name="{translate(mig2:cdm/mig2:exportLabel,' ()''','')}" minOccurs="0">
                                    <xs:simpleType>
                                        <xs:restriction base="xs:string">
                                            <xs:maxLength value="0"/>
                                        </xs:restriction>
                                    </xs:simpleType>
                                </xs:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xs:element name="{translate(mig2:cdm/mig2:exportLabel,' ()''','')}">
                                    <xsl:choose>
                                        <xsl:when test="mig2:uwRequired/mig2:uwItem = 'yes'">
                                            <xsl:attribute name="minOccurs">1</xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="mig2:uwRequired/mig2:uwItem = 'no'">
                                            <xsl:attribute name="minOccurs">0</xsl:attribute>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
                                    <xsl:choose>
                                        <xsl:when
                                            test="mig2:xsd/mig2:customTypeInfo[@dd = /mig:migDataDictionary/mig:cdmCode][contains(@level,'item')]">
                                            <xsl:choose>
                                                <xsl:when test="mig2:xsd/mig2:customTypeInfo[contains(@level,'item')]/mig2:typeAttribute">
                                                    <xsl:attribute name="type">
                                                        <xsl:value-of
                                                            select="mig2:xsd/mig2:customTypeInfo[contains(@level,'item')]/mig2:typeAttribute"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:when test="mig2:xsd/mig2:customTypeInfo[contains(@level,'item')]/mig2:simpleType">
                                                    <xs:simpleType>
                                                        <xsl:copy-of
                                                            select="mig2:xsd/mig2:customTypeInfo[contains(@level,'item')]/mig2:simpleType/*" copy-namespaces="no"/>
                                                    </xs:simpleType>
                                                </xsl:when>
                                                <xsl:when test="mig2:xsd/mig2:customTypeInfo[contains(@level,'item')]/mig2:complexType">
                                                    <xs:complexType>
                                                        <xsl:copy-of
                                                            select="mig2:xsd/mig2:customTypeInfo/mig2:complexType/*" copy-namespaces="no"/>
                                                    </xs:complexType>
                                                </xsl:when>
                                                <xsl:otherwise>*****ERROR*****</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:when>
                                        
                                        <xsl:when
                                            test="mig2:xsd/mig2:typeInfo[contains(@level,'item')] and not(mig2:xsd/mig2:customTypeInfo[@dd = /mig:migDataDictionary/mig:cdmCode][contains(@level,'item')])">
                                            <xsl:choose>
                                                <xsl:when test="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:typeAttribute">
                                                    <xsl:attribute name="type">
                                                        <xsl:value-of select="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:typeAttribute"
                                                        />
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <xsl:when test="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:simpleType">
                                                    <xs:simpleType>
                                                        <xsl:copy-of select="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:simpleType/*" copy-namespaces="no"/>
                                                    </xs:simpleType>
                                                </xsl:when>
                                                <xsl:when test="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:complexType">
                                                    <xs:complexType>
                                                        <xsl:copy-of select="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:complexType/*" copy-namespaces="no"/>
                                                    </xs:complexType>
                                                </xsl:when>
                                                <xsl:otherwise>*****ERROR*****</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:when>
                                    </xsl:choose>
                                </xs:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:empty and not(mig2:xsd/mig2:customTypeInfo[@dd = /mig:migDataDictionary/mig:cdmCode][contains(@level,'item')])">
                            <xs:element name="{translate(mig2:cdm/mig2:label,' ()''','')}" minOccurs="0">
                                <xs:simpleType>
                                    <xs:restriction base="xs:string">
                                        <xs:maxLength value="0"/>
                                    </xs:restriction>
                                </xs:simpleType>
                            </xs:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <xs:element name="{translate(mig2:cdm/mig2:label,' ()''','')}">
                                <xsl:choose>
                                    <xsl:when test="mig2:uwRequired/mig2:uwItem = 'yes'">
                                        <xsl:attribute name="minOccurs">1</xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="mig2:uwRequired/mig2:uwItem = 'no'">
                                        <xsl:attribute name="minOccurs">0</xsl:attribute>
                                    </xsl:when>
                                </xsl:choose>
                                <xsl:attribute name="maxOccurs">unbounded</xsl:attribute>
                                <xsl:choose>
                                    <xsl:when
                                        test="mig2:xsd/mig2:customTypeInfo[@dd = /mig:migDataDictionary/mig:cdmCode][contains(@level,'item')]">
                                        <xsl:choose>
                                            <xsl:when test="mig2:xsd/mig2:customTypeInfo[contains(@level,'item')]/mig2:typeAttribute">
                                                <xsl:attribute name="type">
                                                    <xsl:value-of
                                                        select="mig2:xsd/mig2:customTypeInfo[contains(@level,'item')]/mig2:typeAttribute"/>
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:customTypeInfo[contains(@level,'item')]/mig2:simpleType">
                                                <xs:simpleType>
                                                    <xsl:copy-of
                                                        select="mig2:xsd/mig2:customTypeInfo[contains(@level,'item')]/mig2:simpleType/*" copy-namespaces="no"/>
                                                </xs:simpleType>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:customTypeInfo[contains(@level,'item')]/mig2:complexType">
                                                <xs:complexType>
                                                    <xsl:copy-of
                                                        select="mig2:xsd/mig2:customTypeInfo/mig2:complexType/*" copy-namespaces="no"/>
                                                </xs:complexType>
                                            </xsl:when>
                                            <xsl:otherwise>*****ERROR*****</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    
                                    <xsl:when
                                        test="mig2:xsd/mig2:typeInfo[contains(@level,'item')] and not(mig2:xsd/mig2:customTypeInfo[@dd = /mig:migDataDictionary/mig:cdmCode][contains(@level,'item')])">
                                        <xsl:choose>
                                            <xsl:when test="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:typeAttribute">
                                                <xsl:attribute name="type">
                                                    <xsl:value-of select="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:typeAttribute"
                                                    />
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:simpleType">
                                                <xs:simpleType>
                                                    <xsl:copy-of select="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:simpleType/*" copy-namespaces="no"/>
                                                </xs:simpleType>
                                            </xsl:when>
                                            <xsl:when test="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:complexType">
                                                <xs:complexType>
                                                    <xsl:copy-of select="mig2:xsd/mig2:typeInfo[contains(@level,'item')]/mig2:complexType/*" copy-namespaces="no"/>
                                                </xs:complexType>
                                            </xsl:when>
                                            <xsl:otherwise>*****ERROR*****</xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                </xsl:choose>
                            </xs:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            
        </xsl:for-each>
    </xsl:template>
    

</xsl:stylesheet>
