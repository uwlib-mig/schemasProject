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
    version="2.0">
    
    <!-- Variables -->
    <xsl:variable name="datasetName">RDF Dataset for the <xsl:value-of select="$digiCollName"/></xsl:variable><!-- Title of dataset -->
    <xsl:variable name="path">https://www.lib.washington.edu/static/public/cams/data/datasets/</xsl:variable> <!-- path to dataset, up to file name -->
    <xsl:variable name="filename">ayp-agents</xsl:variable><!-- filename of dataset without file extension -->
    <xsl:variable name="findingAidUrl">http://guides.lib.uw.edu/research/pnw/exploration/ayp_exposition</xsl:variable><!-- URL to finding aid for physical collection -->
    <xsl:variable name="digiCollUrl">http://content.lib.washington.edu/aypweb/index.html</xsl:variable><!-- URL to digital collection -->
    <xsl:variable name="physCollName">Alaska-Yukon-Pacific Exposition Collections</xsl:variable>
    <xsl:variable name="digiCollName">Alaska-Yukon-Pacific Exposition Collection</xsl:variable>
    
    <!-- More variables: DOIs and titles for each part of the dataset -->
    <xsl:variable name="srDoi">https://doi.org/10.6069/uwlib.55.A.3.1</xsl:variable>
    <xsl:variable name="aggrDoi">https://doi.org/10.6069/uwlib.55.A.3.2</xsl:variable>
    <xsl:variable name="wrDoi">https://doi.org/10.6069/uwlib.55.A.3.3</xsl:variable>
    <xsl:variable name="collDoi">https://doi.org/10.6069/uwlib.55.A.3.4</xsl:variable>
    <xsl:variable name="rightsDoi">https://doi.org/10.6069/uwlib.55.A.3.5</xsl:variable>
    <xsl:variable name="agentDoi">https://doi.org/10.6069/uwlib.55.A.3.6</xsl:variable>
    <xsl:variable name="srPartName">Part I: Source Resource Class</xsl:variable>
    <xsl:variable name="aggrPartName">Part II: Aggregation Class</xsl:variable>
    <xsl:variable name="wrPartName">Part III: Web Resource Class</xsl:variable>
    <xsl:variable name="rightsPartName">Part IV: Rights Statement Class</xsl:variable>
    <xsl:variable name="collPartName">Part V: Collection Class</xsl:variable>
    <xsl:variable name="agentPartName">Part VI: Agents</xsl:variable>
    
    
    <xsl:template match="/">
        <!-- latest collection-specific including xsl. 2018-08-08 -->
        <!-- html declaration -->
        <html xmlns="http://www.w3.org/1999/xhtml" version="XHTML+RDFa 1.1"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.w3.org/1999/xhtml http://www.w3.org/MarkUp/SCHEMA/xhtml-rdfa-2.xsd"
            lang="en" xml:lang="en">
            
            <!-- head must contain:
                 title
                 links to alternative serializations using <LINK> -->
            <head>
                <title>
                    <xsl:value-of select="concat($datasetName,', ',$agentPartName)"/>
                </title>
                <link rel="alternate" type="application/n-triples"
                    href="{concat($path,$filename,'.nt')}"/>
                <link rel="alternate" type="application/rdf+xml"
                    href="{concat($path,$filename,'.rdf')}"/>
                <link rel="alternate" type="application/turtle"
                    href="{concat($path,$filename,'.ttl')}"/>
            </head>
            
            <body about="{$agentDoi}">
                <!-- Title of dataset -->
                <h1><xsl:value-of select="concat($datasetName,', ',$agentPartName)"/></h1>
                <!-- Links to other parts in the parent dataset, if applicable -->
                <!-- How to include links to parts other than current part? -->
                <h2>Access Other Parts of the Dataset:</h2>
                <ul>
                    <ol><a href="{$srDoi}"><xsl:value-of select="$srPartName"/></a></ol>
                    <ol><a href="{$aggrDoi}"><xsl:value-of select="$aggrPartName"/></a></ol>
                    <ol><a href="{$wrDoi}"><xsl:value-of select="$wrPartName"/></a></ol>
                    <ol><a href="{$rightsDoi}"><xsl:value-of select="$rightsPartName"/></a></ol>
                    <ol><a href="{$collDoi}"><xsl:value-of select="$collPartName"/></a></ol>
                    <ol><a href="{$agentDoi}"><xsl:value-of select="$agentPartName"/></a></ol>
                </ul>
                
                <!-- About the physical collection, if applicable -->
                <h2>About the <xsl:value-of select="$physCollName"/></h2>
                <p>
                    The University of Washington Libraries’ <a href="{$findingAidUrl}"><xsl:value-of select="$physCollName"/></a> include numerous physical collections comprising a large number and variety of photographic and other materials. Selections are available online as a <a href="{$digiCollUrl}">digital collection</a>.
                </p>
                
                <!-- About the parent dataset, if applicable -->
                <!-- NOTE on this section: Number of parts may vary from dataset to dataset -->
                <h2>About the <xsl:value-of select="$datasetName"/></h2>
                <p>The RDF triples below are part of a larger dataset consisting of five parts, each describing a particular class of resource. Each part is available in the following file formats: HTML with embedded RDFa, N-Triples, RDF/XML, and Turtle. All data is in the public domain and may be used without restriction. The resources described by the data, however, do have restrictions on use.</p>
                <p>The dataset is structured primarily using classes and properties taken from the <a href="https://pro.dp.la/hubs/metadata-application-profile">Digital Public Library of America’s Metadata Application Profile (DPLA MAP version 5)</a>.</p>
                <p>All parts and file formats are accessible online. The HTML format contains machine-readable RDFa data, and also serves as a human-readable landing page for each part. Links to alternate serializations are contained in the introductory material. No zipped downloads or SPARQL endpoints are currently available.</p>
                
                <!-- Links to alternate serializations -->
                <h2>Links to Alternate Serializations for <xsl:value-of select="$agentPartName"/></h2>
                <ul>
                    <ol><a href="{concat($path,$filename,'.nt')}">N-Triples</a></ol>
                    <ol><a href="{concat($path,$filename,'.rdf')}">RDF/XML</a></ol>
                    <ol><a href="{concat($path,$filename,'.ttl')}">Turtle</a></ol>
                </ul>
                <!-- About the current dataset part (in the HTML table below) -->
                <!-- we have no info about the curent dataset part, ok?? -->
                
                <!-- Table headline -->
                <h2>RDF Triples for <xsl:value-of select="$agentPartName"/></h2>               
                <!-- Table setup below always stays the same -->
                <table border="1" cellpadding="6">
                    <tr>
                        <th>Subject</th>
                        <th>Predicate</th>
                        <th>Object</th>
                    </tr>
                    <xsl:apply-templates select="rdf:RDF" mode="resource"/>
                    <xsl:apply-templates select="rdf:RDF" mode="bnode"/>
                </table>
                <br/><br/><hr/>
                
                <!-- Contact information -->
                <h3>Contact:</h3>
                <p>
                    <a href="https://www.lib.washington.edu/msd">University of Washington Libraries, Cataloging and Metadata Services</a><br/>
                    Box 352900, Seattle, WA 98195-2900<br/>
                    Telephone: 206-543-1919<br/>
                    <a href="mailto:tgis@uw.edu">tgis@uw.edu</a></p>
                <br/><hr/>
                
                <!-- CC0 image/link, rights statement -->
                <p>
                    <a href="http://creativecommons.org/publicdomain/zero/1.0/">
                        <img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />
                    </a>
                    <br/><br/>
                    To the extent possible under law, the University of Washington Libraries has waived all copyright and related or neighboring rights to the <xsl:value-of select="$datasetName"/>. This work was published in the United States.
                </p>
            </body>
        </html>
    </xsl:template>
    
    <!-- Be sure to include the actual RDFa transform! -->
    <xsl:include href="rdf2rdfa-v0-2-truncated.xsl"/>
    
</xsl:stylesheet>