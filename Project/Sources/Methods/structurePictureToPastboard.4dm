//%attributes = {"shared":true}
#DECLARE($xmlStructure : Text)

If (False:C215)
	C_TEXT:C284(structurePictureToPastboard; $1)
End if 

var $xml : Text
var $image : Picture

If (Count parameters:C259=0)
	
	// Use the current structure
	EXPORT STRUCTURE:C1311($xml)
	
Else 
	
	$xml:=$xmlStructure
	
End if 

$image:=xmlStructureToImage($xml)
SET PICTURE TO PASTEBOARD:C521($image)