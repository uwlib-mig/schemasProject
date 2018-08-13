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
    
    <xsl:variable name="title">RDF Dataset for the Alaska Yukon Pacific Photograph Collection</xsl:variable><!-- Title of dataset -->
    <xsl:variable name="subtitle">Part VI: Agents</xsl:variable>
    <xsl:variable name="path">https://www.lib.washington.edu/static/public/cams/data/datasets/</xsl:variable> <!-- path to dataset, up to file name -->
    <xsl:variable name="filename">ayp-agents</xsl:variable><!-- filename of dataset without file extension -->
    <xsl:variable name="findingAid">http://pathToFindingAid.edu</xsl:variable><!-- URL to finding aid for physical collection -->
    <xsl:variable name="digiColl">http://pathToDigitalCollection.edu</xsl:variable><!-- URL to digital collection -->
    <xsl:variable name="collDesc">The University of Washington Libraries’<a href="{$findingAid}"> Alaska Yukon Pacific Collection</a> is BIG! Selections are also available online as a <a href="{$digiColl}">digital collection.</a></xsl:variable>
    <xsl:variable name="pColl">Alaska Yukon Pacific Photograph Collection</xsl:variable>
    <xsl:variable name="dColl">http://pathToDigiColl</xsl:variable>
    
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
                <title><xsl:value-of select="concat($title,', ',$subtitle)"/></title>
                <link rel="alternate" type="application/n-triples"
                    href="{concat($path,$filename,'.nt')}"/>
                <link rel="alternate" type="application/rdf+xml"
                    href="{concat($path,$filename,'.rdf')}"/>
                <link rel="alternate" type="application/turtle"
                    href="{concat($path,$filename,'.ttl')}"
                />
            </head>
            <body about="https://doi.org/10.6069/uwlib.55.D.1">
                <!-- Title of dataset -->
                <h1><xsl:value-of select="concat($title,', ',$subtitle)"/></h1>
                <!-- Links to other parts in the parent dataset, if applicable -->
                <!-- problem here: how offer other parts hre not this part here -->
                <h2>Access other parts of the dataset:</h2>
                <ul>
                    <ol><a href="">part I, SourceResource</a></ol>
                    <ol><a href="">part II, Aggregation</a></ol>
                    <ol><a href="">WebResource</a></ol>
                    <ol><a href="">Collection</a></ol>
                    <ol><a href="">RightsStatement</a></ol>
                    <ol><a href="">Agents</a></ol>
                </ul>
                <!-- About the physical collection, if applicable -->
                <h2>About the <xsl:value-of select="$pColl"/></h2>
                <p><xsl:value-of select="$collDesc"/></p>
                <!-- About the parent dataset, if applicable -->
                <h2>About the <xsl:value-of select="$title"/></h2>
                <p>TThe RDF triples below are part of a larger dataset consisting of five parts, each describing a particular type of resource. Each part is available in the following file formats: HTML with embedded RDFa, N-triples, RDF/XML, and Turtle. All data is in the public domain and may be used without restriction. The resources described by the data, however, do have restrictions on use.</p>
                <p>The dataset is structured primarily using classes and properties taken from the <a href="">Digital Public Library of America’s Metadata Application Profile (DPLA MAP version 5)</a>.</p>
                <p>All parts and file formats are accessible online. The HTML format contains machine-readable RDFa data, and also serves as a human-readable landing page for each part. Links to alternate serializations are contained in the introductory material. No zipped downloads or SPARQL endpoints are currently available.</p>
                <!-- Links to alternate serializations -->
                <h2>Links to alternate serializations for Part I: Source resources</h2>
                <p><a href="{concat($path,$filename,'.nt')}">N-Triples</a></p>
                <p><a href="{concat($path,$filename,'.rdf')}">RDF/XML</a></p>
                <p><a href="{concat($path,$filename,'.ttl')}">Turtle</a></p>
                <!-- About the current dataset (in the HTML table below) -->
                <!-- we have no info about the curent dataset, ok?? -->
                <!-- Table headline -->
                <h2>RDF triples for "<xsl:value-of select="concat($title,', ',$subtitle)"/>"</h2>               
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
                <p>University of Washington Libraries, Cataloging and Metadata Services<br/>
                    Box 352900, Seattle, WA 98195-2900<br/>
                    Telephone: 206-543-1919<br/>
                    tgis@uw.edu</p>
                <br/><hr/>
                <p>
                    <a>
                        <img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />
                    </a>
                    <br/><br/>
                    To the extent possible under law, University of Washington Libraries has waived all copyright and related or neighboring rights to <xsl:value-of select="concat($title,', ',$subtitle)"/>. This work is published from: United States.
                </p>
            </body>
        </html>
    </xsl:template>
    
    <!-- Be sure to include the actual RDFa transform! -->
    <xsl:include href="rdf2rdfa-v0-2-truncated.xsl"/>
    
</xsl:stylesheet>