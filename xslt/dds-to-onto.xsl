<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dd="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries"
    xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:owl="http://www.w3.org/2002/07/owl#"
    version="2.0">
    <!--
    1. rdf:type = rdf:Property
    2. rdfs:subPropertyOf : most are subproperties of dc
    3. rdfs:domain : a lot can't define domain
    4. rdfs:range : prob most can define range
    5. rdfs:label : all properties have a label; prob should be the cdm label rather than the platform independent label; the platformIndependent label goes into the URI.
    6. rdfs:comment :enter the definition
    7. rdfs:seeAlso : could give uri to html version of xml file.
    8. rdfs:isDefinedBy : this would be the XML property file; where?
    -->
    <xsl:template match="/">
        <rdf:RDF>
            <xsl:apply-templates select="dd:migDataDictionary"/>
        </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="dd:migDataDictionary">
        <rdf:Description rdf:about="https://doi.org/10.9999/C.1"> 
            <xsl:apply-templates select="dd:properties/prop:property/prop:rdf"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="prop:rdf">
        
    </xsl:template>
    
    
</xsl:stylesheet>