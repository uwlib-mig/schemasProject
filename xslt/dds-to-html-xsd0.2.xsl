<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mig="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries" 
    xmlns:mig2="http://faculty.washington.edu/tgis/schemasProject/xsd4md" exclude-result-prefixes="xs" version="2.0">

    <xsl:output indent="yes" use-character-maps="angleBrackets"/>

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
                <link rel="stylesheet" href="style.css" type="text/css"/>
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
        <h3>Revised: <xsl:value-of select="mig:latestUpdate"/></h3>
        <h3>Metadata Liaison: <xsl:apply-templates select="mig:metadataLiaisons"/></h3>
        
        <!--note from theo:
            This namespace issue implies a decision:
            will all DDs be in the same namespace,
            or will each DD be in its own namespace?
         -->
        <xsl:choose>
            <xsl:when test="mig:standalone='yes' and mig:cdmCo='no'">
                <xsl:apply-templates select="mig:properties" mode="standalone"/>
            </xsl:when>
            <xsl:when test="mig:standalone='no' and mig:cdmCo='yes'">
                <xsl:apply-templates select="mig:properties" mode="co"/>
            </xsl:when>
            <xsl:when test="mig:standalone='yes' and mig:cdmCo='yes'">
                <xsl:apply-templates select="mig:properties" mode="combined"/>
            </xsl:when>
            <xsl:otherwise><xsl:text>UNDEFINED SCHEMA FORMATIONS; MUST IDENTIFY IF THERE ARE COMPOUND OBJECTS ONLY, STANDALONE OBJECTS ONLY, OR BOTH.</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="mig:metadataLiaisons">
        <xsl:for-each select="mig:metadataLiaison">
            <xsl:choose>
                <xsl:when test="position()=last()">
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
        <table  border="1">
                <tr>
                    <th>#</th>
                    <!--<th width="7%" align="left">Property</th>-->
                    <th>CONTENTdm Collection Property</th>
                    <th>DC Equivalent</th>
                    <th>Searchable</th>
                    <th>Hidden</th>
                    <th>Required</th>
                    <th>Cdm Controlled Vocabulary</th>
                    <th>Definition</th>
                    <th>Input Instructions</th>
                    <th>Examples</th>
                    <th>Additional notes on this property</th>
                </tr>
            <xsl:for-each select="mig2:property[not(mig2:cdm/mig2:cdmDatatype='cdmAdministrative')][mig2:descriptions/mig2:instructions/@co='no']">
                <tr>
                    <td>
                        <xsl:value-of select="position()"/>
                    </td>
                    <!--<td>
                      <xsl:text>dd:</xsl:text>
                        <xsl:value-of select="concat(lower-case(substring(translate(cdm-label,' ',''),1,1)),substring(translate(cdm-label,' ',''),2))"/>
                    </td>-->
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:label"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:labels/mig2:dc"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:searchable"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:hidden"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:required"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                    </td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                            <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="mig2:descriptions/mig2:instructions[@co='no']/mig2:para">
                            <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="mig2:examples/mig2:example[@co='no' or @co='all']/mig2:para">
                              <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                    </td>
                    <td><!-- make sure all CO status include both note types ~and~ co=all below. -->
                        <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                            <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                        <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                            <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <!-- comound objects have not yet been accounted for -->
    <xsl:template match="mig:properties" mode="co">
        <h1 style="text-align:center">*****OBJECT DESCRIPTION*****</h1>
        <table  border="1">
            <tr>
                <th>#</th>
                <th>CONTENTdm Collection Property</th>
                <th>DC Equivalent</th>
                <th>Searchable</th>
                <th>Hidden</th>
                <th>Required</th>
                <th>Cdm Controlled Vocabulary</th>
                <th>Definition</th>
                <th>Input Instructions</th>
                <th>Examples</th>
                <th>Additional notes on this property</th>
            </tr>
            <xsl:for-each select="mig:property[mig:descriptionCoObject/mig:para/text()]">
                <tr>
                    <td>
                        <xsl:value-of select="position()"/>
                    </td>
                    <!--<td>
                      <xsl:text>dd:</xsl:text>
                        <xsl:value-of select="concat(lower-case(substring(translate(cdm-label,' ',''),1,1)),substring(translate(cdm-label,' ',''),2))"/>
                    </td>-->
                    <td>
                        <xsl:value-of select="mig:cdmLabel"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig:dc"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig:searchable"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig:hidden"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig:required"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig:cdmControlledVocab"/>
                    </td>
                    <td>
                        <xsl:for-each select="mig:descriptionCoObject/mig:para">
                                <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="mig:examplesCoObject/mig:para">
                            <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="mig:admin/mig:para">
                            <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                        <xsl:if test="mig:descriptionCoObject/mig:para/text() and mig:descriptionCoItem/mig:para/text()">
                            <p>Property used for both full object description and item description.</p>
                        </xsl:if>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
        <h1 style="text-align:center">*****ITEM DESCRIPTION*****</h1>
        <table  border="1">
            <tr>
                <th>#</th>
                <!--<th width="7%" align="left">Property</th>-->
                <th>CONTENTdm Collection Property</th>
                <th>DC Equivalent</th>
                <th>Searchable</th>
                <th>Hidden</th>
                <th>Required</th>
                <th>Cdm Controlled Vocabulary</th>
                <th>Description</th>
                <th>Examples</th>
                <th>Notes on this property</th>
            </tr>
            <xsl:for-each select="mig:property[mig:descriptionCoItem/text()]">
                <tr>
                    <td>
                        <xsl:value-of select="position()"/>
                    </td>
                    <!--<td>
                      <xsl:text>dd:</xsl:text>
                        <xsl:value-of select="concat(lower-case(substring(translate(cdm-label,' ',''),1,1)),substring(translate(cdm-label,' ',''),2))"/>
                    </td>-->
                    <td>
                        <xsl:value-of select="mig:cdmLabel"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig:dc"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig:searchable"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig:hidden"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig:required"/>
                    </td>
                    <td>
                        <xsl:value-of select="mig:cdmControlledVocab"/>
                    </td>
                    <td>
                        <xsl:for-each select="mig:descriptionCoItem/mig:para"> 
                        <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="mig:examplesCoItem/mig:para">   
                        <p><xsl:value-of select="."/></p>
                    </xsl:for-each>
                    </td>
                    <td>
                        <xsl:for-each select="mig:admin/mig:para"> 
                        <p><xsl:value-of select="."/></p>
                        </xsl:for-each>
                        <xsl:if test="mig:descriptionCoObject/mig:para/text() and mig:descriptionCoItem/mig:para/text()">
                            <p>Property used for both full object description and item description.</p>
                        </xsl:if>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <xsl:template match="mig:properties" mode="combined">
        <h2 style="text-align:center">OBJECT DESCRIPTION</h2>
        <table  border="1">
            <tr>
                <th>#</th>
                <th>CONTENTdm Collection Property</th>
                <th>DC Equivalent</th>
                <th>Cdm Data Type</th>
                <th>Cdm Large</th>
                <th>Searchable</th>
                <th>Hidden</th>
                <th>Required</th>
                <th>Cdm Controlled Vocabulary</th>
                <th>Definition</th>
                <th>Input Instructions</th>
                <th>Examples</th>
                <th>Additional notes on this property</th>
            </tr>
                <xsl:for-each select="mig2:property[not(mig2:cdm/mig2:cdmDatatype='cdmAdministrative')][mig2:descriptions/mig2:instructions/@co='object']">
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
                            <xsl:value-of select="mig2:cdm/mig2:required"/>
                        </td>
                        <td>
                            <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                        </td>
                        <td>
                            <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                                <p><xsl:value-of select="."/></p>
                            </xsl:for-each>
                        </td>
                        <td>
                            <xsl:for-each select="mig2:descriptions/mig2:instructions[@co='object']/mig2:para">
                                <p><xsl:value-of select="."/></p>
                            </xsl:for-each>
                        </td>
                        <td>
                            <xsl:for-each select="mig2:examples/mig2:example[@co='object' or @co='all']/mig2:para">
                                <p><xsl:value-of select="."/></p>
                            </xsl:for-each>
                        </td>
                        <td>
                            <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                                <p><xsl:value-of select="."/></p>
                            </xsl:for-each>
                            <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                                <p><xsl:value-of select="."/></p>
                            </xsl:for-each>
                        </td>
                    </tr> 
                </xsl:for-each> 
        </table>
            
        <h2 style="text-align:center">ITEM DESCRIPTION</h2>
                <table  border="1">
                    <tr>
                        <th>#</th>
                        <!--<th width="7%" align="left">Property</th>-->
                        <th>CONTENTdm Collection Property</th>
                        <th>DC Equivalent</th>
                        <th>Cdm Data Type</th>
                        <th>Cdm Large</th>
                        <th>Searchable</th>
                        <th>Hidden</th>
                        <th>Required</th>
                        <th>Cdm Controlled Vocabulary</th>
                        <th>Definition</th>
                        <th>Input Instructions</th>
                        <th>Examples</th>
                        <th>Additional notes on this property</th>
                    </tr>
                    <xsl:for-each select="mig2:property[not(mig2:cdm/mig2:cdmDatatype='cdmAdministrative')][mig2:descriptions/mig2:instructions/@co='item']">
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
                                <xsl:value-of select="mig2:cdm/mig2:required"/>
                            </td>
                            <td>
                                <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                            </td>
                            <td>
                                <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                                    <p><xsl:value-of select="."/></p>
                                </xsl:for-each>
                            </td>
                            <td>
                                <xsl:for-each select="mig2:descriptions/mig2:instructions[@co='item']/mig2:para">
                                    <p><xsl:value-of select="."/></p>
                                </xsl:for-each>
                            </td>
                            <td>
                                <xsl:for-each select="mig2:examples/mig2:example[@co='item' or @co='all']/mig2:para">
                                    <p><xsl:value-of select="."/></p>
                                </xsl:for-each>
                            </td>
                            <td>
                                <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                                    <p><xsl:value-of select="."/></p>
                                </xsl:for-each>
                                <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                                    <p><xsl:value-of select="."/></p>
                                </xsl:for-each>
                            </td>
                        </tr> 
                    </xsl:for-each> 
                </table>
                
        
        <h2 style="text-align:center">STANDALONE DESCRIPTION</h2>
                    <table  border="1">
                        <tr>
                            <th>#</th>
                            <!--<th width="7%" align="left">Property</th>-->
                            <th>CONTENTdm Collection Property</th>
                            <th>DC Equivalent</th>
                            <th>Cdm Data Type</th>
                            <th>Cdm Large</th>
                            <th>Searchable</th>
                            <th>Hidden</th>
                            <th>Required</th>
                            <th>Cdm Controlled Vocabulary</th>
                            <th>Definition</th>
                            <th>Input Instructions</th>
                            <th>Examples</th>
                            <th>Additional notes on this property</th>
                        </tr>
                        <xsl:for-each select="mig2:property[not(mig2:cdm/mig2:cdmDatatype='cdmAdministrative')][mig2:descriptions/mig2:instructions/@co='no']">
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
                                    <xsl:value-of select="mig2:cdm/mig2:required"/>
                                </td>
                                <td>
                                    <xsl:value-of select="mig2:cdm/mig2:cdmControlledVocab"/>
                                </td>
                                <td>
                                    <xsl:for-each select="mig2:descriptions/mig2:definition/mig2:para">
                                        <p><xsl:value-of select="."/></p>
                                    </xsl:for-each>
                                </td>
                                <td>
                                    <xsl:for-each select="mig2:descriptions/mig2:instructions[@co='no']/mig2:para">
                                        <p><xsl:value-of select="."/></p>
                                    </xsl:for-each>
                                </td>
                                <td>
                                    <xsl:for-each select="mig2:examples/mig2:example[@co='no' or @co='all']/mig2:para">
                                        <p><xsl:value-of select="."/></p>
                                    </xsl:for-each>
                                </td>
                                <td>
                                    <xsl:for-each select="mig2:additionalInfo/mig2:admin/mig2:para">
                                        <p><xsl:value-of select="."/></p>
                                    </xsl:for-each>
                                    <xsl:for-each select="mig2:additionalInfo/mig2:generalNotes/mig2:para">
                                        <p><xsl:value-of select="."/></p>
                                    </xsl:for-each>
                                </td>
                            </tr> 
                        </xsl:for-each> 
                    </table>
    </xsl:template>

</xsl:stylesheet>
