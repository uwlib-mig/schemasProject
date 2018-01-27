<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mig="http://www.lib.washington.edu/msd/mig/schemas/dataDictionaries"
    xmlns:prop="http://faculty.washington.edu/tgis/schemasProject/xsd4md" version="2.0">

    <!-- change collection code in penultimate segment of document URL in variable below -->
    <xsl:variable name="doc"
        select="document('https://server16786.contentdm.oclc.org/dmwebservices/index.php?q=dmGetCollectionFieldInfo/neareast/xml')"/>

    <xsl:key name="cdmProp" match="field" use="name"/>

    <xsl:template match="/">
        <html>
            <xsl:apply-templates select="mig:migDataDictionary"/>
        </html>
    </xsl:template>

    <xsl:template match="mig:migDataDictionary">
        <head>
            <style>
                body{
                    background-color: powderblue;
                }
                h1{
                    color: blue;
                }
                p{
                    color: red;
                }
                table,
                th,
                td{
                    border: 1px solid black;
                }</style>
        </head>
        <body>
            <!-- 
               ************************************************************************************
                   Div 1: matching labels, dd-to-cdm, single table
               ************************************************************************************
            -->
            <div>
                <table border="1">
                    <tr>
                        <th>dd</th>
                        <th>cdm</th>
                    </tr>
                    <xsl:for-each select="mig:properties/prop:property">
                        <tr>
                            <td>
                                <xsl:value-of select="prop:cdm/prop:label"/>
                            </td>
                            <td>
                                <xsl:value-of
                                    select="key('cdmProp', prop:cdm/prop:label, $doc)/name"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                    <tr>
                        <xsl:apply-templates select="fields"/>
                    </tr>
                </table>
            </div>
            
            <!-- 
               ************************************************************************************
                   Div 2: comparing labels, dd-to-cdm, document order, two tables side by side
               ************************************************************************************
            -->
            <div>
                <table border="1" style="float: left;">
                    <tr>
                        <th>dd</th>

                    </tr>
                    <xsl:for-each
                        select="mig:properties/prop:property[prop:cdm/prop:cdmDatatype != 'uwAdministrative']">
                        <tr>
                            <td>
                                <xsl:value-of select="prop:cdm/prop:label"/>
                            </td>

                        </tr>
                    </xsl:for-each>
                </table>
                <!--<td><xsl:value-of select="key('cdmProp2',./position(),$docProp)/name"/></td>-->
                <table border="1">
                    <tr>
                        <th>cdm</th>
                    </tr>
                    <xsl:for-each select="$doc/fields/field">
                        <tr>
                            <td>
                                <xsl:value-of select="name"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
            
            <!-- 
               ************************************************************************************
                 Div 3: comparing dc mappings, dd-to-cdm, document order, two tables side by side
               ************************************************************************************
            -->
            <div>
                <table border="1" style="float: left;">
                    <tr>
                        <th>dd fieldName</th>
                        <th>dd DC Map</th>
                    </tr>
                    <xsl:for-each
                        select="mig:properties/prop:property[prop:cdm/prop:cdmDatatype != 'uwAdministrative']">
                        <tr>
                            <td>dd: <xsl:value-of select="prop:cdm/prop:label"/></td>
                            <td><xsl:value-of select="prop:labels/prop:dc"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <table border="1">
                    <tr>
                        <th>cdm fieldName</th>
                        <th>cdm DC Map</th>
                    </tr>
                    <xsl:for-each select="$doc/fields/field">
                        <tr>
                            <td>cdm: <xsl:value-of select="name"/></td>
                            <td>
                                <xsl:value-of select="dc"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
            
            <!-- 
            ************************************************************************************
            Div 4: comparing cdm datatype, dd-to-cdm, document order, two tables side by side
            ************************************************************************************
            -->
            <div>
                <table border="1" style="float: left;">
                    <tr>
                        <th>dd fieldName</th>
                        <th>dd cdm datatype</th>
                    </tr>
                    <xsl:for-each
                        select="mig:properties/prop:property[prop:cdm/prop:cdmDatatype != 'uwAdministrative']">
                        <tr>
                            <td>dd: <xsl:value-of select="prop:cdm/prop:label"/></td>
                            <td><xsl:value-of select="prop:cdm/prop:cdmDatatype"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <table border="1">
                    <tr>
                        <th>cdm fieldName</th>
                        <th>cdm cdm datatype</th>
                    </tr>
                    <xsl:for-each select="$doc/fields/field">
                        <tr>
                            <td>cdm: <xsl:value-of select="name"/></td>
                            <td>
                                <xsl:value-of select="type"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
            
            <!-- 
                 ************************************************************************************
                   Div 5: comparing cdm large, dd-to-cdm, document order, two tables side by side
                 ************************************************************************************
            -->
            <div>
                <table border="1" style="float: left;">
                    <tr>
                        <th>dd fieldName</th>
                        <th>dd cdm large</th>
                    </tr>
                    <xsl:for-each
                        select="mig:properties/prop:property[prop:cdm/prop:cdmDatatype != 'uwAdministrative']">
                        <tr>
                            <td>dd: <xsl:value-of select="prop:cdm/prop:label"/></td>
                            <td><xsl:value-of select="prop:cdm/prop:cdmLarge"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <table border="1">
                    <tr>
                        <th>cdm fieldName</th>
                        <th>cdm cdm large</th>
                    </tr>
                    <xsl:for-each select="$doc/fields/field">
                        <tr>
                            <td>cdm: <xsl:value-of select="name"/></td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="size='0'">No</xsl:when>
                                    <xsl:when test="size='1'">Yes</xsl:when>
                                    <xsl:otherwise>ERROR</xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
            
            <!-- 
                 ************************************************************************************
                  Div 6: comparing cdm searchable, dd-to-cdm, document order, two tables side by side
                 ************************************************************************************
            -->
            <div>
                <table border="1" style="float: left;">
                    <tr>
                        <th>dd fieldName</th>
                        <th>dd cdm search</th>
                    </tr>
                    <xsl:for-each
                        select="mig:properties/prop:property[prop:cdm/prop:cdmDatatype != 'uwAdministrative']">
                        <tr>
                            <td>dd: <xsl:value-of select="prop:cdm/prop:label"/></td>
                            <td><xsl:value-of select="prop:cdm/prop:searchable"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <table border="1">
                    <tr>
                        <th>cdm fieldName</th>
                        <th>cdm cdm search</th>
                    </tr>
                    <xsl:for-each select="$doc/fields/field">
                        <tr>
                            <td>cdm: <xsl:value-of select="name"/></td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="search='0'">No</xsl:when>
                                    <xsl:when test="search='1'">Yes</xsl:when>
                                    <xsl:otherwise>ERROR</xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
            
            <!-- 
                 ************************************************************************************
                  Div 7: comparing cdm hidden, dd-to-cdm, document order, two tables side by side
                 ************************************************************************************
            -->
            <div>
                <table border="1" style="float: left;">
                    <tr>
                        <th>dd fieldName</th>
                        <th>dd cdm hide</th>
                    </tr>
                    <xsl:for-each
                        select="mig:properties/prop:property[prop:cdm/prop:cdmDatatype != 'uwAdministrative']">
                        <tr>
                            <td>dd: <xsl:value-of select="prop:cdm/prop:label"/></td>
                            <td><xsl:value-of select="prop:cdm/prop:hidden"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <table border="1">
                    <tr>
                        <th>cdm fieldName</th>
                        <th>cdm cdm hide</th>
                    </tr>
                    <xsl:for-each select="$doc/fields/field">
                        <tr>
                            <td>cdm: <xsl:value-of select="name"/></td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="hide='0'">No</xsl:when>
                                    <xsl:when test="hide='1'">Yes</xsl:when>
                                    <xsl:otherwise>ERROR</xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
            
            <!-- 
                 ************************************************************************************
                  Div 8: comparing cdm required, dd-to-cdm, document order, two tables side by side
                 ************************************************************************************
            -->
            <div>
                <table border="1" style="float: left;">
                    <tr>
                        <th>dd fieldName</th>
                        <th>dd cdm required</th>
                    </tr>
                    <xsl:for-each
                        select="mig:properties/prop:property[prop:cdm/prop:cdmDatatype != 'uwAdministrative']">
                        <tr>
                            <td>dd: <xsl:value-of select="prop:cdm/prop:label"/></td>
                            <td><xsl:value-of select="prop:cdm/prop:cdmRequired"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <table border="1">
                    <tr>
                        <th>cdm fieldName</th>
                        <th>cdm cdm required</th>
                    </tr>
                    <xsl:for-each select="$doc/fields/field">
                        <tr>
                            <td>cdm: <xsl:value-of select="name"/></td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="req='0'">No</xsl:when>
                                    <xsl:when test="req='1'">Yes</xsl:when>
                                    <xsl:otherwise>ERROR</xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
            
            <!-- 
                 ************************************************************************************
                  Div 9: comparing cdm CV, dd-to-cdm, document order, two tables side by side
                 ************************************************************************************
            -->
            <div>
                <table border="1" style="float: left;">
                    <tr>
                        <th>dd fieldName</th>
                        <th>dd cdm CV</th>
                    </tr>
                    <xsl:for-each
                        select="mig:properties/prop:property[prop:cdm/prop:cdmDatatype != 'uwAdministrative']">
                        <tr>
                            <td>dd: <xsl:value-of select="prop:cdm/prop:label"/></td>
                            <td><xsl:value-of select="prop:cdm/prop:cdmControlledVocab"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <table border="1">
                    <tr>
                        <th>cdm fieldName</th>
                        <th>cdm cdm CV</th>
                    </tr>
                    <xsl:for-each select="$doc/fields/field">
                        <tr>
                            <td>cdm: <xsl:value-of select="name"/></td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="vocab='0'">No</xsl:when>
                                    <xsl:when test="vocab='1'">Yes</xsl:when>
                                    <xsl:otherwise>ERROR</xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </div>
            
        </body>

    </xsl:template>




</xsl:stylesheet>
