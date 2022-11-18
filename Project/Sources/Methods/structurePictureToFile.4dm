//%attributes = {"shared":true}
#DECLARE($xml : Text)

If (False:C215)
	C_TEXT:C284(structurePictureToFile; $1)
End if 

var $name : Text

If (Count parameters:C259=0)
	
	// Use the current structure
	EXPORT STRUCTURE:C1311($xml)
	
End if 

$name:=Select document:C905(8858; ".png"; "Save as:"; File name entry:K24:17+Use sheet window:K24:11)

If (Bool:C1537(OK))
	
	xmlStructureToImage($xml; New object:C1471(\
		"withIcon"; True:C214; \
		"codec"; ".png"; \
		"pathname"; DOCUMENT))
	
End if 