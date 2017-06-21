import module namespace request="http://exist-db.org/xquery/request" ;
import module namespace xmldb="http://exist-db.org/xquery/xmldb" ;
declare namespace xsi="http://www.w3.org/2001/XMLSchema-instance" ;
let $doc := request:get-data()
let $update := update insert attribute xsi:schemaLocation {'http://faculty.washington.edu/tgis/xml/xsd/modules/xsd4md/ http://faculty.washington.edu/tgis/xml/xsd/modules/xsd4md/schema-4-properties-0.1.xsd'} into $doc
let $filePath := xmldb:store("/db/xforms/DDs/results",(),$doc)
return $filePath