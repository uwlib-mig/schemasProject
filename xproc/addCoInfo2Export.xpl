<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">

    <p:input port="source">
        <p:document href="../cdmData/civilwar.xml"/>
    </p:input>
   
    <p:output port="result">
        <p:pipe port="result" step="store"/>
    </p:output>
    
    <p:xslt name="insert-items">
        <p:input port="stylesheet">
            <p:document href="../xslt/1_insert-co-item-lists.xsl"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>
    
    <p:xslt name="insert-objects">
        <p:input port="stylesheet">
            <p:document href="../xslt/2_insert-co-container-info.xsl"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>
    
    <p:xslt name="insert-modes">
        <p:input port="stylesheet">
            <p:document href="../xslt/3_insert-mode-attribute.xsl"/>
        </p:input>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xslt>
    
    <p:store href="../cdmData/civilWar-co.xml" name="store"/>

</p:declare-step>
