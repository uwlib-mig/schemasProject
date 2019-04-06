<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:hclsr="https://doi.org/10.70027/uwlib.55.A.2.1#" xmlns:dct="http://purl.org/dc/terms/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:edm="http://www.europeana.eu/schemas/edm/"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:dpla="http://dp.la/about/map/" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:bf="http://id.loc.gov/ontologies/bibframe/"
    xmlns:ore="http://www.openarchives.org/ore/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:void="http://rdfs.org/ns/void#" xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    
    version="2.0">
    
    <!-- Do I need:
    <xsl:strip-space elements="*"> ? -->
    
    <xsl:variable name="uwlUri"
        >https://doi.org/10.6069/uwlib.55.A.3.6#UniversityofWashingtonLibraries</xsl:variable>
    <xsl:variable name="agent" select="document('https://doi.org/10.6069/uwlib.55.a.3.6')"/>
    <xsl:variable name="uwSemWeb" select="document('https://doi.org/10.6069/uwlib.55.a')"/>
    
    <!-- Values pulling from uwSemWeb that are different for each partition still need to come into these templates. 
    Pull DOI for the partition we are transforming at the time from source XML? -->
    <xsl:template name="jsonMarkup1">
    {
    "@context" : "http://schema.org" ,
    "@type" : "Dataset" ,
    </xsl:template>
    <xsl:template name="jsonMarkup2"><!-- need more key/value pairs here -->
    "creator" : {
    "@type" : "Organization" ,
    "sameAs" : "<xsl:value-of select="$uwlUri"/>"
    "name" : "<xsl:value-of select="$agent/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about=$uwlUri]/xhtml:td[@property='dpla:providedLabel']"/>"
        } ,
    "publisher" : {
    "@type" : "Organization" ,
    <!-- The following will not work until a schema:url value is in our agent file for UWL:
        "url" : "<xsl:value-of select="$agent/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[...]"/>"
        -->
    "name" : "<xsl:value-of select="$agent/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about=$uwlUri]/xhtml:td[@property='dpla:providedLabel']"/>" ,
    <!-- need more key/value pairs here -->
        },
    "inLanguage" : "<xsl:value-of select="substring-after($uwSemWeb/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about=$uwSemWeb]/xhtml:td[@property='dct:language'], 'languages/')"/>" ,
    "encodingFormat" : "application/xhtml+xml" ,
    "license" : "http://creativecommons.org/publicdomain/zero/1.0/"
    }
    </xsl:template>
</xsl:stylesheet>