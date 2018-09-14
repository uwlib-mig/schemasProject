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

    <!-- BEGIN VARIABLES -->

    <!-- Info about the source collection(s) -->
    <!-- Name of physical collection -->
    <xsl:variable name="physCollName">Alaska-Yukon-Pacific Exposition Collections</xsl:variable>
    <!-- URL to finding aid for physical collection -->
    <xsl:variable name="findingAidUrl"
        >http://guides.lib.uw.edu/research/pnw/exploration/ayp_exposition</xsl:variable>
    <!-- Name of digital collection -->
    <xsl:variable name="digiCollName">Alaska-Yukon-Pacific Exposition Collection</xsl:variable>
    <!-- Digital collection URL -->
    <xsl:variable name="digiCollUrl"
        >http://content.lib.washington.edu/aypweb/index.html</xsl:variable>

    <!-- Info about dataset -->
    <!-- Title of dataset -->
    <xsl:variable name="datasetName"> RDF Dataset for the <xsl:value-of select="$digiCollName"/>
    </xsl:variable>
    <!-- Variables defining current dataset part (name, DOI, filename) -->
    <xsl:variable name="currentPartName">
        <xsl:value-of select="$collPartName"/>
    </xsl:variable>
    <xsl:variable name="currentPartDoi">
        <xsl:value-of select="$collDoi"/>
    </xsl:variable>
    <xsl:variable name="currentPartFile">
        <xsl:value-of select="$collFile"/>
    </xsl:variable>

    <!-- Filepath for generating links to serializations (path *up to filename*) -->
    <xsl:variable name="path">https://www.lib.washington.edu/static/public/cams/data/datasets/ayp/</xsl:variable>

    <!-- Dataset parts: Tree, DOIs, names, filesnames *with current versions* -->
    <xsl:variable name="parts">
        <parts>
            <part>
                <xsl:value-of select="$srPartName"/>
            </part>
            <part>
                <xsl:value-of select="$aggrPartName"/>
            </part>
            <part>
                <xsl:value-of select="$wrPartName"/>
            </part>
            <part>
                <xsl:value-of select="$collPartName"/>
            </part>
            <part>
                <xsl:value-of select="$rightsPartName"/>
            </part>
            <part>
                <xsl:value-of select="$agentPartName"/>
            </part>
        </parts>
    </xsl:variable>
    <!-- Source resource -->
    <xsl:variable name="srDoi">https://doi.org/10.6069/uwlib.55.A.3.1</xsl:variable>
    <xsl:variable name="srPartName">Part I: Source Resource Class</xsl:variable>
    <xsl:variable name="srFile">ayp-sourceResource-1-1-3</xsl:variable>
    <!-- Aggregation -->
    <xsl:variable name="aggrDoi">https://doi.org/10.6069/uwlib.55.A.3.2</xsl:variable>
    <xsl:variable name="aggrPartName">Part II: Aggregation Class</xsl:variable>
    <xsl:variable name="aggrFile">ayp-aggregation-1-2-0</xsl:variable>
    <!-- Web resource -->
    <xsl:variable name="wrDoi">https://doi.org/10.6069/uwlib.55.A.3.3</xsl:variable>
    <xsl:variable name="wrPartName">Part III: Web Resource Class</xsl:variable>
    <xsl:variable name="wrFile">ayp-webResource-1-0-1</xsl:variable>
    <!-- Collection -->
    <xsl:variable name="collDoi">https://doi.org/10.6069/uwlib.55.A.3.4</xsl:variable>
    <xsl:variable name="collPartName">Part IV: Collection Class</xsl:variable>
    <xsl:variable name="collFile">ayp-collections-1-1-2</xsl:variable>
    <!-- Rights statement -->
    <xsl:variable name="rightsDoi">https://doi.org/10.6069/uwlib.55.A.3.5</xsl:variable>
    <xsl:variable name="rightsPartName">Part V: Rights Statement Class</xsl:variable>
    <xsl:variable name="rightsFile">ayp-rights-1-0-2</xsl:variable>
    <!-- Agent -->
    <xsl:variable name="agentDoi">https://doi.org/10.6069/uwlib.55.A.3.6</xsl:variable>
    <xsl:variable name="agentPartName">Part VI: Agents Class</xsl:variable>
    <xsl:variable name="agentFile">ayp-agents-1-1-3</xsl:variable>

    <!-- Dataset serializations: Tree, serialization names -->
    <xsl:variable name="sers">
        <sers>
            <ser>
                <xsl:value-of select="$nt"/>
            </ser>
            <ser>
                <xsl:value-of select="$turtle"/>
            </ser>
            <ser>
                <xsl:value-of select="$rdf"/>
            </ser>
        </sers>
    </xsl:variable>
    <xsl:variable name="nt">N-Triples</xsl:variable>
    <xsl:variable name="turtle">Turtle</xsl:variable>
    <xsl:variable name="rdf">RDF/XML</xsl:variable>

    <!-- END VARIABLES -->

    <xsl:template match="/">
        <!-- HTML declaration -->
        <html xmlns="http://www.w3.org/1999/xhtml" version="XHTML+RDFa 1.1"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.w3.org/1999/xhtml http://www.w3.org/MarkUp/SCHEMA/xhtml-rdfa-2.xsd"
            lang="en" xml:lang="en">

            <!-- Head must contain:
                 Title
                 Links to alternative serializations using <link> -->
            <head>
                <title>
                    <xsl:value-of select="concat($datasetName, ', ', $currentPartName)"/>
                </title>
                <script type="application/ld+json">
                    {
                    "@context" : "http://schema.org" ,
                    "@type" : "Dataset" ,
                    "@id" : "https://doi.org/10.6069/uwlib.55.A.3.4" ,
                    "creator" : {
                    "@type" : "Organization" ,
                    "name" : "University of Washington Libraries" ,
                    "url" : "http://www.lib.washington.edu/" ,
                    "sameAs" : "http://viaf.org/viaf/139541794"
                    } ,
                    "name" : "RDF Dataset for the Alaska-Yukon-Pacific Exposition Collection, Part IV: Collection Class" ,
                    "alternateName" : "Alaska-Yukon-Pacific Exposition Collection Descriptions, Part IV: Collection Class" ,
                    "description" : "Description of resources that are instances of http://purl.org/dc/dcmitype/Collection in the University of Washington Libraries' Alaska-Yukon-Pacific Exposition Collection." ,
                    "publisher" : {
                    "@type" : "Organization" ,
                    "name" : "University of Washington Libraries" ,
                    "url" : "http://www.lib.washington.edu/" ,
                    "sameAs" : "http://viaf.org/viaf/139541794"
                    },
                    "datePublished" : "2018" ,
                    "inLanguage" : "English" ,
                    "encodingFormat" : "application/xhtml+xml" ,
                    "version" : "1-1-2" ,
                    "license" : "http://creativecommons.org/publicdomain/zero/1.0/"
                    }
                </script>
                <link rel="alternate" type="application/n-triples"
                    href="{concat($path,$currentPartFile,'.nt')}"/>
                <link rel="alternate" type="application/rdf+xml"
                    href="{concat($path,$currentPartFile,'.rdf')}"/>
                <link rel="alternate" type="application/turtle"
                    href="{concat($path,$currentPartFile,'.ttl')}"/>
            </head>

            <body about="{$currentPartDoi}">
                <!-- Title of dataset -->
                <h1>
                    <xsl:value-of select="concat($datasetName, ', ', $currentPartName)"/>
                </h1>
                <!-- Links to other parts of the parent dataset, if applicable -->
                <h2>Access Other Parts of the Dataset:</h2>
                <ul>
                    <xsl:for-each select="$parts/parts/part[. != $currentPartName]">
                        <li>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:choose>
                                        <xsl:when test=". = $srPartName">
                                            <xsl:value-of select="$srDoi"/>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test=". = $aggrPartName">
                                            <xsl:value-of select="$aggrDoi"/>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test=". = $wrPartName">
                                            <xsl:value-of select="$wrDoi"/>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test=". = $collPartName">
                                            <xsl:value-of select="$collDoi"/>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test=". = $rightsPartName">
                                            <xsl:value-of select="$rightsDoi"/>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test=". = $agentPartName">
                                            <xsl:value-of select="$agentDoi"/>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>

                <!-- About the physical collection, if applicable -->
                <h2>About the <xsl:value-of select="$physCollName"/></h2>
                <p> The University of Washington Libraries’ <a href="{$findingAidUrl}"><xsl:value-of
                            select="$physCollName"/></a> include numerous physical collections
                    comprising a large number and variety of photographic and other materials.
                    Selections are available online as a <a href="{$digiCollUrl}">digital
                        collection</a>. </p>

                <!-- About the parent dataset, if applicable -->
                <h2>About the <xsl:value-of select="$datasetName"/></h2>
                <p>The RDF triples below are part of a larger dataset consisting of six parts, each
                    describing a particular class of resource. Each part is available in the
                    following file formats: HTML with embedded RDFa, N-Triples, Turtle, and RDF/XML.
                    All data is in the public domain and may be used without restriction. The
                    resources described by the data, however, do have restrictions on use.</p>
                <p>The dataset is structured primarily using classes and properties taken from the
                        <a href="https://pro.dp.la/hubs/metadata-application-profile">Digital Public
                        Library of America’s Metadata Application Profile (DPLA MAP version
                    5)</a>.</p>
                <p>All parts and file formats are accessible online. The HTML format contains
                    machine-readable RDFa data, and also serves as a human-readable landing page for
                    each part. Links to alternate serializations are contained in the introductory
                    material. No zipped downloads or SPARQL endpoints are currently available.</p>

                <!-- Links to alternate serializations -->
                <h2>Links to Alternate Serializations for <xsl:value-of select="$currentPartName"
                    /></h2>
                <ul>
                    <xsl:for-each select="$sers/sers/ser">
                        <li>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:choose>
                                        <xsl:when test=". = $nt">
                                            <xsl:value-of
                                                select="concat($path, $currentPartFile, '.nt')"/>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test=". = $turtle">
                                            <xsl:value-of
                                                select="concat($path, $currentPartFile, '.ttl')"/>
                                        </xsl:when>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test=". = $rdf">
                                            <xsl:value-of
                                                select="concat($path, $currentPartFile, '.rdf')"/>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>

                <!-- About the current dataset part (in the HTML table below) -->
                <!-- we have no info about the curent dataset part, ok?? -->

                <!-- Table headline -->
                <h2>RDF Triples for <xsl:value-of select="$currentPartName"/></h2>
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
                <br/>
                <br/>
                <hr/>

                <!-- Contact information -->
                <h3>Contact:</h3>
                <p>
                    <a href="https://www.lib.washington.edu/msd">University of Washington Libraries,
                        Cataloging and Metadata Services</a><br/> Box 352900, Seattle, WA
                    98195-2900<br/> Telephone: 206-543-1919<br/>
                    <a href="mailto:tgis@uw.edu">tgis@uw.edu</a></p>
                <br/>
                <hr/>

                <!-- CC0 image/link, rights statement -->
                <p>
                    <a href="http://creativecommons.org/publicdomain/zero/1.0/">
                        <img src="http://i.creativecommons.org/p/zero/1.0/88x31.png"
                            style="border-style: none;" alt="CC0"/>
                    </a>
                    <br/><br/> To the extent possible under law, the University of Washington
                    Libraries has waived all copyright and related or neighboring rights to the
                        <xsl:value-of select="$datasetName"/>. This work was published in the United
                    States. </p>
            </body>
        </html>
    </xsl:template>

    <!-- Be sure to include the actual RDFa transform! -->
    <xsl:include href="rdf2rdfa-table.xsl"/>

</xsl:stylesheet>
