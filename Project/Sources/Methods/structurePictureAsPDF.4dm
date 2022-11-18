//%attributes = {"shared":true}
#DECLARE($xml : Text) : Picture

If (False:C215)
	C_TEXT:C284(structurePictureAsPDF; $1)
	C_PICTURE:C286(structurePictureAsPDF; $0)
End if 

var $name : Text

If (Count parameters:C259=0)
	
	// Use the current structure
	EXPORT STRUCTURE:C1311($xml)
	
End if 

$name:=Select document:C905(8858; ".pdf"; "Save as:"; File name entry:K24:17+Use sheet window:K24:11)

If (Bool:C1537(OK))
	
	xmlStructureToImage($xml; New object:C1471(\
		"withIcon"; True:C214; \
		"codec"; ".pdf"; \
		"pathname"; DOCUMENT))
	
End if 