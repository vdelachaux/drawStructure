//%attributes = {"shared":true}
#DECLARE($xmlStructure : Text)->$image : Picture

If (False:C215)
	C_TEXT:C284(structurePictureAsPDF; $1)
	C_PICTURE:C286(structurePictureAsPDF; $0)
End if 

var $xml : Text

If (Count parameters:C259=0)
	
	// Use the current structure
	EXPORT STRUCTURE:C1311($xml)
	
Else 
	
	$xml:=$xmlStructure
	
End if 

$image:=xmlStructureToImage($xml; New object:C1471("codec"; ".pdf"))