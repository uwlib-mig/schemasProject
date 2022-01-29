xquery version "3.0";
for $i in collection("file:///Users/theodore/Documents/uwl/dds/properties-files/?select=*.xml")/doc(document-uri(.))//description
return rename node $i as "definition"