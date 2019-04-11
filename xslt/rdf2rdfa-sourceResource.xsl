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
    xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0">

    <xsl:strip-space elements="*"/>

    <xsl:template match="/">

        <!-- Variables -->
        <xsl:variable name="currBaseIri">https://doi.org/10.6069/uwlib.55.a.3.1</xsl:variable>

        <xsl:variable name="uwlswdBaseIri" select="document('https://doi.org/10.6069/uwlib.55.a')"/>
        <xsl:variable name="uwlswdResource"
            >https://doi.org/10.6069/uwlib.55.a#uwSemWeb</xsl:variable>

        <xsl:variable name="srPartBaseIri"
            select="document('https://doi.org/10.6069/uwlib.55.A.3.1')"/>
        <xsl:variable name="aggPartBaseIri"
            select="document('https://doi.org/10.6069/uwlib.55.A.3.2')"/>
        <xsl:variable name="wrPartBaseIri"
            select="document('https://doi.org/10.6069/uwlib.55.A.3.3')"/>
        <xsl:variable name="collPartBaseIri"
            select="document('https://doi.org/10.6069/uwlib.55.A.3.4')"/>
        <xsl:variable name="rsPartBaseIri"
            select="document('https://doi.org/10.6069/uwlib.55.A.3.5')"/>
        <xsl:variable name="agentPartBaseIri"
            select="document('https://doi.org/10.6069/uwlib.55.a.3.6')"/>

        <xsl:variable name="uwlIri"
            >https://doi.org/10.6069/uwlib.55.A.3.6#UniversityofWashingtonLibraries</xsl:variable>

        <!-- XHTML+RDFa output -->
        <html xmlns="http://www.w3.org/1999/xhtml" version="XHTML+RDFa 1.1"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.w3.org/1999/xhtml http://www.w3.org/MarkUp/SCHEMA/xhtml-rdfa-2.xsd"
            lang="en" xml:lang="en">
            <head>
                <title>
                    <xsl:value-of
                        select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $uwlswdResource]/xhtml:td[@property = 'dct:title']"
                    />
                </title>

                <script type="application/ld+json"> <!-- To-do: Markup values that differ for each partition still need to move into schemaOrgMarkup.xsl if possible -->
                  <xsl:call-template name="jsonMarkup1"/>
    "@id" : "<xsl:value-of select="$currBaseIri"/>" ,
    "name" : "<xsl:value-of select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:title']"/>" ,
    "description" : "<xsl:value-of select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:description']"/>" ,
    "datePublished" : "<xsl:value-of select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:issued']"/>" ,
                  <xsl:call-template name="jsonMarkup2"/>
                </script>

                <xsl:for-each
                    select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:hasFormat']">
                    <xsl:choose>
                        <xsl:when test="ends-with(., '.nt')">
                            <link rel="alternate" type="application/n-triples" href="{.}"/>
                        </xsl:when>
                        <xsl:when test="ends-with(., '.rdf')">
                            <link rel="alternate" type="application/rdf+xml" href="{.}"/>
                        </xsl:when>
                        <xsl:when test="ends-with(., '.ttl')">
                            <link rel="alternate" type="text/turtle" href="{.}"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>

            </head>

            <body>
                <!-- Dataset title -->
                <h1>
                    <xsl:value-of
                        select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:title']"
                    />
                </h1>
                <!-- Dataset description -->
                <p>
                    <xsl:value-of
                        select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:description']"
                    />
                </p>
                <!-- Backlink -->
                <h2>Backlink</h2>
                <!-- Q: Took a shortcut to populate href. Could this cause problems later? -->
                <p>This dataset is part of the dataset <a href="{$uwlswdResource}">
                        <xsl:value-of
                            select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $uwlswdResource]/xhtml:td[@property = 'dct:title']"
                        />
                    </a>
                </p>
                <!-- Alternate serializations -->
                <h2>Links to Alternate Serializations for <xsl:value-of
                        select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:title']"
                    /></h2>
                <ul>
                    <xsl:for-each
                        select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:hasFormat']">
                        <xsl:choose>
                            <xsl:when test="ends-with(@resource, '.nt')">
                                <li>
                                    <a href="{@resource}">N-Triples</a>
                                </li>
                            </xsl:when>
                            <xsl:when test="ends-with(@resource, '.rdf')">
                                <li>
                                    <a href="{@resource}">RDF/XML</a>
                                </li>
                            </xsl:when>
                            <xsl:when test="ends-with(@resource, '.ttl')">
                                <li>
                                    <a href="{@resource}">Turtle</a>
                                </li>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </ul>
                <!-- Versioning -->
                <h2>Version Information</h2>
                <p>Version <xsl:value-of
                        select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'owl:version']"
                    />
                </p>
                <p>Issued <xsl:value-of
                        select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:issued']"
                    />
                </p>
                <!-- Table headline -->
                <h2>RDF Triples for <xsl:value-of
                    select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:title']"
                    /></h2>
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
                    <br/>
                    <br/>
                    <xsl:text>To the extent possible under law, the University of Washington Libraries has waived all copyright and related or neighboring rights to the </xsl:text>
                    <xsl:value-of
                        select="$uwlswdBaseIri/xhtml:html/xhtml:body/xhtml:table/xhtml:tr[@about = $currBaseIri]/xhtml:td[@property = 'dct:title']"/>
                    <xsl:text>. This work was published in the United States.</xsl:text>
                </p>
            </body>
        </html>
    </xsl:template>

    <!-- Be sure to include the actual RDFa transform! -->
    <xsl:include href="rdf2rdfa-table.xsl"/>
    <xsl:include href="schemaOrgMarkup.xsl"/>

</xsl:stylesheet>
