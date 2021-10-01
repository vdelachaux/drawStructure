//%attributes = {"invisible":true,"preemptive":"capable"}
// ----------------------------------------------------
// Project method : xml_elementToObject
// ID[EE35EDAF20D24025877FA9FC15284E38]
// Created 1-8-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Returns an XML element as an object
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($withRef)
C_LONGINT:C283($count;$i)
C_TEXT:C284($dom;$key;$name;$node;$tValue)

If (False:C215)
	C_OBJECT:C1216(xml_elementToObject;$0)
	C_TEXT:C284(xml_elementToObject;$1)
	C_BOOLEAN:C305(xml_elementToObject;$2)
End if 

// ----------------------------------------------------
// Initialisations
If (Asserted:C1132(Count parameters:C259>=1;"Missing parameter"))
	
	// Required parameters
	$node:=$1
	
	// Optional parameters
	If (Count parameters:C259>=2)
		
		$withRef:=$2
		
	End if 
	
	$0:=New object:C1471
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
// DOM reference
If ($withRef)
	
	$0["@"]:=$node
	
End if 

// Attributes
For ($i;1;DOM Count XML attributes:C727($node);1)
	
	DOM GET XML ATTRIBUTE BY INDEX:C729($node;$i;$key;$tValue)
	
	Case of   // Value types
			
			//______________________________________________________
		: (Length:C16($key)=0)
			
			// Skip malformed node
			
			//______________________________________________________
		: (Match regex:C1019("(?m-si)^\\d+\\.*\\d*$";$tValue;1))  // Numeric
			
			$0[$key]:=Num:C11($tValue;".")
			
			//______________________________________________________
		: (Match regex:C1019("(?mi-s)^true|false$";$tValue;1))  // Boolean
			
			$0[$key]:=($tValue="true")
			
			//______________________________________________________
		Else   // Text
			
			$0[$key]:=$tValue
			
			//______________________________________________________
	End case 
End for 


// Value
DOM GET XML ELEMENT VALUE:C731($node;$tValue)

If (Match regex:C1019("[^\\s]+";$tValue;1))
	
	$0["$"]:=$tValue
	
End if 

// Childs
$dom:=DOM Get first child XML element:C723($node;$name)

If (OK=1)
	
	// Many one?
	$count:=DOM Count XML elements:C726($node;$name)
	
	If ($count>1)  // Yes
		
		$0[$name]:=New collection:C1472
		
		For ($i;1;$count;1)
			
			$0[$name].push(xml_elementToObject(DOM Get XML element:C725($node;$name;$i);$withRef))
			
		End for 
		
	Else   // No
		
		$0[$name]:=xml_elementToObject($dom;$withRef)
		
	End if 
	
	// Next one
	$dom:=DOM Get next sibling XML element:C724($dom;$name)
	
	While (OK=1)
		
		// Already treated?
		If ($0[$name]=Null:C1517)
			
			// Many one?
			$count:=DOM Count XML elements:C726($node;$name)
			
			If ($count>1)  // Yes
				
				$0[$name]:=New collection:C1472
				
				For ($i;1;$count;1)
					
					$0[$name].push(xml_elementToObject(DOM Get XML element:C725($node;$name;$i);$withRef))
					
				End for 
				
			Else   // No
				
				$0[$name]:=xml_elementToObject($dom;$withRef)
				
			End if 
		End if 
		
		// Next one
		$dom:=DOM Get next sibling XML element:C724($dom;$name)
		
	End while 
End if 