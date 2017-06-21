import module namespace request="http://exist-db.org/xquery/request" ;
import module namespace xmldb="http://exist-db.org/xquery/xmldb" ;
let $filePath := xmldb:store("/db/xforms/DDs/results",(),request:get-data())
return $filePath