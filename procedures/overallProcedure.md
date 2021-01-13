# Metadata Management Application: Summary Procedure for CONTENT dm collections

## 1. Create property file(s)
- Use procedure for creating property file(s): //procedures/propertyFiles.html (document created but still has no content).
- Use also [//procedures/cdmCompoundObjects.html]() if the property is intended to describe entire cdm compound objects or cdm compound object items.
    - *Explanation: there should be a property file for every property used to describe digital collections in UW Libraries repositories.*
## 2. Create XML Data Dictionary (DD)
- Use procedure for creating data dictionaries: [//procedures/dd-procedure.html]() (Document is in progress).
    - *Explanation: the XML data dictionary cherry picks the properties used by a given collection; it also contains some general information about itself as the metadata application profile for that collection.*
## 3. Expand XML DD
- Use [//procedures/dd-procedure.html]() (used above in step 2 above) text not yet entered for this in the html file
- Code: [//xslt/identity-expand.xsl]()
    - *Explanation: some routines require an expansion of the xml data dictionary because the xml data dictionary uses xi:include, which is not always recognized.*
## 4. Produce HTML DD
- Use [//procedures/dd-procedure.html]() (used above in step 2 above) text not yet entered for this in the html file
- Code: [//xslt/dds-to-html-xsd.xsl]()
## 5. Produce XML Schema
- Use: //procedures/producingXmlSchema.html
- Code: 
    - [//xslt/dds-to-xmlSchema_standalone.xsl]() for collections that contain only standalone items; code for this needs to be updated, similar to the way dds-to-xmlSchema_combined.xsl was written
    - [//xslt/dds-to-xmlSchema_combined.xsl]() for collections that have both standalone items and compound objects; this is the most recently created method for dds-to-xmlSchema files
    - Code for collections with compound objects only has not yet been written
        - *explanation: [...]*
## 6. Export cdm metadata
- Use: [//procedures/exportAndValidate.html]() ; this document is in progress
- Code: [/xproc/addCoInfo2Export.xpl]() for collections containing compound objects; note: this script was written for cdm combined collections; another script may be required for collection of compound objects only
    - *Explanation: [...]*
## 7. Validate collection metadata
- Use: [//procedures/exportAndValidate.html](), also used in step 6 above
- Code: [...]
    - *Explanation: [...]*
## 8. Prepare report of edits required to clean collection metadata
- Use: No documentation yet begun for this step
    - *Explanation: [...]*
## 9. Update all git repos, including Github
- Use: [//procedures/gitRepoManagement.html]() ; additional information may be available in the soon-to-be deleted file [backupRoutine.html]()
## 10. Record all notes on things-to-be-done in passing
- Use (i.e. enter these notes in the following document): [//procedures/notesForFutureTasks]()