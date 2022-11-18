//%attributes = {"shared":true}
#DECLARE($xml : Text)

If (False:C215)
	C_TEXT:C284(structurePictureToPasteboard; $1)
End if 

var $image : Picture

If (Count parameters:C259=0)
	
	// Use the current structure
	EXPORT STRUCTURE:C1311($xml)
	
End if 

$image:=xmlStructureToImage($xml; New object:C1471("withIcon"; True:C214))
SET PICTURE TO PASTEBOARD:C521($image)