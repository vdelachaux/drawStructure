//%attributes = {"shared":true}
#DECLARE($xmlStructure : Text)

If (False:C215)
	C_TEXT:C284(structurePictureToFile; $1)
End if 

var $xml : Text

If (Count parameters:C259=0)
	
	// Use the current structure
	EXPORT STRUCTURE:C1311($xml)
	
Else 
	
	$xml:=$xmlStructure
	
End if 

xmlStructureToImage($xml; New object:C1471(\
"codec"; ".png"; \
"pathname"; "structure.png"))