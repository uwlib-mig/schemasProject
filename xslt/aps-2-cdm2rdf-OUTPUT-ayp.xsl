<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dct="http://purl.org/dc/terms"
                xmlns:dpla="http://dp.la/about/map/"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:rel="http://id.loc.gov/vocabulary/relators/"
                xmlns:edm="http://www.europeana.eu/schemas/edm/"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:foaf="xmlns:foaf=http://xmlns.com/foaf/0.1/"
                xmlns:bf="http://id.loc.gov/ontologies/bibframe/"
                version="2.0">
   <xsl:output indent="yes"/>
   <xsl:variable name="digitalCollectionUrl"/>
   <xsl:variable name="agentFile">http://doi.org/10.6069/uwlib.55.A.3.6#</xsl:variable>
   <xsl:variable name="rightsFile">http://doi.org/10.6069/uwlib.55.A.3.5#</xsl:variable>
   <xsl:variable name="collectionFile">http://doi.org/10.6069/uwlib.55.A.3.4#</xsl:variable>
   <xsl:variable name="sourceResourceFile">http://doi.org/10.6069/uwlib.55.A.3.1#</xsl:variable>
   <xsl:variable name="aggregationFile">http://doi.org/10.6069/uwlib.55.A.3.2#</xsl:variable>
   <xsl:variable name="webResourceFile">http://doi.org/10.6069/uwlib.55.A.3.3#</xsl:variable>
   <!--template for result documents-->
   <xsl:template match="/">
      <xsl:result-document href="sourceResource.rdf">
         <rdf:RDF>
            <xsl:apply-templates select="metadata" mode="sr"/>
         </rdf:RDF>
      </xsl:result-document>
      <xsl:result-document href="webResource.rdf">
         <rdf:RDF>
            <xsl:apply-templates select="metadata" mode="wr"/>
         </rdf:RDF>
      </xsl:result-document>
      <xsl:result-document href="aggregation.rdf">
         <rdf:RDF>
            <xsl:apply-templates select="metadata" mode="agg"/>
         </rdf:RDF>
      </xsl:result-document>
      <xsl:result-document href="rights.rdf">
         <rdf:RDF>
            <xsl:apply-templates select="metadata" mode="rights"/>
         </rdf:RDF>
      </xsl:result-document>
      <xsl:result-document href="agents.rdf">
         <rdf:RDF>
            <xsl:apply-templates select="metadata" mode="agent"/>
         </rdf:RDF>
      </xsl:result-document>
      <xsl:result-document href="collection.rdf">
         <rdf:RDF>
            <xsl:apply-templates select="metadata" mode="collection"/>
         </rdf:RDF>
      </xsl:result-document>
   </xsl:template>
   <!--template for agent file-->
   <xsl:template match="metadata" mode="agent">
      <xsl:for-each-group select="record"
                          group-by="Photographer[text() != '' and text() != 'Unidentified' and text() != 'unidentified']">
         <rdf:Description rdf:about="{concat($agentFile,translate(current-grouping-key(),''' #.,:;()/\- ', ''))}">
            <rdf:type rdf:resource="http://www.europeana.eu/schemas/edm/Agent"/>
         </rdf:Description>
         <rdf:Description rdf:about="{concat($agentFile,translate(current-grouping-key(),''' #.,:;()/\- ', ''))}">
            <dpla:providedLabel xml:lang="en">
               <xsl:value-of select="current-grouping-key()"/>
            </dpla:providedLabel>
         </rdf:Description>
      </xsl:for-each-group>
      <xsl:for-each-group select="record"
                          group-by="Repository[text() != '' and text() != 'Unidentified' and text() != 'unidentified']">
         <rdf:Description rdf:about="{concat($agentFile,translate(current-grouping-key(),''' #.,:;()/\- ', ''))}">
            <rdf:type rdf:resource="http://www.europeana.eu/schemas/edm/Agent"/>
         </rdf:Description>
         <rdf:Description rdf:about="{concat($agentFile,translate(current-grouping-key(),''' #.,:;()/\- ', ''))}">
            <dpla:providedLabel xml:lang="en">
               <xsl:value-of select="current-grouping-key()"/>
            </dpla:providedLabel>
         </rdf:Description>
      </xsl:for-each-group>
      <xsl:for-each-group select="record"
                          group-by="StudioName[text() != '' and text() != 'Unidentified' and text() != 'unidentified']">
         <rdf:Description rdf:about="{concat($agentFile,translate(current-grouping-key(),''' #.,:;()/\- ', ''))}">
            <rdf:type rdf:resource="http://www.europeana.eu/schemas/edm/Agent"/>
         </rdf:Description>
         <rdf:Description rdf:about="{concat($agentFile,translate(current-grouping-key(),''' #.,:;()/\- ', ''))}">
            <dpla:providedLabel xml:lang="en">
               <xsl:value-of select="current-grouping-key()"/>
            </dpla:providedLabel>
         </rdf:Description>
         <rdf:Description rdf:about="{concat($agentFile,translate(current-grouping-key(),''' #.,:;()/\- ', ''))}">
            <foaf:basedNear xml:lang="en">
               <xsl:value-of select="StudioLocation"/>
            </foaf:basedNear>
         </rdf:Description>
         <rdf:Description rdf:about="{concat($agentFile,translate(current-grouping-key(),''' #.,:;()/\- ', ''))}">
            <dct:description xml:lang="en">Studio</dct:description>
         </rdf:Description>
      </xsl:for-each-group>
   </xsl:template>
   <!--template for aggregation file -->
   <xsl:template match="metadata" mode="agg">
      <xsl:apply-templates select="record" mode="agg"/>
   </xsl:template>
   <!--template for collection file-->
   <xsl:template match="metadata" mode="collection">
      <xsl:for-each-group select="record" group-by="DigitalCollection">
         <rdf:Description rdf:about="{concat($collectionFile,translate(current-grouping-key(), ''' #.,:;()/\- ', ''))}">
            <rdf:type rdf:resource="http://purl.org/dc/dcmitype/Collection"/>
         </rdf:Description>
         <rdf:Description rdf:about="{concat($collectionFile,translate(current-grouping-key(), ''' #.,:;()/\- ', ''))}">
            <dct:title xml:lang="en">
               <xsl:value-of select="current-grouping-key()"/>
            </dct:title>
         </rdf:Description>
         <rdf:Description rdf:about="{concat($collectionFile,translate(current-grouping-key(), ''' #.,:;()/\- ', ''))}">
            <edm:isShownAt rdf:resource="$digitalCollectionUrl"/>
         </rdf:Description>
      </xsl:for-each-group>
      <xsl:for-each-group select="record" group-by="RepositoryCollection">
         <rdf:Description rdf:about="{concat($collectionFile,translate(current-grouping-key(), ''' #.,:;()/\- ', ''))}">
            <rdf:type rdf:resource="http://purl.org/dc/dcmitype/Collection"/>
         </rdf:Description>
         <rdf:Description rdf:about="{concat($collectionFile,translate(current-grouping-key(), ''' #.,:;()/\- ', ''))}">
            <dct:title xml:lang="en">
               <xsl:value-of select="current-grouping-key()"/>
            </dct:title>
         </rdf:Description>
      </xsl:for-each-group>
   </xsl:template>
   <!--template for rights file-->
   <xsl:template match="metadata" mode="rights">
      <xsl:for-each-group select="record" group-by="OrderingInformation">
         <rdf:Description rdf:about="{concat($rightsFile,'OrderingInformation')}">
            <rdf:type rdf:resource="http://purl.org/dc/terms/RightsStatement"/>
         </rdf:Description>
         <rdf:Description rdf:about="{concat($rightsFile,'OrderingInformation')}">
            <skos:note xml:lang="en">
               <xsl:value-of select="current-grouping-key()"/>
            </skos:note>
         </rdf:Description>
      </xsl:for-each-group>
      <xsl:for-each-group select="record" group-by="Restrictions">
         <rdf:Description rdf:about="{concat($rightsFile,'Restrictions')}">
            <rdf:type rdf:resource="http://purl.org/dc/terms/RightsStatement"/>
         </rdf:Description>
         <rdf:Description rdf:about="{concat($rightsFile,'Restrictions')}">
            <skos:prefLabel xml:lang="en">
               <xsl:value-of select="current-grouping-key()"/>
            </skos:prefLabel>
         </rdf:Description>
      </xsl:for-each-group>
   </xsl:template>
   <!--template for source resource file-->
   <xsl:template match="metadata" mode="sr">
      <xsl:apply-templates select="record" mode="sr"/>
   </xsl:template>
   <!--template for web resource file-->
   <xsl:template match="metadata" mode="wr">
      <xsl:apply-templates select="record" mode="wr"/>
   </xsl:template>
   <!--sub-template for aggregation file-->
   <xsl:template match="record" mode="agg">
      <rdf:Description rdf:about="{$aggregationFile}cdm{cdmnumber}">
         <rdf:type rdf:resource="http://www.openarchives.org/ore/terms/Aggregation"/>
      </rdf:Description>
      <xsl:apply-templates select="OrderingInformation" mode="agg"/>
      <xsl:apply-templates select="Repository" mode="agg"/>
      <xsl:apply-templates select="Restrictions" mode="agg"/>
      <xsl:apply-templates select="ItemURL" mode="agg"/>
   </xsl:template>
   <!--templates for CONTENTdm elements used by the Aggregation-->
   <xsl:template match="OrderingInformation" mode="agg">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$aggregationFile}cdm{../cdmnumber}">
            <edm:rights rdf:resource="{$rightsFile}orderingInformation"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="Repository" mode="agg">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$aggregationFile}cdm{../cdmnumber}">
            <edm:provider rdf:resource="{ concat($agentFile, translate( ., ''' #.,:;()/\- ', '' )) }"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="Restrictions" mode="agg">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$aggregationFile}cdm{../cdmnumber}">
            <edm:rights rdf:resource="{$rightsFile}restrictions"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="ItemURL" mode="agg">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$aggregationFile}cdm{../cdmnumber}">
            <edm:isShownAt rdf:resource="{.}"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <!--sub-template for source resource file-->
   <xsl:template match="record" mode="sr">
      <rdf:Description rdf:about="{$sourceResourceFile}cdm{cdmnumber}">
         <rdf:type rdf:resource="http://dp.la/about/map/SourceResource"/>
      </rdf:Description>
      <xsl:apply-templates select="Title" mode="sr"/>
      <xsl:apply-templates select="Photographer" mode="sr"/>
      <xsl:apply-templates select="DateEdtf">
         <xsl:with-param name="DateEdtfID" select="concat('DateEdtf',generate-id())"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="Notes" mode="sr"/>
      <xsl:apply-templates select="SubjectsLCTGM" mode="sr"/>
      <xsl:apply-templates select="SubjectsLCSH" mode="sr"/>
      <xsl:apply-templates select="LocationDepicted">
         <xsl:with-param name="LocationDepictedID"
                         select="concat('LocationDepicted',generate-id())"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="NegativeNumber">
         <xsl:with-param name="NegativeNumberID" select="concat('NegativeNumber',generate-id())"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="Repository" mode="sr"/>
      <xsl:apply-templates select="RepositoryCollection" mode="sr"/>
      <xsl:apply-templates select="ObjectType" mode="sr"/>
      <xsl:apply-templates select="PhysicalDescription" mode="sr"/>
      <xsl:apply-templates select="StudioName" mode="sr"/>
      <xsl:apply-templates select="PhotographersReferenceNumber">
         <xsl:with-param name="PhotographersReferenceNumberID"
                         select="concat('PhotographersReferenceNumber',generate-id())"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="Type" mode="sr"/>
   </xsl:template>
   <!--templates for CONTENTdm elements used by the SourceResource-->
   <xsl:template match="Title" mode="sr">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
            <dct:title xml:lang="en">
               <xsl:value-of select="."/>
            </dct:title>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="Photographer" mode="sr">
      <xsl:if test="text() and . != 'Unidentified' and . != 'unidentified '">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
            <rel:pht rdf:resource="{ concat($agentFile, translate( ., ''' #.,:;()/\- ', '' )) }"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="DateEdtf">
      <xsl:param name="DateEdtfID"/>
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}')">
            <dct:date rdf:nodeID="{$DateEdtfID}"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$DateEdtfID}">
            <rdf:type rdf:resource="http://www.europeana.eu/schemas/edm/TimeSpan"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$DateEdtfID}">
            <skos:prefLabel>
               <xsl:value-of select="."/>
            </skos:prefLabel>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$DateEdtfID}">
            <skos:providedLabel>
               <xsl:value-of select="following-sibling::date"/>
            </skos:providedLabel>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="Notes" mode="sr">
      <xsl:if test="text()">
         <xsl:choose>
            <xsl:when test="contains(., '&lt;br&gt;&lt;br&gt;')">
               <xsl:call-template name="Notes">
                  <xsl:with-param name="CdmNumber" select="../cdmnumber"/>
                  <xsl:with-param name="Tokens" select="tokenize(.,'&lt;br&gt;&lt;br&gt;')"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dct:description xml:lang="en">
                     <xsl:value-of select="."/>
                  </dct:description>
               </rdf:Description>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>
   <xsl:template name="Notes">
      <xsl:param name="CdmNumber"/>
      <xsl:param name="Tokens"/>
      <xsl:for-each select="$Tokens">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{$CdmNumber}">
            <dct:description xml:lang="en">
               <xsl:value-of select="."/>
            </dct:description>
         </rdf:Description>
      </xsl:for-each>
   </xsl:template>
   <xsl:template match="SubjectsLCTGM" mode="sr">
      <xsl:if test="text()">
         <xsl:choose>
            <xsl:when test="contains(., ';')">
               <xsl:call-template name="SubjectsLCTGM">
                  <xsl:with-param name="Tokens" select="tokenize(., ';\s*')"/>
                  <xsl:with-param name="CdmNumber" select="../cdmnumber"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="SubjectsLCTGMID" select="concat('SubjectsLCTGM',generate-id())"/>
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dct:subject rdf:nodeID="{$SubjectsLCTGMID}"/>
               </rdf:Description>
               <rdf:Description rdf:nodeID="{$SubjectsLCTGMID}">
                  <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/>
               </rdf:Description>
               <rdf:Description rdf:nodeID="{$SubjectsLCTGMID}">
                  <skos:inScheme rdf:resource="http://id.loc.gov/vocabulary/graphicMaterials"/>
               </rdf:Description>
               <rdf:Description rdf:nodeID="{$SubjectsLCTGMID}">
                  <dpla:providedLabel xml:lang="en">
                     <xsl:value-of select="."/>
                  </dpla:providedLabel>
               </rdf:Description>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>
   <xsl:template name="SubjectsLCTGM">
      <xsl:param name="Tokens"/>
      <xsl:param name="CdmNumber"/>
      <xsl:variable name="SubjectsLCTGMID" select="concat(SubjectsLCTGM,generate-id())"/>
      <xsl:for-each select="$Tokens">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{$CdmNumber}">
            <dct:subject rdf:nodeID="{concat($SubjectsLCTGMID,position())}"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{concat($SubjectsLCTGMID,position())}">
            <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{concat($SubjectsLCTGMID,position())}">
            <skos:inScheme rdf:resource="http://id.loc.gov/vocabulary/graphicMaterials"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{concat($SubjectsLCTGMID,position())}">
            <dpla:providedLabel xml:lang="en">
               <xsl:value-of select="."/>
            </dpla:providedLabel>
         </rdf:Description>
      </xsl:for-each>
   </xsl:template>
   <xsl:template match="SubjectsLCSH" mode="sr">
      <xsl:if test="text()">
         <xsl:choose>
            <xsl:when test="contains(., ';')">
               <xsl:call-template name="SubjectsLCSH">
                  <xsl:with-param name="Tokens" select="tokenize(., ';\s*')"/>
                  <xsl:with-param name="CdmNumber" select="../cdmnumber"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:variable name="SubjectsLCSHID" select="concat('SubjectsLCSH',generate-id())"/>
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dct:subject rdf:nodeID="{$SubjectsLCSHID}"/>
               </rdf:Description>
               <rdf:Description rdf:nodeID="{$SubjectsLCSHID}">
                  <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/>
               </rdf:Description>
               <rdf:Description rdf:nodeID="{$SubjectsLCSHID}">
                  <skos:inScheme rdf:resource="http://id.loc.gov/authorities/subjects"/>
               </rdf:Description>
               <rdf:Description rdf:nodeID="{$SubjectsLCSHID}">
                  <dpla:providedLabel xml:lang="en">
                     <xsl:value-of select="."/>
                  </dpla:providedLabel>
               </rdf:Description>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>
   <xsl:template name="SubjectsLCSH">
      <xsl:param name="Tokens"/>
      <xsl:param name="CdmNumber"/>
      <xsl:variable name="SubjectsLCSHID" select="concat(SubjectsLCSH,generate-id())"/>
      <xsl:for-each select="$Tokens">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{$CdmNumber}">
            <dct:subject rdf:nodeID="{concat($SubjectsLCSHID,position())}"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{concat($SubjectsLCSHID,position())}">
            <rdf:type rdf:resource="http://www.w3.org/2004/02/skos/core#Concept"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{concat($SubjectsLCSHID,position())}">
            <skos:inScheme rdf:resource="http://id.loc.gov/authorities/subjects"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{concat($SubjectsLCSHID,position())}">
            <dpla:providedLabel xml:lang="en">
               <xsl:value-of select="."/>
            </dpla:providedLabel>
         </rdf:Description>
      </xsl:for-each>
   </xsl:template>
   <xsl:template match="LocationDepicted">
      <xsl:param name="LocationDepictedID"/>
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}')">
            <dct:spatial rdf:nodeID="{$LocationDepictedID}"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$LocationDepictedID}">
            <rdf:type rdf:resource="http://www.europeana.eu/schemas/edm/Place"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$LocationDepictedID}">
            <dpla:providedLabel xml:lang="en">
               <xsl:value-of select="."/>
            </dpla:providedLabel>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="NegativeNumber">
      <xsl:param name="NegativeNumberID"/>
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}')">
            <bf:identifiedBy rdf:nodeID="{$NegativeNumberID}"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$NegativeNumberID}">
            <rdf:type rdf:resource="http://id.loc.gov/ontologies/bibframe/Identifier"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$NegativeNumberID}">
            <skos:prefLabel>
               <xsl:value-of select="."/>
            </skos:prefLabel>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="Repository" mode="sr">
      <xsl:if test="text() and . != 'Unidentified' and . != 'unidentified '">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
            <dct:rightsHolder rdf:resource="{ concat($agentFile, translate( ., ''' #.,:;()/\- ', '' )) }"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="RepositoryCollection" mode="sr">
      <xsl:if test="text() and . != 'Unidentified' and . != 'unidentified '">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
            <dct:isPartOf rdf:resource="{ concat($collectionFile, translate( ., ''' #.,:;()/\- ', '' )) }"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="ObjectType" mode="sr">
      <xsl:if test="text()">
         <xsl:choose>
            <xsl:when test=". = 'image'">
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dct:type rdf:resource="http://vocab.getty.edu/aat/300264387"/>
               </rdf:Description>
            </xsl:when>
            <xsl:when test=". = 'photograph' or . = 'Photograph'">
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dct:type rdf:resource="http://vocab.getty.edu/aat/300046300"/>
               </rdf:Description>
            </xsl:when>
            <xsl:when test=". = 'Postcard'">
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dct:type rdf:resource="http://vocab.getty.edu/aat/300026816"/>
               </rdf:Description>
            </xsl:when>
            <xsl:when test=". = 'Map'">
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dct:type rdf:resource="http://vocab.getty.edu/aat/300028094"/>
               </rdf:Description>
            </xsl:when>
            <xsl:when test=". = 'Negative'">
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dct:type rdf:resource="http://vocab.getty.edu/aat/300127173"/>
               </rdf:Description>
            </xsl:when>
            <xsl:otherwise>
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dc:type xml:lang="en">
                     <xsl:value-of select="."/>
                  </dc:type>
               </rdf:Description>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>
   <xsl:template match="PhysicalDescription" mode="sr">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
            <dct:extent xml:lang="en">
               <xsl:value-of select="."/>
            </dct:extent>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="StudioName" mode="sr">
      <xsl:if test="text() and . != 'Unidentified' and . != 'unidentified '">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
            <dct:contributor rdf:resource="{ concat($agentFile, translate( ., ''' #.,:;()/\- ', '' )) }"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="PhotographersReferenceNumber">
      <xsl:param name="PhotographersReferenceNumberID"/>
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}')">
            <bf:identifiedBy rdf:nodeID="{$PhotographersReferenceNumberID}"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$PhotographersReferenceNumberID}">
            <rdf:type rdf:resource="http://id.loc.gov/ontologies/bibframe/Identifier"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$PhotographersReferenceNumberID}">
            <skos:prefLabel>
               <xsl:value-of select="."/>
            </skos:prefLabel>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="Type" mode="sr">
      <xsl:if test="text()">
         <xsl:choose>
            <xsl:when test=". = 'StillImage' or . = 'Stillimage' or . = 'stillimage' or . = 'still image' or . = 'Still Image'">
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dct:type rdf:resource="http://purl.org/dc/dcmitype/StillImage"/>
               </rdf:Description>
            </xsl:when>
            <xsl:when test=". = 'Text' or . = 'text'">
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dct:type rdf:resource="http://purl.org/dc/dcmitype/Text"/>
               </rdf:Description>
            </xsl:when>
            <xsl:otherwise>
               <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
                  <dc:type xml:lang="en">
                     <xsl:value-of select="."/>
                  </dc:type>
               </rdf:Description>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>
   <!--sub-template for web resource file-->
   <xsl:template match="record" mode="wr">
      <rdf:Description rdf:about="{$webResourceFile}cdm{cdmnumber}">
         <rdf:type rdf:resource="http://www.europeana.eu/schemas/edm/WebResource"/>
      </rdf:Description>
      <xsl:apply-templates select="Title" mode="wr"/>
      <xsl:apply-templates select="DigitalCollection" mode="wr"/>
      <xsl:apply-templates select="OrderNumber" mode="wr">
         <xsl:with-param name="OrderNumberID" select="concat('OrderNumber',generate-id())"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="OrderingInformation" mode="wr"/>
      <xsl:apply-templates select="DigitalReproductionInformation" mode="wr"/>
      <xsl:apply-templates select="Restrictions" mode="wr"/>
      <xsl:apply-templates select="RightsUri" mode="wr"/>
   </xsl:template>
   <!--templates for CONTENTdm elements used by the WebResource-->
   <xsl:template match="Title" mode="wr">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
            <dct:title xml:lang="en">
               <xsl:value-of select="."/>
            </dct:title>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="DigitalCollection" mode="wr">
      <xsl:if test="text() and . != 'Unidentified' and . != 'unidentified '">
         <rdf:Description rdf:about="{$webResourceFile}cdm{../cdmnumber}">
            <dct:isPartOf rdf:resource="{ concat($collectionFile, translate( ., ''' #.,:;()/\- ', '' )) }"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="OrderNumber" mode="wr">
      <xsl:param name="OrderNumberID"/>
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$webResourceFile}cdm{../cdmnumber}')">
            <bf:identifiedBy rdf:nodeID="{$OrderNumberID}"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$OrderNumberID}">
            <rdf:type rdf:resource="http://BIBFRAMEIDENTIFIER.FETCH"/>
         </rdf:Description>
         <rdf:Description rdf:nodeID="{$OrderNumberID}">
            <skos:prefLabel>
               <xsl:value-of select="."/>
            </skos:prefLabel>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="OrderingInformation" mode="wr">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$aggregationFile}cdm{../cdmnumber}">
            <edm:rights rdf:resource="{$rightsFile}orderingInformation"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="DigitalReproductionInformation" mode="wr">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$sourceResourceFile}cdm{../cdmnumber}">
            <dct:description xml:lang="en">
               <xsl:value-of select="."/>
            </dct:description>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="Restrictions" mode="wr">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$aggregationFile}cdm{../cdmnumber}">
            <edm:rights rdf:resource="{$rightsFile}restrictions"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
   <xsl:template match="RightsUri" mode="wr">
      <xsl:if test="text()">
         <rdf:Description rdf:about="{$aggregationFile}cdm{../cdmnumber}">
            <edm:rights rdf:resource="{$rightsFile}rightsUri"/>
         </rdf:Description>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet>
