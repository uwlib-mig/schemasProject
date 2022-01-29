# Producing XML Schema Files Using XML Data Dictionaries
Below are the steps for creating XML Schema files that can be used to validate CONTENTdm exports.

**Note:** This file can still be populated with information from producingXmlSchema.txt; then that .txt file can be deleted.

## 1. Open the appropriate xslt file:
- For collections with standalone items only, use dds-to-xmlSchema_standalone.xsl -- this file is not up to date; requires edits
- For collection with compound objects only, use dds-to-xmlSchema_cos.xsl -- this file is not yet created
- For collections with standalone items and compound objects, use dds-to-xmlSchema_combined.xsl -- this file is up to date and can serve as a model for the above two transforms
## 2. Input the appropriate xml data dictionary
- It does not have to be the expanded version (i.e. the version with the xInclude is fine)
## 3. Output //xsd4cdm/[cdmCollectionName].xsd

## Notes on the XML schema information in the data dictionaries
*Enter here information taken from producingXmlSchema.txt*

###### tags: `docs_schemasProject`