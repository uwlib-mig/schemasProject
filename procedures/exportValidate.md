# Exporting and Validating Digital Collections Metadata

## 1. Collections with standalone objects only
**Note:** *An export is recommended in dd-procedure.html, step 2; if that export can be used here (if no changes were made while creating the data dictionary) skip to the bullet below that starts "clean the cdm export XML until it is well formed."* 
- Open CONTENTdm admin.
- Navigate to appropriate collection.
- collections > Export > Custom XML : Include all page-level metadata > next
- Enter values for right column "XML tag name" so that it matches the representation of the left column "Field name" property labels in the collection-specific metadata application profile (collection-dd.xml). This is represented in `/migDatadictionary/properties/property/cdm/label`, retaining case but eliminating all spaces.
    - The CONTENTdm administrative metadata fields do not have uniform case for these labels; they should be as follows in the right column "XML Tag Name":
        - ItemURL
        - oclcNumber
        - dateCreated
        - dateModified
        - cdmnumber
        - cdmfilename
        - cdmFilePath
    - "Repeat fields that use identical XML tags"
    - "Repeat fields that contain multiple terms"
- Export cdm metadata
- Save exported file as `/schemasProject/cdmData/[collectionName].xml`
    - **NOTE:** IF THE FILE > 50 MB, SAVE EXPORTED FILE INTO [/schemasProject/ignore/cdmDate-gt-50mb/collectionName.xml]().
    - Doing this prevents the cdm data from being uploaded to Github, which has a recommended max file size of 50 MB. We don't really need this in the app, so it can be saved locally. In fact, we probably don't need to save the cdm data at all, as the export will likely be re-done if a future validation is performed.
- Open file and review
- Clean the cdm export XML until it is well formed; known issues:
    - \<br\>
    - Some headings contain "&" but cdm inserts a line break at the semi-colon, causing malformed XML and headings that don't make sense
- Produce `//schemasProject/xsd4cdm/[collectionName].xsd` using [//schemasProject/xslt/dds-to-xmlSchema.xsl]()
- Validate `//schemasProject/cdmData/[collectionName].xml` using `//schemasProject/xsd4cdm/[collectionName].xsd`
- Make or request changes as appropriate:
    - Make changes to cdm field properties and `//schemasProject/cdmData/[collectionName].xml`
    - Make changes to individual cdm records and `//schemasProject/cdmData/[collectionName].xml` when there are not too many
    - Request batch metadata editing of cdm is there are a lot of records requiring edits. After those edits are done, re-export and validate or edit `//schemasProject/cdmData/[collectionName].xml` and validate.

## 2. Collections with compound objects only
**Note:** Collections with only compound objects can be processed more easily that collections with standalone *and* compound objects.

- COs do not need to be distinguished from standalone; all items can be processed the same, noting only when there is a `.cpd` item (in CONTENTdm File Name).

## 3. Collections with standalone *and* compound objects
- Open CONTENTdm admin.
- Navigate to appropriate collection.
- collections > Export > Custom XML : Include all page-level metadata > next
- Enter values for right column "XML tag name" so that it matches the representation of the left column "Field name" property labels in the collection-specific metadata application profile (collection-dd.xml). This is represented in `/migDatadictionary/properties/property/cdm/label`, retaining case but eliminating all spaces.
    - The CONTENTdm administrative metadata fields do not have uniform case for these labels; they should be as follows in the right column "XML Tag Name":
        - ItemURL
        - oclcNumber
        - dateCreated
        - dateModified
        - cdmnumber
        - cdmfilename
        - cdmFilePath
    - "Repeat fields that use identical XML tags"
    - "Repeat fields that contain multiple terms"
- Export cdm metadata
- Save exported file as `//cdmData/[collectionName].xml`
- Open file and review
- Clean the cdm export XML until it is well formed; known issues:
    - \<br\>
    - Some headings contain "&" but cdm inserts a line break at the semi-colon, causing malformed XML and headings that don't make sense
- Process the cleaned file with the pipeline addCoInfo2Export.xpl
    - Edit /p:declare-step/p:input/p:document; @href should be `../cdmData/[collectionName].xml`
    - Edit /p:declare-step/p:store; @href should be ../cdmData/[nameOfCollection]-co.xml
    - Run the script
- Produce .xsd file using the data dictionary using //xslt/dds-to-xmlSchema-combined.xsl
    - Input `//dataDictionaries/xml/[collectionName]-dd.xml`
    - Output `//xsd4cdm/[collectionName].xsd`
- Use `//xsd4cdm/[collectionName].xsd` to validate `//cdmData/[collectionName]-co.xml`
    - If necessary, edit the .xsd file and/or the xml file to achieve validation; note the errors so that they may be reported to whomever edits the actual CONTENTdm data.
- Edit actual CONTENTdm collection metadata as appropriate.
- Prepare a report of additional edits needed for use by others who make additional edits to the CONTENTdm metadata.

###### tags: `docs_schemasProject`
