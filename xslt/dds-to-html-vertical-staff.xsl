<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mig="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries"
    xmlns:mig2="http://faculty.washington.edu/tgis/schemasProject/xsd4md"
    exclude-result-prefixes="xs" version="2.0">
    <!-- version 0.2 2017-07-26 -->
    <xsl:output method="html" indent="yes" use-character-maps="angleBrackets"/>

    <xsl:character-map name="angleBrackets">
        <xsl:output-character character="&lt;" string="&lt;"/>
        <xsl:output-character character="&gt;" string="&gt;"/>
    </xsl:character-map>

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="mig:migDataDictionary/mig:ddName"/>
                </title>
                <style>
                    table{
                        border-collapse: collapse;
                        width: 100%;
                    }
                    table,
                    th,
                    td{
                        font-family: "Times New Roman", "Georgia", "Times";
                        font-size: 11px;
                        border: 1px solid black;
                        border-color: #999999;
                    }
                    th,
                    td{
                        padding: 10px;
                    }
                    tr:hover{
                        background-color: #f5f5f5;
                    }
                    td{
                        vertical-align: top;
                    }</style>
                <!-- <link rel="stylesheet" href="/Users/theodore/Documents/uwl/schemasProject/xslt/css4htmlDds.css" type="text/css"/> -->
            </head>
            <body>
                <xsl:apply-templates select="mig:migDataDictionary"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="mig:migDataDictionary">
        <h1>
            <xsl:value-of select="mig:ddName"/>
        </h1>
        <h3>Most recent revision: <xsl:value-of select="mig:latestUpdate"/></h3>
        <h3>Metadata Liaison: <xsl:apply-templates select="mig:metadataLiaisons"/></h3>
        <xsl:choose>
            <xsl:when test="mig:standalone = 'yes' and mig:cdmCo = 'no'">
                <xsl:apply-templates select="mig:properties" mode="standalone"/>
            </xsl:when>
            <xsl:when test="mig:standalone = 'no' and mig:cdmCo = 'yes'">
                <xsl:apply-templates select="mig:properties" mode="co"/>
            </xsl:when>
            <xsl:when test="mig:standalone = 'yes' and mig:cdmCo = 'yes'">
                <xsl:apply-templates select="mig:properties" mode="combined"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>UNDEFINED SCHEMA FORMATIONS; MUST IDENTIFY IF THERE ARE COMPOUND OBJECTS ONLY, STANDALONE OBJECTS ONLY, OR BOTH.</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="mig:metadataLiaisons">
        <xsl:for-each select="mig:metadataLiaison">
            <xsl:choose>
                <xsl:when test="position() = last()">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                    <xsl:text>, </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="mig:properties" mode="standalone">
        <xsl:for-each
            select="mig2:property[not(mig2:cdm/mig2:cdmDatatype = 'cdmAdministrative')][not(mig2:cdm/mig2:cdmDatatype = 'uwAdministrative')][mig2:descriptions//mig2:instructions/@co = 'no']">
            <h3 style="text-align:center">
                <xsl:value-of select="position()"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="mig2:cdm/mig2:label"/>
            </h3>
            <table border="1">
                <tr>
                    <td>Label</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:label"/>
                    </td>
                </tr>
                <tr>
                    <td>URI</td>
                    <td>[baseURI-toBeDetermined]/<xsl:value-of select="./mig2:labels/mig2:platformIndependent"/></td>
                </tr>
                <tr>
                    <td>Dublin Core Equivalent</td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="mig2:labels/mig2:dc='none'">
                                <xsl:text>[no Dublin Core equivalent]</xsl:text>
                            </xsl:when>
                            <xsl:when test="mig2:labels/mig2:platformIndependent='restrictions'">
                                <xsl:text>http://purl.org/dc/elements/1.1/rights</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>http://purl.org/dc/terms/</xsl:text><xsl:value-of select="mig2:labels/mig2:dc"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm searchable?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:searchable"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm hidden?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:hidden"/>
                    </td>
                </tr>
                
                <tr>
                    <td>Required by CONTENTdm?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmRequired"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm controlled Vocabulary?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                    </td>
                </tr>
                <tr>
                    <td>Required by UW Libraries?</td>
                    <td>
                        <xsl:value-of select="mig2:uwRequired/mig2:uwObject"/>
                    </td>
                </tr>
                <tr>
                    <td>Definition</td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                </tr>
                <tr>
                    <td>Input instructions</td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:descriptions/mig2:customization/@dd">
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:customization[@co = 'no']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:instructions[@co = 'no']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <tr>
                    <td>Input examples</td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:examples/mig2:customization/@dd">
                                
                                <xsl:for-each
                                    select="mig2:examples/mig2:customization[@co = 'no']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:examples/mig2:example[@co = 'no' or @co = 'all']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <xsl:if test="mig2:additionalInfo/mig2:admin/mig2:para/text() or mig2:additionalInfo/mig2:generalNotes/mig2:para/text()">    
                    <tr>
                        <td>Additional notes</td>
                        <td>
                            <!-- make sure all CO status include both note types ~and~ co=all below. -->
                            <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                                <p>
                                    <xsl:value-of select="."/>
                                </p>
                            </xsl:for-each>
                            <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                                <p>
                                    <xsl:value-of select="."/>
                                </p>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
            </table>
        </xsl:for-each>
    </xsl:template>
    

<!-- COMPOUND OBJCTS DONE FOR DCMI-STYLE -->
    <xsl:template match="mig:properties" mode="co">
        <h1 style="text-align:center">*****OBJECT DESCRIPTION*****</h1>
        <xsl:for-each
            select="mig2:property[not(mig2:cdm/mig2:cdmDatatype = 'cdmAdministrative')][not(mig2:cdm/mig2:cdmDatatype = 'uwAdministrative')][mig2:descriptions//mig2:instructions/@co = 'object'][not(mig2:labels/mig2:platformIndependent = //mig:suppressObjectProp)]">
            <h3 style="text-align:center">
                <xsl:value-of select="position()"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="mig2:cdm/mig2:label"/>
            </h3>
            <table border="1">
                <tr>
                    <td>Label</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:label"/>
                    </td>
                </tr>
                <tr>
                    <td>URI</td>
                    <td>[baseURI-toBeDetermined]/<xsl:value-of select="./mig2:labels/mig2:platformIndependent"/></td>
                </tr>
                <tr>
                    <td>Dublin Core Equivalent</td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="mig2:labels/mig2:dc='none'">
                                <xsl:text>[no Dublin Core equivalent]</xsl:text>
                            </xsl:when>
                            <xsl:when test="mig2:labels/mig2:platformIndependent='restrictions'">
                                <xsl:text>http://purl.org/dc/elements/1.1/rights</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>http://purl.org/dc/terms/</xsl:text><xsl:value-of select="mig2:labels/mig2:dc"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm searchable?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:searchable"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm hidden?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:hidden"/>
                    </td>
                </tr>

                <tr>
                    <td>Required by CONTENTdm?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmRequired"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm controlled Vocabulary?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                    </td>
                </tr>
                <tr>
                    <td>Required by UW Libraries?</td>
                    <td>
                        <xsl:value-of select="mig2:uwRequired/mig2:uwObject"/>
                    </td>
                </tr>
                <tr>
                    <td>Definition</td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                </tr>
                <tr>
                    <td>Input instructions</td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:descriptions/mig2:customization/@dd">
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:customization[@co = 'object']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:instructions[@co = 'object']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <tr>
                    <td>Input examples</td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:examples/mig2:customization/@dd">

                                <xsl:for-each
                                    select="mig2:examples/mig2:customization[@co = 'object']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:examples/mig2:example[@co = 'object' or @co = 'all']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <xsl:if test="mig2:additionalInfo/mig2:admin/mig2:para/text() or mig2:additionalInfo/mig2:generalNotes/mig2:para/text()">    
                <tr>
                    <td>Additional notes</td>
                    <td>
                        <!-- make sure all CO status include both note types ~and~ co=all below. -->
                        <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                        <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                </tr>
                </xsl:if>
            </table>
        </xsl:for-each>
        <h1 style="text-align:center">*****ITEM DESCRIPTION*****</h1>
        <xsl:for-each
            select="mig2:property[not(mig2:cdm/mig2:cdmDatatype = 'cdmAdministrative')][not(mig2:cdm/mig2:cdmDatatype = 'uwAdministrative')][mig2:descriptions//mig2:instructions/@co = 'item']">
            <!-- [not(mig2:labels/mig2:platformIndependent = ] -->
            <h3 style="text-align:center">
                <xsl:value-of select="position()"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="mig2:cdm/mig2:label"/>
            </h3>
            <table border="1">
                <tr>
                    <td>Label</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:label"/><!-- delete at right --><xsl:value-of select="../../mig:suppressItemProp"/>
                    </td>
                </tr>
                <tr>
                    <td>URI</td>
                    <td>[baseURI-toBeDetermined]/<xsl:value-of select="./mig2:labels/mig2:platformIndependent"/></td>
                </tr>
                <tr>
                    <td>Dublin Core Equivalent</td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="mig2:labels/mig2:dc='none'">
                                <xsl:text>[no Dublin Core equivalent]</xsl:text>
                            </xsl:when>
                            <xsl:when test="mig2:labels/mig2:platformIndependent='restrictions'">
                                <xsl:text>http://purl.org/dc/elements/1.1/rights</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>http://purl.org/dc/terms/</xsl:text><xsl:value-of select="mig2:labels/mig2:dc"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm searchable?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:searchable"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm hidden?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:hidden"/>
                    </td>
                </tr>
                
                <tr>
                    <td>Required by CONTENTdm?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmRequired"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm controlled Vocabulary?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                    </td>
                </tr>
                <tr>
                    <td>Required by UW Libraries?</td>
                    <td>
                        <xsl:value-of select="mig2:uwRequired/mig2:uwObject"/>
                    </td>
                </tr>
                <tr>
                    <td>Definition</td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                </tr>
                <tr>
                    <td>Input instructions</td>
                    <td>
                        <xsl:choose>
                            <!-- Note the awkward repair in the when statement below; fix it! -->
                            <xsl:when
                                test="../../mig:cdmCode = mig2:descriptions/mig2:customization/@dd">
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:customization[@co = 'item'][@dd=../../../../mig:cdmCode]/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:instructions[@co = 'item']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <tr>
                    <td>Input examples</td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:examples/mig2:customization/@dd">
                                
                                <xsl:for-each
                                    select="mig2:examples/mig2:customization[@co = 'item']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:examples/mig2:example[@co = 'item' or @co = 'all']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <xsl:if test="mig2:additionalInfo/mig2:admin/mig2:para/text() or mig2:additionalInfo/mig2:generalNotes/mig2:para/text()">    
                    <tr>
                        <td>Additional notes</td>
                        <td>
                            <!-- make sure all CO status include both note types ~and~ co=all below.
                                 also: below does not account for item/standalone/object specified in @co. Fix!
                            -->
                            <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                                <p>
                                    <xsl:value-of select="."/>
                                </p>
                            </xsl:for-each>
                            <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                                <p>
                                    <xsl:value-of select="."/>
                                </p>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
            </table>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="mig:properties" mode="combined">
        <h2 style="text-align:center">OBJECT DESCRIPTION</h2>
        <xsl:for-each
            select="mig2:property[not(mig2:cdm/mig2:cdmDatatype = 'cdmAdministrative')][not(mig2:cdm/mig2:cdmDatatype = 'uwAdministrative')][mig2:descriptions//mig2:instructions/@co = 'object'][not(mig2:labels/mig2:platformIndependent = //mig:suppressObjectProp)]">
            <h3 style="text-align:center">
                <xsl:value-of select="position()"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="mig2:cdm/mig2:label"/>
            </h3>
            <table border="1">
                <tr>
                    <td>Label</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:label"/>
                    </td>
                </tr>
                <tr>
                    <td>URI</td>
                    <td>[baseURI-toBeDetermined]/<xsl:value-of select="./mig2:labels/mig2:platformIndependent"/></td>
                </tr>
                <tr>
                    <td>Dublin Core Equivalent</td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="mig2:labels/mig2:dc='none'">
                                <xsl:text>[no Dublin Core equivalent]</xsl:text>
                            </xsl:when>
                            <xsl:when test="mig2:labels/mig2:platformIndependent='restrictions'">
                                <xsl:text>http://purl.org/dc/elements/1.1/rights</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>http://purl.org/dc/terms/</xsl:text><xsl:value-of select="mig2:labels/mig2:dc"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm searchable?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:searchable"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm hidden?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:hidden"/>
                    </td>
                </tr>
                
                <tr>
                    <td>Required by CONTENTdm?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmRequired"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm controlled Vocabulary?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                    </td>
                </tr>
                <tr>
                    <td>Required by UW Libraries?</td>
                    <td>
                        <xsl:value-of select="mig2:uwRequired/mig2:uwObject"/>
                    </td>
                </tr>
                <tr>
                    <td>Definition</td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                </tr>
                <tr>
                    <td>Input instructions</td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:descriptions/mig2:customization/@dd">
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:customization[@co = 'object']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:instructions[@co = 'object']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <tr>
                    <td>Input examples</td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:examples/mig2:customization/@dd">
                                
                                <xsl:for-each
                                    select="mig2:examples/mig2:customization[@co = 'object']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:examples/mig2:example[@co = 'object' or @co = 'all']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <xsl:if test="mig2:additionalInfo/mig2:admin/mig2:para/text() or mig2:additionalInfo/mig2:generalNotes/mig2:para/text()">    
                    <tr>
                        <td>Additional notes</td>
                        <td>
                            <!-- make sure all CO status include both note types ~and~ co=all below. -->
                            <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                                <p>
                                    <xsl:value-of select="."/>
                                </p>
                            </xsl:for-each>
                            <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                                <p>
                                    <xsl:value-of select="."/>
                                </p>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
            </table>
        </xsl:for-each>
        <h2 style="text-align:center">ITEM DESCRIPTION</h2>
        <xsl:for-each
            select="mig2:property[not(mig2:cdm/mig2:cdmDatatype = 'cdmAdministrative')][not(mig2:cdm/mig2:cdmDatatype = 'uwAdministrative')][mig2:descriptions//mig2:instructions/@co = 'item']">
            <!-- [not(mig2:labels/mig2:platformIndependent = ] -->
            <h3 style="text-align:center">
                <xsl:value-of select="position()"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="mig2:cdm/mig2:label"/>
            </h3>
            <table border="1">
                <tr>
                    <td>Label</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:label"/><!-- delete at right --><xsl:value-of select="../../mig:suppressItemProp"/>
                    </td>
                </tr>
                <tr>
                    <td>URI</td>
                    <td>[baseURI-toBeDetermined]/<xsl:value-of select="./mig2:labels/mig2:platformIndependent"/></td>
                </tr>
                <tr>
                    <td>Dublin Core Equivalent</td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="mig2:labels/mig2:dc='none'">
                                <xsl:text>[no Dublin Core equivalent]</xsl:text>
                            </xsl:when>
                            <xsl:when test="mig2:labels/mig2:platformIndependent='restrictions'">
                                <xsl:text>http://purl.org/dc/elements/1.1/rights</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>http://purl.org/dc/terms/</xsl:text><xsl:value-of select="mig2:labels/mig2:dc"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm searchable?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:searchable"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm hidden?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:hidden"/>
                    </td>
                </tr>
                
                <tr>
                    <td>Required by CONTENTdm?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmRequired"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm controlled Vocabulary?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                    </td>
                </tr>
                <tr>
                    <td>Required by UW Libraries?</td>
                    <td>
                        <xsl:value-of select="mig2:uwRequired/mig2:uwObject"/>
                    </td>
                </tr>
                <tr>
                    <td>Definition</td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                </tr>
                <tr>
                    <td>Input instructions</td>
                    <td>
                        <xsl:choose>
                            <!-- Note the awkward repair in the when statement below; fix it! -->
                            <xsl:when
                                test="../../mig:cdmCode = mig2:descriptions/mig2:customization/@dd">
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:customization[@co = 'item'][@dd=../../../../mig:cdmCode]/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:instructions[@co = 'item']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <tr>
                    <td>Input examples</td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:examples/mig2:customization/@dd">
                                
                                <xsl:for-each
                                    select="mig2:examples/mig2:customization[@co = 'item']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:examples/mig2:example[@co = 'item' or @co = 'all']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <xsl:if test="mig2:additionalInfo/mig2:admin/mig2:para/text() or mig2:additionalInfo/mig2:generalNotes/mig2:para/text()">    
                    <tr>
                        <td>Additional notes</td>
                        <td>
                            <!-- make sure all CO status include both note types ~and~ co=all below.
                                 also: below does not account for item/standalone/object specified in @co. Fix!
                            -->
                            <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                                <p>
                                    <xsl:value-of select="."/>
                                </p>
                            </xsl:for-each>
                            <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                                <p>
                                    <xsl:value-of select="."/>
                                </p>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
            </table>
        </xsl:for-each>
        <h2 style="text-align:center">STANDALONE DESCRIPTION</h2>
        <xsl:for-each
            select="mig2:property[not(mig2:cdm/mig2:cdmDatatype = 'cdmAdministrative')][not(mig2:cdm/mig2:cdmDatatype = 'uwAdministrative')][mig2:descriptions//mig2:instructions/@co = 'no']">
            <h3 style="text-align:center">
                <xsl:value-of select="position()"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="mig2:cdm/mig2:label"/>
            </h3>
            <table border="1">
                <tr>
                    <td>Label</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:label"/>
                    </td>
                </tr>
                <tr>
                    <td>URI</td>
                    <td>[baseURI-toBeDetermined]/<xsl:value-of select="./mig2:labels/mig2:platformIndependent"/></td>
                </tr>
                <tr>
                    <td>Dublin Core Equivalent</td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="mig2:labels/mig2:dc='none'">
                                <xsl:text>[no Dublin Core equivalent]</xsl:text>
                            </xsl:when>
                            <xsl:when test="mig2:labels/mig2:platformIndependent='restrictions'">
                                <xsl:text>http://purl.org/dc/elements/1.1/rights</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>http://purl.org/dc/terms/</xsl:text><xsl:value-of select="mig2:labels/mig2:dc"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm searchable?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:searchable"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm hidden?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:hidden"/>
                    </td>
                </tr>
                
                <tr>
                    <td>Required by CONTENTdm?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmRequired"/>
                    </td>
                </tr>
                <tr>
                    <td>CONTENTdm controlled Vocabulary?</td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                    </td>
                </tr>
                <tr>
                    <td>Required by UW Libraries?</td>
                    <td>
                        <xsl:value-of select="mig2:uwRequired/mig2:uwObject"/>
                    </td>
                </tr>
                <tr>
                    <td>Definition</td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                </tr>
                <tr>
                    <td>Input instructions</td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:descriptions/mig2:customization/@dd">
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:customization[@co = 'no']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:instructions[@co = 'no']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <tr>
                    <td>Input examples</td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:examples/mig2:customization/@dd">
                                
                                <xsl:for-each
                                    select="mig2:examples/mig2:customization[@co = 'no']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:examples/mig2:example[@co = 'no' or @co = 'all']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <xsl:if test="mig2:additionalInfo/mig2:admin/mig2:para/text() or mig2:additionalInfo/mig2:generalNotes/mig2:para/text()">    
                    <tr>
                        <td>Additional notes</td>
                        <td>
                            <!-- make sure all CO status include both note types ~and~ co=all below. -->
                            <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                                <p>
                                    <xsl:value-of select="."/>
                                </p>
                            </xsl:for-each>
                            <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                                <p>
                                    <xsl:value-of select="."/>
                                </p>
                            </xsl:for-each>
                        </td>
                    </tr>
                </xsl:if>
            </table>
        </xsl:for-each>
    </xsl:template>
        
        

<!-- COMBINED NOT DONE FOR DCMI STYLE -->
    <!--
    <xsl:template match="mig:properties" mode="combined">
        <h2 style="text-align:center">OBJECT DESCRIPTION</h2>
        <table border="1">
            <tr>
                <th>#</th>
                <th>CONTENTdm Collection Property</th>
                <th>DC Equivalent</th>
                <th>Cdm Data Type</th>
                <th>Cdm Large</th>
                <th>Searchable</th>
                <th>Hidden</th>
                <th>Required, CONTENTdm</th>
                <th>Cdm Controlled Vocabulary</th>
                <th>Required for all UW collections</th>
                <th>Definition</th>
                <th>Input Instructions</th>
                <th>Examples</th>
                <th>Additional notes on this property</th>
            </tr>
            <xsl:for-each
                select="mig2:property[not(mig2:cdm/mig2:cdmDatatype = 'cdmAdministrative')][not(mig2:cdm/mig2:cdmDatatype = 'uwAdministrative')][mig2:descriptions/mig2:instructions/@co = 'object' or mig2:descriptions/mig2:customization/@co = 'object']">
                <tr>
                    <td>
                        <xsl:value-of select="position()"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:label"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:labels/mig2:dc"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmDatatype"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmLarge"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:searchable"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:hidden"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmRequired"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:uwRequired/mig2:uwObject"/>
                    </td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each
                            select="mig2:descriptions/mig2:instructions[@co = 'object']/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each
                            select="mig2:examples/mig2:example[@co = 'object' or @co = 'all']/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                        <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                </tr>
            </xsl:for-each>
        </table>

        <h2 style="text-align:center">ITEM DESCRIPTION</h2>
        <table border="1">
            <tr>
                <th>#</th>
                <th>CONTENTdm Collection Property</th>
                <th>DC Equivalent</th>
                <th>Cdm Data Type</th>
                <th>Cdm Large</th>
                <th>Searchable</th>
                <th>Hidden</th>
                <th>Required, CONTENTdm</th>
                <th>Cdm Controlled Vocabulary</th>
                <th>Required for all UW collections</th>
                <th>Definition</th>
                <th>Input Instructions</th>
                <th>Examples</th>
                <th>Additional notes on this property</th>
            </tr>
            <xsl:for-each
                select="mig2:property[not(mig2:cdm/mig2:cdmDatatype = 'cdmAdministrative')][not(mig2:cdm/mig2:cdmDatatype = 'uwAdministrative')][mig2:descriptions/mig2:instructions/@co = 'item' or mig2:descriptions/mig2:customization/@co = 'item']">
                <tr>
                    <td>
                        <xsl:value-of select="position()"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:label"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:labels/mig2:dc"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmDatatype"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmLarge"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:searchable"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:hidden"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmRequired"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                    </td>
                    <td>
                        <xsl:choose>
                            <xsl:when test="mig2:cdm/mig2:label = 'Title'"> yes </xsl:when>
                            <xsl:when test="mig2:cdm/mig2:label != 'Title'"> no </xsl:when>
                            <xsl:otherwise>***ERROR***</xsl:otherwise>
                        </xsl:choose>
                    </td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:descriptions/mig2:customization/@dd">
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:customization[@co = 'item' or @co = 'all']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:descriptions/mig2:instructions[@co = 'item' or @co = 'all']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                    <td>
                        <xsl:choose>
                            <xsl:when
                                test="../../mig:cdmCode = mig2:examples/mig2:customization/@dd">
                                <xsl:for-each
                                    select="mig2:examples/mig2:customization[@co = 'item' or @co = 'all']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each
                                    select="mig2:examples/mig2:example[@co = 'item' or @co = 'all']/mig2:para">
                                    <p>
                                        <xsl:value-of select="."/>
                                    </p>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                    <td>
                        <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                        <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                </tr>
            </xsl:for-each>
        </table>    -->

<!-- Standalone not yet done for dcmiStyle -->
    <!--
        <h2 style="text-align:center">STANDALONE DESCRIPTION</h2>
        <table border="1">
            <tr>
                <th>#</th>
                <th>CONTENTdm Collection Property</th>
                <th>DC Equivalent</th>
                <th>Cdm Data Type</th>
                <th>Cdm Large</th>
                <th>Searchable</th>
                <th>Hidden</th>
                <th>Required, CONTENTdm</th>
                <th>Cdm Controlled Vocabulary</th>
                <th>Required for all UW collections</th>
                <th>Definition</th>
                <th>Input Instructions</th>
                <th>Examples</th>
                <th>Additional notes on this property</th>
            </tr>
            <xsl:for-each
                select="mig2:property[not(mig2:cdm/mig2:cdmDatatype = 'cdmAdministrative')][not(mig2:cdm/mig2:cdmDatatype = 'uwAdministrative')][mig2:descriptions/mig2:instructions/@co = 'no' or mig2:descriptions/mig2:customization/@co = 'no']">
                <tr>
                    <td>
                        <xsl:value-of select="position()"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:label"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:labels/mig2:dc"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmDatatype"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmLarge"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:searchable"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:hidden"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmRequired"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:uwRequired/mig2:uwStandalone"/>
                    </td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each
                            select="mig2:descriptions/mig2:instructions[@co = 'no']/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each
                            select="mig2:examples/mig2:example[@co = 'no' or @co = 'all']/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                        <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </td>
                </tr>
            </xsl:for-each>
        </table>    
    </xsl:template>  -->

</xsl:stylesheet>
