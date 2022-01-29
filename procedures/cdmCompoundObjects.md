# Processing CONTENTdm Compound Objects
## In the metadata application profile or data dictionary:
### 1. In the direct children of the root element /migDataDictionary:
- /migDataDictionary/cdmCo
    - Value = 'yes' because the collection does contain compound objects
- /migDataDictionary/standalone
    - Value = 'yes' if there are any standalone objects (that is, objects not contained in a CONTENTdm cmpound object container) in the cdm digital collection
    - Value = 'no' if there are only compound objects in the cdm digital collection
- There are four possible combinations for these elements in the data dictionary; numbers 1 and 2 below pertain to cdm collections with compound objects:
    1. cdmCo=yes, standalone=no
    2. cdmCo=yes, standalone=yes
    3. cdmCo=no, standalone=yes
    4. cdmCo=no, standalone=no
### 2. In the children of the element `/migDataDictionary/properties/property`:
- //property/descriptions/instructions
    - Use @co:
        - @co='no' #denotes MAP instructions on how to describe standalone objects using the present property; this can be used by cdm collections with compound objects and standalone items;
        - @co='object' #denotes MAP instructions on how to describe an entire CONTENTdm compound object as a totality using the present property;
        - @co='item' #denotes MAP instructions on how to describe single items inside CONTENTdm compound objects using the present property;
        - @co='all' #denotes MAP instructions that apply to descriptions of entire compound objects, the items contained within that compound object, and all standalone items in the collection as well.
- //property/descriptions/examples
    - Use @co:
        - @co='no' #denotes MAP list of examples showing how to describe standalone objects using the present property; this can be used by cdm collections with compound objects and standalone items;
        - @co='object' #denotes MAP list of examples of descriptions of an entire CONTENTdm compound objects as a totality using the present property;
        - @co='item' #MAP list of examples of descriptions of single items inside CONTENTdm compound objects using the present property.
        - @co='all' #denotes MAP list of examples of descriptions of entire compound objects, the items contained within that compound object, and all standalone items in the collection as well.
- //property/descriptions/additionalInfo/generalNotes
    - Use @co:
        - @co='no' #denotes MAP additional general information about the present property that pertains to standalone objects; this can be used by cdm collections with compound objects and standalone items;
        - @co='object' #denotes MAP additional general information about the present property that pertains to the entire CONTENTdm compound objects as a totality;
        - @co='item' #denotes MAP additional general information about the present property that pertains to single items inside CONTENTdm compound objects;
        - @co='all' #MAP additional general information about the present property that pertains to all objects in the collection.
- //property/descriptions/additionalInfo/admin
    - Use @co:
        - @co='no' #denotes MAP additional information about admnistering the present property that pertains to standalone objects; this can be used by cdm collections with compound objects and standalone items;
        - @co='object' #denotes MAP additional information about admnistering the present property that pertains to the entire CONTENTdm compound objects as a totality;
        - @co='item' #denotes MAP additional information about admnistering the present property that pertains to single items inside CONTENTdm compound objects;
        - @co='all' #denotes MAP additional information about admnistering the present property that pertains to all objects in the collection.
- //property/descriptions/customization and //property/examples/customization can be used to create collection-specific instructions and examples, respectively; the value will be the text of the instruction or example wrapped in a para element; it requires 2 attributes:
    - @dd #name of the data dictionary to which the customization applies;
    - @level #enter no/object/item/all as decribed above.
- //property/uwRequired is an additional description of cdm collections, as follows:
    - //uwRequiredType/uwStandalone : value will be yes or no; "yes" if MIG requires this property/value for all standalone item descriptions; otherwise "no";
    - //uwRequiredType/uwObject : value will be yes or no; "yes" if MIG requires this property/value for all compound object descriptions; otherwise "no";
    - //uwRequiredType/uwItem : value will be yes or no; "yes" if MIG requires this property/value for all compound item descriptions; otherwise "no";
    - //uwRequiredType/uwCustom : value will be yes or no; "yes" if MIG requires this property/value for all items that are neither standalone, compound objects or compoun d object items; otherwise "no".
### 3. Additional notes on the `@co` in the MAPs/data dictionaries:
- 5 elements permit the use of @co:
    - //instructions
    - //examples
    - //generalNotes
    - //admin
    - //customization
- 5 values are permitted for @co:
    - no
    - object
    - item
    - all
    - agnostic (not listed above as a possible value; use as needed, when the property does not apply to a standalone item, a compound object, or an item)
- 3 values were formerly allowed for @co but have been deprecated:
    - objectAndStandalone
    - itemAndStandalone
    - coAll
### 4. Observations on the need for distinctions in the data dictionaries/MAPs between co = 'no' or 'object' or 'item'
- //definition : the definition for a property is ALWAYS the same, whether the item is co = no, item, object; this is the basis for which we can assign a single URI to the property: it is always by definition the same property and is identified by its URI/identifier.
- //instructions : instructions on inputting descriptions will often vary depending on whether we are using the property to describe a CO item, CO object of standalone item.
- //examples : examples of descriptions will often vary depending on whether we are using the property to describe a CO item, CO object of standalone item.
- //generalNotes : general notes on the property may vary depending on whether we are using the property to describe a CO item, CO object of standalone item.
- //admin : admin notes, which are notes specific to admninistering a given property/values, may vary depending on whether we are using the property to describe a CO item, CO object of standalone item.
- //customization : customizations of a property may be needed not only for specific collections but for CO objects, CO items, and/or standalone items using a given property to describe the item.
- All other properties or properties appear to remain stable across object/item/standalone.


## Creating HTML data dictionaries for CONTENTdm collections containing compound objects from the XML data dictionary using xslt
Three differently formatted data dictionaries are produced using `//schemasProject/xslt/dds-to-html-xsd0.2.xsl` based on values in the data dictionary for two elements:
- /migDataDictionary/cdmCo
- /migDataDictionary/standalone

The three formats are as follows:
- CONTENTdm collection with no compound objects:
    - /migDataDictionary/cdmCo = 'no'
    - /migDataDictionary/standalone = 'yes'
- CONTENTdm collection with compound objects only (the xslt does not yet include instructions for this):
    - /migDataDictionary/cdmCo = 'yes'
    - /migDataDictionary/standalone = 'no'
- CONTENTdm collection with compound objects AND standalone objects:
    - /migDataDictionary/cdmCo = 'yes'
    - /migDataDictionary/standalone = 'yes'


## Problem of the compound object item description
- Compound object items are inconsistently described.
- The current metadata management system relies on consistency and predictability.
- Some CO items require a property, others do not.
- Consequently writing the descriptive needs of CO items into the data dictionary requires some complexity.
- The current proposal anticipates the creation of a common set of //instructions, //examples and //additionalInfo for a given property when describing CO items. When that needs to be overridden, we anticipate using the //customization element.

## How to validate a CONTENTdm collection containing compound objects
See [//schemasProject/procedures/exportAndValidate.html]()

###### tags: `docs_schemasProject`