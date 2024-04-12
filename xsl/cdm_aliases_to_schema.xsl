<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="xs math"
    expand-text="yes" version="3.0">

    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>

    <!-- use py/retrieve_collections.py to update collection_list.json for use here -->
    
    <xsl:variable name="collection_list" select="
            unparsed-text('../json/collection_list.json') => fn:json-to-xml()"/>

    <xsl:template match="
            xs:simpleType[@name = 'collection_type']/xs:restriction
            /xs:simpleType/xs:list/xs:simpleType/xs:restriction[@base = 'xs:token']">
        <xs:restriction base="xs:token">
            <xs:enumeration value="*">
                <xs:annotation>
                    <xs:documentation>Use this value to indicate that the guidance or example value applies to all collections, in the absence of content tagged for a specific collection(s).</xs:documentation>
                </xs:annotation>
            </xs:enumeration>
            <xsl:comment>temp alias may be used if collection alias has not yet been determined</xsl:comment>
            <xs:enumeration value="temp_alias_001"/>
            <xs:enumeration value="temp_alias_002"/>
            <xs:enumeration value="temp_alias_003"/>
            <xsl:comment>existing collection aliases</xsl:comment>
            <xsl:for-each select="$collection_list/fn:array/fn:map">
                <xs:enumeration value="{fn:string[@key = 'secondary_alias']}">
                    <xs:annotation>
                        <xs:documentation>{fn:string[@key = 'name']}</xs:documentation>
                    </xs:annotation>
                </xs:enumeration>
            </xsl:for-each>
        </xs:restriction>
    </xsl:template>

</xsl:stylesheet>
