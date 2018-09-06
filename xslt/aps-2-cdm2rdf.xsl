<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xxsl="http://www.w3.org/1999/XSL/TransformAlias"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dct="http://purl.org/dc/terms" xmlns:dpla="http://dp.la/about/map/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:rel="http://id.loc.gov/vocabulary/relators/"
    xmlns:edm="http://www.europeana.eu/schemas/edm/" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:foaf="xmlns:foaf=http://xmlns.com/foaf/0.1/"
    xmlns:dd="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries" version="2.0"
    xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    xmlns:bf="http://id.loc.gov/ontologies/bibframe/"
    exclude-result-prefixes="dd prop">
    <xsl:output indent="yes"/>
    <xsl:namespace-alias stylesheet-prefix="xxsl" result-prefix="xsl"/>
    <xsl:variable name="agentClass">http://www.europeana.eu/schemas/edm/Agent</xsl:variable>
    <xsl:variable name="lbrace">{</xsl:variable>
    <xsl:variable name="rbrace">}</xsl:variable>
    <xsl:variable name="transValueSelf">., ''' #.,:;()/\- ', ''</xsl:variable>
    <xsl:variable name="br">&lt;br&gt;&lt;br&gt;</xsl:variable>
    <xsl:template match="/">
        <xxsl:stylesheet version="2.0">
            <xxsl:output indent="yes"/>
            <xxsl:variable name="digitalCollectionUrl"/>
            <xxsl:variable name="agentFile">http://doi.org/10.6069/uwlib.55.A.3.6#</xxsl:variable>
            <xxsl:variable name="rightsFile">http://doi.org/10.6069/uwlib.55.A.3.5#</xxsl:variable>
            <xxsl:variable name="collectionFile"
                >http://doi.org/10.6069/uwlib.55.A.3.4#</xxsl:variable>
            <xxsl:variable name="sourceResourceFile"
                >http://doi.org/10.6069/uwlib.55.A.3.1#</xxsl:variable>
            <xxsl:variable name="aggregationFile"
                >http://doi.org/10.6069/uwlib.55.A.3.2#</xxsl:variable>
            <xxsl:variable name="webResourceFile">http://doi.org/10.6069/uwlib.55.A.3.3#</xxsl:variable>
            <xsl:comment>template for result documents</xsl:comment>
            <xxsl:template match="/">
                <xxsl:result-document href="sourceResource.rdf">
                    <rdf:RDF>
                        <xxsl:apply-templates select="metadata" mode="sr"/>
                    </rdf:RDF>
                </xxsl:result-document>
                <xxsl:result-document href="webResource.rdf">
                    <rdf:RDF>
                        <xxsl:apply-templates select="metadata" mode="wr"/>
                    </rdf:RDF>
                </xxsl:result-document>
                <xxsl:result-document href="aggregation.rdf">
                    <rdf:RDF>
                        <xxsl:apply-templates select="metadata" mode="agg"/>
                    </rdf:RDF>
                </xxsl:result-document>
                <xxsl:result-document href="rights.rdf">
                    <rdf:RDF>
                        <xxsl:apply-templates select="metadata" mode="rights"/>
                    </rdf:RDF>
                </xxsl:result-document>
                <xxsl:result-document href="agents.rdf">
                    <rdf:RDF>
                        <xxsl:apply-templates select="metadata" mode="agent"/>
                    </rdf:RDF>
                </xxsl:result-document>
                <xxsl:result-document href="collection.rdf">
                    <rdf:RDF>
                        <xxsl:apply-templates select="metadata" mode="collection"/>
                    </rdf:RDF>
                </xxsl:result-document>
            </xxsl:template>

            <xsl:comment>template for agent file</xsl:comment>
            <!-- also see 'meta-templates' below -->
            <xsl:apply-templates select="dd:migDataDictionary" mode="agent"/>

            <xsl:comment>template for aggregation file </xsl:comment>
            <xxsl:template match="metadata" mode="agg">
                <xxsl:apply-templates select="record" mode="agg"/>
            </xxsl:template>

            <xsl:comment>template for collection file</xsl:comment>
            <xsl:apply-templates select="dd:migDataDictionary" mode="collection"/>

            <xsl:comment>template for rights file</xsl:comment>
            <xsl:apply-templates select="dd:migDataDictionary" mode="rights"/>

            <xsl:comment>template for source resource file</xsl:comment>
            <xxsl:template match="metadata" mode="sr">
                <xxsl:apply-templates select="record" mode="sr"/>
            </xxsl:template>

            <xsl:comment>template for web resource file</xsl:comment>
            <xxsl:template match="metadata" mode="wr">
                <xxsl:apply-templates select="record" mode="wr"/>
            </xxsl:template>

            <xsl:comment>sub-template for aggregation file</xsl:comment>
            <xsl:apply-templates select="dd:migDataDictionary/dd:properties" mode="agg"/>

            <xsl:comment>sub-template for source resource file</xsl:comment>
            <xsl:apply-templates select="dd:migDataDictionary/dd:properties" mode="sr"/>

            <xsl:comment>sub-template for web resource file</xsl:comment>
            <xsl:apply-templates select="dd:migDataDictionary/dd:properties" mode="wr"/>

        </xxsl:stylesheet>
    </xsl:template>

    <!-- agent meta-template 1  -->
    <xsl:template match="dd:migDataDictionary" mode="agent">
        <xxsl:template match="metadata" mode="agent">
            <xsl:apply-templates
                select="dd:properties/prop:property/prop:rdf/prop:cdmRdf/prop:dpla[prop:object = 'uri' and prop:class = 'Agent']"
            />
        </xxsl:template>
    </xsl:template>

    <!-- aggregation meta-template 1 -->
    <xsl:template match="dd:migDataDictionary/dd:properties" mode="agg">
        <xxsl:template match="record" mode="agg">
            <rdf:Description
                rdf:about="{$lbrace}$aggregationFile{$rbrace}cdm{$lbrace}cdmnumber{$rbrace}">
                <rdf:type rdf:resource="http://www.openarchives.org/ore/terms/Aggregation"/>
            </rdf:Description>
            <xsl:apply-templates select="prop:property" mode="agg1"/>
        </xxsl:template>
        <xsl:comment>templates for CONTENTdm elements used by the Aggregation</xsl:comment>
        <xsl:apply-templates select="prop:property" mode="agg2"/>
    </xsl:template>
    <!-- aggregation meta-template 2.0 -->
    <xsl:template match="prop:property" mode="agg1">
        <xsl:if test="prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'Aggregation'">
            <xxsl:apply-templates select="{translate(prop:cdm/prop:label,' ','')}" mode="agg"/>
        </xsl:if>
    </xsl:template>
    <!-- aggregation meta-template 2.1, prodecues templates for cdm properties -->
    <xsl:template match="prop:property" mode="agg2">
        <xsl:choose>
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'uri' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'Rights' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'Aggregation'">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="agg">
                    <xxsl:if test="text()">
                        <rdf:Description
                            rdf:about="{$lbrace}$aggregationFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                            <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of
                                        select="concat($lbrace, '$rightsFile', $rbrace, prop:labels/prop:platformIndependent)"
                                    />
                                </xsl:attribute>
                            </xsl:element>
                        </rdf:Description>
                    </xxsl:if>
                </xxsl:template>
            </xsl:when>
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'uri' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'Agent' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'Aggregation'">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="agg">
                    <xxsl:if test="text()">
                        <rdf:Description
                            rdf:about="{$lbrace}$aggregationFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                            <xsl:element
                                name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map[@class='Aggregation']}">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of
                                        select="$lbrace, 'concat($agentFile,', 'translate(', $transValueSelf, '))', $rbrace"/>
                                    <!--<xsl:value-of select="concat($lbrace,'concat(',$lbrace,'$agentFile',$rbrace,'translate(',$transValueSelf,')',$rbrace)"/>-->
                                </xsl:attribute>
                            </xsl:element>
                        </rdf:Description>
                    </xxsl:if>
                </xxsl:template>
            </xsl:when>
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'literal' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'uri' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'Aggregation'">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="agg">
                    <xxsl:if test="text()">
                        <rdf:Description
                            rdf:about="{$lbrace}$aggregationFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                            <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of select="concat($lbrace, '.', $rbrace)"/>
                                    <!--<xsl:value-of select="concat($lbrace,'concat(',$lbrace,'$agentFile',$rbrace,'translate(',$transValueSelf,')',$rbrace)"/>-->
                                </xsl:attribute>
                            </xsl:element>
                        </rdf:Description>
                    </xxsl:if>
                </xxsl:template>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

    <!-- collection meta-template 1 -->
    <xsl:template match="dd:migDataDictionary" mode="collection">
        <xxsl:template match="metadata" mode="collection">
            <xsl:apply-templates
                select="dd:properties/prop:property/prop:rdf/prop:cdmRdf/prop:dpla[prop:object = 'uri' and prop:class = 'Collection']"
            />
        </xxsl:template>
    </xsl:template>

    <!-- rights meta-template 1 -->
    <xsl:template match="dd:migDataDictionary" mode="rights">
        <xxsl:template match="metadata" mode="rights">
            <xsl:apply-templates
                select="dd:properties/prop:property/prop:rdf/prop:cdmRdf/prop:dpla[prop:object = 'uri' and prop:class = 'Rights' and prop:node]"
            />
        </xxsl:template>
    </xsl:template>

    <!-- agent meta-template 2 -->
    <xsl:template
        match="dd:properties/prop:property/prop:rdf/prop:cdmRdf/prop:dpla[prop:object = 'uri' and prop:class = 'Agent']">
        <xxsl:for-each-group select="record"
            group-by="{translate(../../../prop:cdm/prop:label,' ','')}[text() != '' and text() != 'Unidentified' and text() != 'unidentified']">
            <xsl:for-each select="prop:node/prop:triple">
                <rdf:Description
                    rdf:about="{$lbrace}concat($agentFile,translate(current-grouping-key(),''&#x27; #.,:;()/\- ', '')){$rbrace}">
                    <xsl:element name="{prop:p}">
                        <xsl:choose>
                            <!-- when <o> is a uri -->
                            <xsl:when test="starts-with(prop:o, 'http://')">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of select="prop:o"/>
                                </xsl:attribute>
                            </xsl:when>
                            <!-- when the value of the cdm element is used -->
                            <xsl:when test="prop:o = 'value-of'">
                                <xsl:if test="prop:p/@xml:lang">
                                    <xsl:attribute name="{name(prop:p/@xml:lang)}">
                                        <xsl:value-of select="prop:p/@xml:lang"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xxsl:value-of select="current-grouping-key()"/>
                            </xsl:when>
                            <!-- when the value is taken from an xml node in the property file -->
                            <xsl:when test="prop:o[@node = 'xml']">
                                <xsl:if test="prop:p/@xml:lang">
                                    <xsl:attribute name="{name(prop:p/@xml:lang)}">
                                        <xsl:value-of select="prop:p/@xml:lang"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xxsl:value-of select="{prop:o}"/>
                            </xsl:when>
                            <!-- when the value needs to be an rdf literal in the xsl output from this xsl -->
                            <xsl:when test="prop:o[@node = 'rdf']">
                                <xsl:if test="prop:p/@xml:lang">
                                    <xsl:attribute name="{name(prop:p/@xml:lang)}">
                                        <xsl:value-of select="prop:p/@xml:lang"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="prop:o"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xxsl:value-of select="{prop:o}"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </rdf:Description>
            </xsl:for-each>
        </xxsl:for-each-group>
    </xsl:template>

    <!-- collection meta-template 2 -->
    <xsl:template
        match="dd:properties/prop:property/prop:rdf/prop:cdmRdf/prop:dpla[prop:object = 'uri' and prop:class = 'Collection']">
        <xxsl:for-each-group select="record"
            group-by="{translate(../../../prop:cdm/prop:label,' ','')}">
            <xsl:for-each select="prop:node/prop:triple">
                <rdf:Description
                    rdf:about="{$lbrace}concat($collectionFile,translate(current-grouping-key(), ''&#x27; #.,:;()/\- ', '')){$rbrace}">
                    <xsl:element name="{prop:p}">
                        <xsl:choose>
                            <!-- when <o> is a uri -->
                            <xsl:when test="starts-with(prop:o, 'http://')">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of select="prop:o"/>
                                </xsl:attribute>
                            </xsl:when>
                            <!-- when the value of the cdm element is used -->
                            <xsl:when test="prop:o = 'value-of'">
                                <xsl:if test="prop:p/@xml:lang">
                                    <xsl:attribute name="{name(prop:p/@xml:lang)}">
                                        <xsl:value-of select="prop:p/@xml:lang"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xxsl:value-of select="current-grouping-key()"/>
                            </xsl:when>
                            <!-- when <o> is a value in an attribute of the xsl produced by this xsl ~and~ that var value is a URI or URL -->
                            <xsl:when test="starts-with(prop:o, '$')">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of select="prop:o"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:otherwise>
                                <xxsl:value-of select="{prop:o}"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </rdf:Description>
            </xsl:for-each>
        </xxsl:for-each-group>
    </xsl:template>

    <!-- rights meta-template 2 -->
    <xsl:template
        match="dd:properties/prop:property/prop:rdf/prop:cdmRdf/prop:dpla[prop:object = 'uri' and prop:class = 'Rights' and prop:node]">
        <xxsl:for-each-group select="record"
            group-by="{translate(../../../prop:cdm/prop:label,' ','')}">
            <xsl:for-each select="prop:node/prop:triple">
                <!-- editing below 2018-09-04
                rdf:about="{$lbrace}concat($rightsFile,'{translate(../../../../../prop:cdm/prop:label,' ','')}'){$rbrace}"
                replaces
                    rdf:about="{$lbrace}concat($rightsFile,translate(current-grouping-key(), ''&#x27; #.,:;()/\- ', '')){$rbrace}"
                -->
                <rdf:Description
                    rdf:about="{$lbrace}concat($rightsFile,'{translate(../../../../../prop:cdm/prop:label,' ','')}'){$rbrace}">
                    <xsl:element name="{prop:p}">
                        <xsl:choose>
                            <xsl:when test="starts-with(prop:o, 'http://')">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of select="prop:o"/>
                                </xsl:attribute>
                            </xsl:when>
                            <xsl:when test="prop:o = 'value-of'">
                                <xsl:if test="prop:p/@xml:lang">
                                    <xsl:attribute name="{name(prop:p/@xml:lang)}">
                                        <xsl:value-of select="prop:p/@xml:lang"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xxsl:value-of select="current-grouping-key()"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xxsl:value-of select="{prop:o}"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </rdf:Description>
            </xsl:for-each>
        </xxsl:for-each-group>
    </xsl:template>

    <!-- source resouce meta-template 1 = "sub-template for the sr -->
    <xsl:template match="dd:migDataDictionary/dd:properties" mode="sr">
        <xxsl:template match="record" mode="sr">
            <rdf:Description
                rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}cdmnumber{$rbrace}">
                <rdf:type rdf:resource="http://dp.la/about/map/SourceResource"/>
            </rdf:Description>
            <xsl:apply-templates select="prop:property" mode="sr1"/>
        </xxsl:template>
        <xsl:comment>templates for CONTENTdm elements used by the SourceResource</xsl:comment>
        <xsl:apply-templates select="prop:property" mode="sr2"/>
    </xsl:template>
    <!-- source resource meta template 2 = apply-templates for the sub-template for the sr -->
    <xsl:template match="prop:property" mode="sr1">
        <xsl:choose>
            <!-- choice 1: URIs and literals in the object -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'SourceResource' and (prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'uri' or prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'literal')">
                <xxsl:apply-templates select="{translate(prop:cdm/prop:label,' ','')}" mode="sr"/>
            </xsl:when>
            <!-- choice 2: bnode without param, as in subjects -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'SourceResource' and prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'bnode' and prop:rdf/prop:cdmRdf/prop:dpla/prop:process = 'cleanSubjects'">
                <xxsl:apply-templates select="{translate(prop:cdm/prop:label,' ()','')}" mode="sr"/>
            </xsl:when>
            <!-- choice 3: bnode with param, as in DateEdtf -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'SourceResource' and prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'bnode' and not(prop:rdf/prop:cdmRdf/prop:dpla/prop:process)">
                <xxsl:apply-templates select="{translate(prop:cdm/prop:label,' ''''','')}">
                    <xxsl:with-param name="{translate(prop:cdm/prop:label,' ''''','')}ID"
                        select="{concat('concat(','''',translate(prop:cdm/prop:label,' ''''',''),'''',',','generate-id())')}"
                    />
                </xxsl:apply-templates>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- source resource meta-template 3 = templates by cdm element -->
    <xsl:template match="prop:property" mode="sr2">
        <xsl:choose><!-- many choices below! -->
            <!-- choice 1: title, physicalDescription-->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'literal' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'SourceResource' and not(prop:rdf/prop:cdmRdf/prop:dpla/prop:process)">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="sr">
                    <xxsl:if test="text()">
                        <rdf:Description
                            rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                            <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                <xsl:if test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object/@xml:lang">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of
                                            select="prop:rdf/prop:cdmRdf/prop:dpla/prop:object/@xml:lang"
                                        />
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:if test="prop:rdf/prop:cdmRdf/prop:dpla/prop:map/@xml:lang">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="prop:rdf/prop:cdmRdf/prop:dpla/prop:map/@xml:lang"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xxsl:value-of select="."/>
                            </xsl:element>
                        </rdf:Description>
                    </xxsl:if>
                </xxsl:template>
            </xsl:when>
            <!-- choice 2: Notes -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'literal' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'SourceResource' and prop:rdf/prop:cdmRdf/prop:dpla/prop:process = 'cleanNotes'">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="sr">
                    <xxsl:if test="text()">
                        <xxsl:choose>
                            <xxsl:when test="contains(., {concat('''',$br,'''')})">
                                <xxsl:call-template name="{translate(prop:cdm/prop:label,' ','')}">
                                    <xxsl:with-param name="CdmNumber" select="../cdmnumber"/>
                                    <xxsl:with-param name="Tokens" select="tokenize(.,{concat('''',$br,'''')})"/>
                                </xxsl:call-template>
                            </xxsl:when>
                            <xxsl:otherwise>
                                <rdf:Description
                                    rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                                    <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                        <xsl:if test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object/@xml:lang">
                                            <xsl:attribute name="xml:lang">
                                                <xsl:value-of
                                                    select="prop:rdf/prop:cdmRdf/prop:dpla/prop:object/@xml:lang"
                                                />
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xsl:if test="prop:rdf/prop:cdmRdf/prop:dpla/prop:map/@xml:lang">
                                            <xsl:attribute name="xml:lang">
                                                <xsl:value-of select="prop:rdf/prop:cdmRdf/prop:dpla/prop:map/@xml:lang"/>
                                            </xsl:attribute>
                                        </xsl:if>
                                        <xxsl:value-of select="."/>
                                    </xsl:element>
                                </rdf:Description>
                            </xxsl:otherwise>
                        </xxsl:choose>
                    </xxsl:if>
                </xxsl:template>
                <xxsl:template name="{translate(prop:cdm/prop:label,' ','')}">
                    <xxsl:param name="CdmNumber"/>
                    <xxsl:param name="Tokens"/>
                    <xxsl:for-each select="$Tokens">
                        <rdf:Description rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}$CdmNumber{$rbrace}">
                            <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                <xsl:if test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object/@xml:lang">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of
                                            select="prop:rdf/prop:cdmRdf/prop:dpla/prop:object/@xml:lang"
                                        />
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:if test="prop:rdf/prop:cdmRdf/prop:dpla/prop:map/@xml:lang">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="prop:rdf/prop:cdmRdf/prop:dpla/prop:map/@xml:lang"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xxsl:value-of select="."/>
                            </xsl:element>
                        </rdf:Description>
                    </xxsl:for-each>
                </xxsl:template>
            </xsl:when>
            <!-- choice 3: Photographer -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'uri' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'Agent' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'SourceResource'">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="sr">
                    <xxsl:if test="text() and . != 'Unidentified' and . != 'unidentified '">
                        <rdf:Description
                            rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                            <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map[not(@class)]}">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of
                                        select="$lbrace, 'concat($agentFile,', 'translate(', $transValueSelf, '))', $rbrace"
                                    />
                                </xsl:attribute>
                            </xsl:element>
                        </rdf:Description>
                    </xxsl:if>
                </xxsl:template>
            </xsl:when>
            <!-- choice 4: Repository Collection -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'uri' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'Collection' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'SourceResource'">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="sr">
                    <xxsl:if test="text() and . != 'Unidentified' and . != 'unidentified '">
                        <rdf:Description
                            rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                            <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of
                                        select="$lbrace, 'concat($collectionFile,', 'translate(', $transValueSelf, '))', $rbrace"
                                    />
                                </xsl:attribute>
                            </xsl:element>
                        </rdf:Description>
                    </xxsl:if>
                </xxsl:template>
            </xsl:when>
            <!-- choice 5: DateEDTF, Negative Number, photographersReferenceNumber -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'bnode' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'SourceResource' and not(prop:rdf/prop:cdmRdf/prop:dpla/prop:process)">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ''''','')}">
                    <xxsl:param name="{translate(prop:cdm/prop:label,' ''''','')}ID"/>
                    <xxsl:if test="text()">
                        <rdf:Description
                            rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}')">
                            <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                <xsl:attribute name="rdf:nodeID">
                                    <xsl:value-of
                                        select="concat($lbrace, '$', translate(prop:cdm/prop:label, ' ''''', ''), 'ID', $rbrace)"
                                    />
                                </xsl:attribute>
                            </xsl:element>
                        </rdf:Description>
                        <xsl:for-each select="prop:rdf/prop:cdmRdf/prop:dpla/prop:node/prop:triple">
                            <rdf:Description>
                                <xsl:attribute name="rdf:nodeID">
                                    <xsl:value-of
                                        select="concat($lbrace, '$', translate(../../../../../prop:cdm/prop:label, ' ''''', ''), 'ID', $rbrace)"
                                    />
                                </xsl:attribute>
                                <xsl:element name="{prop:p}">
                                    <xsl:if test="prop:p/@xml:lang">
                                        <xsl:attribute name="{name(prop:p/@xml:lang)}">
                                            <xsl:value-of select="prop:p/@xml:lang"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:choose>
                                        <!-- when <o> is a uri -->
                                        <xsl:when test="starts-with(prop:o, 'http://')">
                                            <xsl:attribute name="rdf:resource">
                                                <xsl:value-of select="prop:o"/>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <!-- when <o> contains an XPath expression -->
                                        <xsl:when test="contains(prop:o, '::')">
                                            <xxsl:value-of select="{prop:o}"/>
                                        </xsl:when>
                                        <!-- when the CONTENTdm value is the value of the RDF property -->
                                        <xsl:when test="prop:o='value-of'">
                                            <xxsl:value-of select="."/>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:element>
                            </rdf:Description>
                        </xsl:for-each>
                    </xxsl:if>
                </xxsl:template>
            </xsl:when>
            <!-- choice 6: SubjectsLctgm -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'bnode' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'SourceResource' and prop:rdf/prop:cdmRdf/prop:dpla/prop:process = 'cleanSubjects'">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ()','')}" mode="sr">
                    <xxsl:if test="text()">
                        <xxsl:choose>
                            <xxsl:when test="contains(., ';')">
                                <xxsl:call-template name="{translate(prop:cdm/prop:label,' ()','')}">
                                    <xxsl:with-param name="Tokens" select="tokenize(., ';\s*')"/>
                                    <xxsl:with-param name="CdmNumber" select="../cdmnumber"/>
                                </xxsl:call-template>
                            </xxsl:when>
                            <xxsl:otherwise>
                                <xxsl:variable name="{translate(prop:cdm/prop:label,' ()','')}ID" select="concat('{translate(prop:cdm/prop:label,' ()','')}',generate-id())"/>
                                <rdf:Description
                                    rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                                    <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                        <xsl:attribute name="rdf:nodeID">
                                            <xsl:value-of
                                                select="concat($lbrace, '$', translate(prop:cdm/prop:label, ' ()', ''), 'ID', $rbrace)"
                                            />
                                        </xsl:attribute>
                                    </xsl:element>
                                </rdf:Description>
                                <xsl:for-each select="prop:rdf/prop:cdmRdf/prop:dpla/prop:node/prop:triple">
                                    <rdf:Description>
                                        <xsl:attribute name="rdf:nodeID">
                                            <xsl:value-of
                                                select="concat($lbrace, '$', translate(../../../../../prop:cdm/prop:label, ' ()', ''), 'ID', $rbrace)"
                                            />
                                        </xsl:attribute>
                                        <xsl:element name="{prop:p}">
                                            <xsl:if test="prop:p/@xml:lang">
                                                <xsl:attribute name="{name(prop:p/@xml:lang)}">
                                                    <xsl:value-of select="prop:p/@xml:lang"/>
                                                </xsl:attribute>
                                            </xsl:if>
                                            <xsl:choose>
                                                <!-- when <o> is a uri -->
                                                <xsl:when test="starts-with(prop:o, 'http://')">
                                                    <xsl:attribute name="rdf:resource">
                                                        <xsl:value-of select="prop:o"/>
                                                    </xsl:attribute>
                                                </xsl:when>
                                                <!-- when <o> contains an XPath expression -->
                                                <xsl:when test="contains(prop:o, '::')">
                                                    <xxsl:value-of select="{prop:o}"/>
                                                </xsl:when>
                                                <!-- when the CONTENTdm value is the value of the RDF property -->
                                                <xsl:when test="prop:o='value-of'">
                                                    <xxsl:value-of select="."/>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:element>
                                    </rdf:Description>
                                </xsl:for-each>
                            </xxsl:otherwise>
                        </xxsl:choose>
                    </xxsl:if>
                </xxsl:template>
                <xxsl:template name="{translate(prop:cdm/prop:label,' ()','')}">
                    <xxsl:param name="Tokens"/>
                    <xxsl:param name="CdmNumber"/>
                    <xxsl:variable name="{translate(prop:cdm/prop:label,' ()','')}ID" select="concat({translate(prop:cdm/prop:label,' ()','')},generate-id())"/>
                    <xxsl:for-each select="$Tokens">
                        <rdf:Description rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}$CdmNumber{$rbrace}">
                            <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                <xsl:attribute name="rdf:nodeID">
                                    <xsl:value-of select="concat($lbrace,'concat($',translate(prop:cdm/prop:label,' ()',''),'ID',',','position())',$rbrace)"/>
                                </xsl:attribute>
                            </xsl:element>
                        </rdf:Description>
                        <xsl:for-each select="prop:rdf/prop:cdmRdf/prop:dpla/prop:node/prop:triple">
                            <rdf:Description>
                                <xsl:attribute name="rdf:nodeID">
                                    <xsl:value-of select="concat($lbrace,'concat($',translate(../../../../../prop:cdm/prop:label,' ()',''),'ID',',','position())',$rbrace)"/>
                                </xsl:attribute>
                                <xsl:element name="{prop:p}">
                                    <xsl:if test="prop:p/@xml:lang">
                                        <xsl:attribute name="{name(prop:p/@xml:lang)}">
                                            <xsl:value-of select="prop:p/@xml:lang"/>
                                        </xsl:attribute>
                                    </xsl:if>
                                    <xsl:choose>
                                        <!-- when <o> is a uri -->
                                        <xsl:when test="starts-with(prop:o, 'http://')">
                                            <xsl:attribute name="rdf:resource">
                                                <xsl:value-of select="prop:o"/>
                                            </xsl:attribute>
                                        </xsl:when>
                                        <!-- when <o> contains an XPath expression -->
                                        <xsl:when test="contains(prop:o, '::')">
                                            <xxsl:value-of select="{prop:o}"/>
                                        </xsl:when>
                                        <!-- when the CONTENTdm value is the value of the RDF property -->
                                        <xsl:when test="prop:o='value-of'">
                                            <xxsl:value-of select="."/>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:element>
                            </rdf:Description>
                        </xsl:for-each>
                    </xxsl:for-each>
                </xxsl:template>
            </xsl:when>
            <!-- choice 7: object type -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'literal' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'SourceResource' and prop:rdf/prop:cdmRdf/prop:dpla/prop:process = 'conditions'">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ()','')}" mode="sr">
                    <xxsl:if test="text()">
                            <xxsl:choose>
                                <xsl:for-each select="prop:rdf/prop:cdmRdf/prop:dpla/prop:condition">
                                    <xxsl:when>
                                        <xsl:attribute name="test"><xsl:value-of select="prop:test"/></xsl:attribute>
                                        <rdf:Description rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                                            <xsl:element name="{prop:p}">
                                                <xsl:attribute name="rdf:resource">
                                                    <xsl:value-of select="prop:o"/>
                                                </xsl:attribute>
                                            </xsl:element>
                                        </rdf:Description>
                                    </xxsl:when>
                                </xsl:for-each>
                                <xxsl:otherwise>
                                    <rdf:Description rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                                    <dc:type xml:lang="en">
                                        <xxsl:value-of select="."/>
                                    </dc:type>
                                    </rdf:Description>
                                </xxsl:otherwise>
                            </xxsl:choose>
                    </xxsl:if>
                </xxsl:template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- web resouce meta-template 1 = "sub-template for the wr" -->
    <xsl:template match="dd:migDataDictionary/dd:properties" mode="wr">
        <xxsl:template match="record" mode="wr">
            <rdf:Description rdf:about="{$lbrace}$webResourceFile{$rbrace}cdm{$lbrace}cdmnumber{$rbrace}">
                <rdf:type rdf:resource="http://www.europeana.eu/schemas/edm/WebResource"/>
            </rdf:Description>
            <xsl:apply-templates select="prop:property" mode="wr1"/>
        </xxsl:template>
        <xsl:comment>templates for CONTENTdm elements used by the WebResource</xsl:comment>
        <xsl:apply-templates select="prop:property" mode="wr2"/>
    </xsl:template>
    <!-- web resource meta template 2 = apply-templates for the sub-template for the wr -->
    <xsl:template match="prop:property" mode="wr1">
        <xsl:choose>
            <!-- choice 1: URIs and literals in the object -->
            <!-- nb: this should be ok for locally minted uris right? just insert the prop name into apply-templates -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'WebResource' and (prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'uri' or prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'literal')">
                <xxsl:apply-templates select="{translate(prop:cdm/prop:label,' ','')}" mode="wr"/>
            </xsl:when>
            <!-- choice 2: locally minted URIs in the object ... should be absorbed by choice 1 -->
            <!-- choice 3: bnode with-param in the object -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'WebResource' and prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'bnode' and not(prop:rdf/prop:cdmRdf/prop:dpla/prop:process)">
                <xxsl:apply-templates select="{translate(prop:cdm/prop:label,' ','')}" mode="wr">
                    <xxsl:with-param name="{translate(prop:cdm/prop:label,' ','')}ID"
                        select="{concat('concat(','''',translate(prop:cdm/prop:label,' ',''),'''',',','generate-id())')}"
                    />
                </xxsl:apply-templates>
            </xsl:when>
            <!-- choice 4: bnode without param; prob needed because there are not adequate ways to differentiate bnodes; need to use bnode+!(process above) and, here, bnode+process=x ; however not needed for ayp wr-->
        </xsl:choose>
    </xsl:template>
    <!-- web resource meta-template 3 = templates by cdm element -->
    <xsl:template match="prop:property" mode="wr2">
        <xsl:choose>
            <!-- choice 1: title, DRI -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'literal' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'WebResource' and not(prop:rdf/prop:cdmRdf/prop:dpla/prop:process)">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="wr">
                    <xxsl:if test="text()">
                        <rdf:Description
                            rdf:about="{$lbrace}$sourceResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                            <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                <xsl:if test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object/@xml:lang">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of
                                            select="prop:rdf/prop:cdmRdf/prop:dpla/prop:object/@xml:lang"
                                        />
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:if test="prop:rdf/prop:cdmRdf/prop:dpla/prop:map/@xml:lang">
                                    <xsl:attribute name="xml:lang">
                                        <xsl:value-of select="prop:rdf/prop:cdmRdf/prop:dpla/prop:map/@xml:lang"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xxsl:value-of select="."/>
                            </xsl:element>
                        </rdf:Description>
                    </xxsl:if>
                </xxsl:template>
            </xsl:when>
            <!-- choice 2: digital collection -->
            <xsl:when
                test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'uri' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'Collection' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'WebResource'">
                <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="wr">
                    <xxsl:if test="text() and . != 'Unidentified' and . != 'unidentified '">
                        <rdf:Description
                            rdf:about="{$lbrace}$webResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                            <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                                <xsl:attribute name="rdf:resource">
                                    <xsl:value-of
                                        select="$lbrace, 'concat($collectionFile,', 'translate(', $transValueSelf, '))', $rbrace"
                                    />
                                </xsl:attribute>
                            </xsl:element>
                        </rdf:Description>
                    </xxsl:if>
                </xxsl:template>
            </xsl:when>
        <!-- choice 3: ordering info -->
        <xsl:when
            test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'uri' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'Rights' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'WebResource'">
            <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="wr">
                <xxsl:if test="text()">
                    <rdf:Description
                        rdf:about="{$lbrace}$aggregationFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}">
                        <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of
                                    select="concat($lbrace, '$rightsFile', $rbrace, prop:labels/prop:platformIndependent)"
                                />
                            </xsl:attribute>
                        </xsl:element>
                    </rdf:Description>
                </xxsl:if>
            </xxsl:template>
        </xsl:when>
        <!-- choice 4: orderNumber -->
        <xsl:when
            test="prop:rdf/prop:cdmRdf/prop:dpla/prop:object = 'bnode' and prop:rdf/prop:cdmRdf/prop:dpla/prop:class = 'WebResource' and not(prop:rdf/prop:cdmRdf/prop:dpla/prop:process)">
            <xxsl:template match="{translate(prop:cdm/prop:label,' ','')}" mode="wr">
                <xxsl:param name="{translate(prop:cdm/prop:label,' ','')}ID"/>
                <xxsl:if test="text()">
                    <rdf:Description
                        rdf:about="{$lbrace}$webResourceFile{$rbrace}cdm{$lbrace}../cdmnumber{$rbrace}')">
                        <xsl:element name="{prop:rdf/prop:cdmRdf/prop:dpla/prop:map}">
                            <xsl:attribute name="rdf:nodeID">
                                <xsl:value-of
                                    select="concat($lbrace, '$', translate(prop:cdm/prop:label, ' ', ''), 'ID', $rbrace)"
                                />
                            </xsl:attribute>
                        </xsl:element>
                    </rdf:Description>
                    <xsl:for-each select="prop:rdf/prop:cdmRdf/prop:dpla/prop:node/prop:triple">
                        <rdf:Description>
                            <xsl:attribute name="rdf:nodeID">
                                <xsl:value-of
                                    select="concat($lbrace, '$', translate(../../../../../prop:cdm/prop:label, ' ', ''), 'ID', $rbrace)"
                                />
                            </xsl:attribute>
                            <xsl:element name="{prop:p}">
                                <xsl:if test="prop:p/@xml:lang">
                                    <xsl:attribute name="{name(prop:p/@xml:lang)}">
                                        <xsl:value-of select="prop:p/@xml:lang"/>
                                    </xsl:attribute>
                                </xsl:if>
                                <xsl:choose>
                                    <!-- when <o> is a uri -->
                                    <xsl:when test="starts-with(prop:o, 'http://')">
                                        <xsl:attribute name="rdf:resource">
                                            <xsl:value-of select="prop:o"/>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <!-- when <o> contains an XPath expression -->
                                    <xsl:when test="contains(prop:o, '::')">
                                        <xxsl:value-of select="{prop:o}"/>
                                    </xsl:when>
                                    <!-- when the CONTENTdm value is the value of the RDF property -->
                                    <xsl:when test="prop:o='value-of'">
                                        <xxsl:value-of select="."/>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:element>
                        </rdf:Description>
                    </xsl:for-each>
                </xxsl:if>
            </xxsl:template>
        </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
