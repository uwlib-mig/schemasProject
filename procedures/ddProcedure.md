# Data Dictionary Procedure
**There are two ways to produce a metadata application profile (MAP):**
1. Enter MAP information directly as XML usinf an XML editor;
2. Enter MAP information into an XForm embedded in an XHTML page using a web browser.
## Method 1: enter MAP information directly as XML using an XML editor
### 1. Make sure all updates to schema-4-dds.xsl are loaded at [http://faculty.washington.edu/tgis/schemasProject/xsd4md/schema-4-dds.xsl](http://faculty.washington.edu/tgis/schemasProject/xsd4md/schema-4-dds.xsl).
- The procedure for this is at [//schemasProject/procedures/gitRepoManagement.html]().
    
### 2. After selecting a cdm collection, export the collection's metadata to a local workstation (it can be deleted at the end of the metadata process). 
- Analyze the collection; deternine if it does or does not contain compound objects (this will change the content of the data dictionary); if so, determine also if the collection contains standalone alongside the compound objects. 
- This information will go into the data dictionary in steps below.
### 3. Open a previously-created metadata application profile (MAP) XML file.
### 4. SAVE AS and enter the filename for the new MAP.
### 5. Edit values for the XML elements:
- edit `/migDataDictionary/@id`
    - find last `@id` by running [$sch/dataDictionaries/xml/queries/listIDs.xsl]() (if an xml source file is needed, use a dummy.xml such as $sch/xslt/dummy.xml)

- Check all attributes in the root element /migDataDictionary; they're mostly namespaces and are probably correct, but correctness should be verified.
- Edit the child XML elements as appropriate:
    - `//ddname` use name of collection on digital collection front page
    - `//ddPartOfProject` enter name of project if applicable
    - `//originalCreationDate` enter date MAP date of creation in EDTF format
    - `//latestUpdate` enter "today's date" in EDTF format
    - `//metadataLiaisons` enter appropriate names using child element `//metadataLiaison`
    - `//cdmCo` enter "yes" if the collection is a CONTENTdm collection that includes compound objects; otherwise enter "no."
        - CONTENTdm compound object processing for MAPs is discussed in detail at [//procedures/cdmCompoundObjects.html]().
    - `//standalone` enter "yes" if the collection is a CONTENTdm collection that includes individual items not contained in a compound object.
        - CONTENTdm compound object processing for MAPs is discussed in detail at [//procedures/cdmCompoundObjects.html]().

    - `//cdmCode` enter the cdm databse code for the collection, if applicable.

### 6. List the properties used to describe the collection:
   - Use xi:include to reference an XML property file previously created in //properties-files.
- Create a new property file when there is no corresponding file, store it in //properties-files, then reference that file using xi:include.
    - Use //procedures/propertyFiles.html to create property files.
- There must be a property file for every property listed in the MAP.
- There are 13 required fields for all collections:
    - Title
    - Date-EDTF
    - Date
    - Dates
    - Digital Collection
    - Order Number
    - Ordering Information
    - Citation Information
    - Repository
    - Repository collection
    - Restrictions
    - RightsURI
    - Type
### 7. Compare MAP properties to CONTENTdm field properties
- Compare properties in the MAP against the properties used in the CONTENTdm database using compareProps-dd-v-cdm.xsl.
- The MAP properties are the definitive definitive of the properties; CONTENTdm field properties should comply with the MAP.
- Change the CONTENTdm field properties as appropriate to comply with the MAP, or devise an alternate solution.
- CONTENTdm field properties can be obtained over http; use [//sch/xslt/compareProps-dd-v-cdm.xsl]()
    - edit the $doc variable; `https://server16786.contentdm.oclc.org/dmwebservices/index.php?q=dmGetCollectionFieldInfo/ayp/xml` is the correct `@select` value (wrapped in a document() function) except the penultimate token should be the cdmCode name of the digital collection.
    - In the oXygen transformation scenario, enter the path to the data dictionary.
    - This transform outputs an html file; name it and store in [//sch/ignore/dd-v-cdm/]().
### 8. Expand the xml using //xslt/identity-expand.xsl, for the following reasons
- To produce a more human readable version of the complete data dictionary (the original xml data dictionary is useful for an "at a glance" view, but the expanded version displays every detail of every property);
- For use by specific routines in the metadata management application that do not recognize xInclude
    - *[begin a list of the routines that cannot use xInclude]*
### 9. Create the HTML data dictionary using [//xslt/dds-to-html-xsd.xsl](); save it to [//dataDictionaries/html]() using the collection name as the filename with a `.html` extension.
### 10. Processing can then move on to the next stage, using the data dictionary as described in "Exporting and Validating CONTENTdm metadata" at [//procedures/exportAndValidateCdm.html]()

###### tags: `docs_schemasProject`
