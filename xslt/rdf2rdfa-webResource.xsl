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
    version="2.0">
    
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:variable name="doi">https://doi.org/10.6069/uwlib.55.a.3.3</xsl:variable>
        <xsl:variable name="usw" select="document('file:../../uwlswdToPublish/uwSemWeb.rdf')"/>
        <xsl:variable name="dataDesc">https://doi.org/10.6069/uwlib.55.a#uwSemWeb</xsl:variable>
        <xsl:variable name="name" select="$usw/rdf:RDF/rdf:Description[@rdf:about = $doi]/dct:title"/>
        <html xmlns="http://www.w3.org/1999/xhtml" version="XHTML+RDFa 1.1"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.w3.org/1999/xhtml http://www.w3.org/MarkUp/SCHEMA/xhtml-rdfa-2.xsd"
            lang="en" xml:lang="en">
            <head>
                <title>
                    <xsl:value-of select="$name"/>
                </title>
                <script type="application/ld+json">
                    {
                    "@context" : "http://schema.org" ,
                    "@type" : "Dataset" ,
                    "@id" : "<xsl:value-of select="$usw/$doi"/>" ,
                    "creator" : {
                    "@type" : "Organization" ,
                    "url" : "<xsl:value-of select="$usw/rdf:RDF/rdf:Description[@rdf:about=$dataDesc]/dct:creator/@rdf:resource"/>"
                    } ,
                    "name" : "<xsl:value-of select="$name"/>" ,
                    "description" : "<xsl:value-of select="$usw/rdf:RDF/rdf:Description[@rdf:about=$doi]/dct:description"/>" ,
                    "publisher" : {
                    "@type" : "Organization" ,
                    "url" : "<xsl:value-of select="$usw/rdf:RDF/rdf:Description[@rdf:about=$dataDesc]/dct:publisher/@rdf:resource"/>"
                    },
                    "datePublished" : "<xsl:value-of select="$usw/rdf:RDF/rdf:Description[@rdf:about=$doi]/dct:issued"/>" ,
                    "inLanguage" : "English" ,
                    "encodingFormat" : "application/xhtml+xml" ,
                    "license" : "http://creativecommons.org/publicdomain/zero/1.0/"
                    }
                </script>
                <xsl:for-each select="$usw/rdf:RDF/rdf:Description[@rdf:about=$doi]/dct:hasFormat">
                    <xsl:choose>
                        <xsl:when test="ends-with(@rdf:resource,'.nt')">
                            <link rel="alternate" type="application/n-triples" href="{@rdf:resource}"/>
                        </xsl:when>
                        <xsl:when test="ends-with(@rdf:resource,'.rdf')">
                            <link rel="alternate" type="application/rdf+xml" href="{@rdf:resource}"/>
                        </xsl:when>
                        <xsl:when test="ends-with(@rdf:resource,'.ttl')">
                            <link rel="alternate" type="text/turtle" href="{@rdf:resource}"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </head>

            <body>
                <!-- dataset title -->
                <h1>
                    <xsl:value-of select="$usw/rdf:RDF/rdf:Description[@rdf:about = $doi]/dct:title"/>
                </h1>
                <!-- dataset description -->
                <p>
                    <xsl:value-of
                        select="$usw/rdf:RDF/rdf:Description[@rdf:about = $doi]/dct:description"/>
                </p>
                <!-- backlink -->
                <h2>Backlink</h2>
                <p>This dataset is part of the dataset <a
                        href="{$usw/rdf:RDF/rdf:Description[void:classPartition/@rdf:resource=$doi]/@rdf:about}">
                        <xsl:value-of
                            select="$usw/rdf:RDF/rdf:Description[ends-with(@rdf:about, '#uwSemWeb')]/dct:title"
                        />
                    </a>
                </p>
                <!-- alternate serializations -->
                <h2>Links to Alternate Serializations for <xsl:value-of select="$usw/rdf:RDF/rdf:Description[@rdf:about = $doi]/dct:title"/></h2>
                <ul>
                    <xsl:for-each select="$usw/rdf:RDF/rdf:Description[@rdf:about = $doi]/dct:hasFormat">
                        <xsl:choose>
                            <xsl:when test="ends-with(@rdf:resource, '.nt')">
                                <li>
                                    <a href="{@rdf:resource}">N-Triples</a>
                                </li>
                            </xsl:when>
                            <xsl:when test="ends-with(@rdf:resource, '.rdf')">
                                <li>
                                    <a href="{@rdf:resource}">RDF/XML</a>
                                </li>
                            </xsl:when>
                            <xsl:when test="ends-with(@rdf:resource, '.ttl')">
                                <li>
                                    <a href="{@rdf:resource}">Turtle</a>
                                </li>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </ul>
                <!-- versioning -->
                <h2>Version information</h2>
                <p>Version <xsl:value-of
                        select="$usw/rdf:RDF/rdf:Description[@rdf:about = $doi]/owl:version"/> issued
                        <xsl:value-of select="$usw/rdf:RDF/rdf:Description[@rdf:about = $doi]/dct:issued"
                    /></p>
                <!-- Table headline -->
                <h2>RDF Triples for <xsl:value-of select="$usw/rdf:RDF/rdf:Description[@rdf:about = $doi]/dct:title"/></h2>
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
                <hr/>
                <hr/>

                <!-- Contact information -->
                <h3>Contact:</h3>
                <p>
                    <a href="https://www.lib.washington.edu/msd">University of Washington Libraries,
                        Cataloging and Metadata Services</a><br/> Box 352900, Seattle, WA
                    98195-2900<br/> Telephone: 206-543-1919<br/>
                    <a href="mailto:tgis@uw.edu">tgis@uw.edu</a></p>
                <hr/>
                <hr/>

                <!-- CC0 image/link, rights statement -->
                <p>
                    <a href="http://creativecommons.org/publicdomain/zero/1.0/">
                        <img src="http://i.creativecommons.org/p/zero/1.0/88x31.png"
                            style="border-style: none;" alt="CC0"/>
                    </a>
                    <br/><br/> To the extent possible under law, the University of Washington
                    Libraries has waived all copyright and related or neighboring rights to the
                        <xsl:value-of select="$name"/>. This work was published in the United
                    States. </p>
            </body>
        </html>
    </xsl:template>

    <!-- Be sure to include the actual RDFa transform! -->
    <xsl:include href="rdf2rdfa-table.xsl"/>

</xsl:stylesheet>
