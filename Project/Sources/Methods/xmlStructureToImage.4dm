//%attributes = {"invisible":true}
#DECLARE($xmlStructure : Text; $options : Object)->$image : Picture

If (False:C215)
	C_TEXT:C284(xmlStructureToImage; $1)
	C_OBJECT:C1216(xmlStructureToImage; $2)
	C_PICTURE:C286(xmlStructureToImage; $0)
End if 

var $b; $destinationMiddle; $g; $middle; $middleOffset; $offsetX : Real
var $r; $sourceMiddle; $via; $x1; $x2; $y1 : Real
var $y2 : Real
var $data; $defs; $marker; $node; $pathname; $shadow : Text
var $icon : Picture
var $isRegular : Boolean
var $maxHeight; $maxWidth : Integer
var $field; $relation; $src; $structure; $table; $tgt : Object
var $tables : Collection
var $folder : 4D:C1709.Folder
var $svg : cs:C1710.svg
var $xml : cs:C1710.xml

$xml:=cs:C1710.xml.new($xmlStructure)
$structure:=$xml.toObject()
$xml.close()

If ($structure.table#Null:C1517)
	
	$structure.types:=New collection:C1472
	
	If (Bool:C1537($options.withIcon))
		
		$folder:=Folder:C1567(Get 4D folder:C485(-1); fk platform path:K87:2).folder("Images/StructureEditor")
		$structure.types:=New collection:C1472
		READ PICTURE FILE:C678($folder.file("Field_5.png").platformPath; $icon)
		$structure.types[1]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_6.png").platformPath; $icon)
		$structure.types[3]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_7.png").platformPath; $icon)
		$structure.types[4]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_8.png").platformPath; $icon)
		$structure.types[5]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_9.png").platformPath; $icon)
		$structure.types[6]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_10.png").platformPath; $icon)
		$structure.types[7]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_3.png").platformPath; $icon)
		$structure.types[8]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_4.png").platformPath; $icon)
		$structure.types[9]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_2.png").platformPath; $icon)
		$structure.types[10]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_21.png").platformPath; $icon)
		$structure.types[12]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_11.png").platformPath; $icon)
		$structure.types[18]:=$icon
		READ PICTURE FILE:C678($folder.file("Field_14.png").platformPath; $icon)
		$structure.types[21]:=$icon
		
	Else 
		
		$structure.types[1]:="B"
		$structure.types[3]:="16"
		$structure.types[4]:="32"
		$structure.types[5]:="64"
		$structure.types[6]:=".5"
		$structure.types[7]:="F"
		$structure.types[8]:="D"
		$structure.types[9]:="H"
		$structure.types[10]:="T"
		$structure.types[12]:="I"
		$structure.types[18]:="X"
		$structure.types[21]:="{}"
		
	End if 
	
	$svg:=cs:C1710.svg.new()\
		.fill("white")\
		.fillOpacity(1)
	
	$defs:=DOM Create XML element:C865($svg.root; "defs")
	
	$marker:=DOM Create XML element:C865($defs; "marker"; \
		"id"; "relation_N"; \
		"refX"; 3; \
		"refY"; 3; \
		"markerWidth"; 6; \
		"markerHeight"; 6)
	$node:=DOM Create XML element:C865($marker; "circle"; \
		"cx"; 3; \
		"cy"; 3; \
		"r"; 1.8; \
		"stroke"; "black"; \
		"fill"; "white"; \
		"stroke-width"; 0.5)
	
	$marker:=DOM Create XML element:C865($defs; "marker"; \
		"id"; "relation_1"; \
		"refX"; 4; \
		"refY"; 3; \
		"markerWidth"; 6; \
		"markerHeight"; 6; \
		"orient"; "auto")
	$node:=DOM Create XML element:C865($marker; "polygon"; \
		"fill"; "white"; \
		"stroke"; "black"; \
		"stroke-width"; 0.5; \
		"points"; "1,1 1,5 5,3")
	
	$shadow:=DOM Create XML element:C865($marker; "filter"; \
		"id"; "Shadow")
	$node:=DOM Create XML element:C865($shadow; "feGaussianBlur"; \
		"stdDeviation"; 4; \
		"in"; "SourceAlpha"; \
		"result"; "_Blur")
	$node:=DOM Create XML element:C865($shadow; "feOffset"; \
		"dx"; 4; \
		"dy"; 4; \
		"in"; "_Blur"; \
		"result"; "_Offset")
	$node:=DOM Create XML element:C865($shadow; "feBlend"; \
		"in"; "SourceGraphic"; \
		"in2"; "_Offset"; \
		"mode"; "normal")
	
	$svg.layer("structure").setAttribute("filter"; "url(#Shadow)")
	
	If (Value type:C1509($structure.table)=Is object:K8:27)
		
		$structure.table:=New collection:C1472($structure.table)
		
	End if 
	
	$tables:=New collection:C1472
	
	For each ($table; $structure.table.query("table_extra.trashed = null OR table_extra.trashed != true"))
		
		$svg.group($table.uuid; "structure")
		
		// TABLE COLOR
		$r:=Num:C11($table.table_extra.editor_table_info.color.red)
		$g:=Num:C11($table.table_extra.editor_table_info.color.green)
		$b:=Num:C11($table.table_extra.editor_table_info.color.blue)
		
		Case of 
				
				//……………………………………………………………………
			: (($r+$g+$b)=0)
				
				$table.color:="dimgray"  // Default
				
				//……………………………………………………………………
			: ($r=255)\
				 & ($g=$r)\
				 & ($b=$r)
				
				$table.color:="gainsboro"
				
				//……………………………………………………………………
			Else 
				
				$table.color:="rgb("+String:C10($r)+","+String:C10($g)+","+String:C10($b)+")"
				
				//……………………………………………………………………
		End case 
		
		$table.left:=Num:C11($table.table_extra.editor_table_info.coordinates.left)
		$table.top:=Num:C11($table.table_extra.editor_table_info.coordinates.top)
		$table.width:=Num:C11($table.table_extra.editor_table_info.coordinates.width)
		$table.height:=Num:C11($table.table_extra.editor_table_info.coordinates.height)
		
		If (($table.left+$table.width)>$maxWidth)
			
			$maxWidth:=$table.left+$table.width
			
		End if 
		
		If (($table.top+$table.height)>$maxHeight)
			
			$maxHeight:=$table.top+$table.height
			
		End if 
		
		// TABLE RECT
		$svg.rect(25; $table.width)\
			.position($table.left; $table.top)\
			.size($table.width; 25)\
			.rx(5)\
			.strokeColor("black")\
			.fillColor($table.color)
		
		// TABLE NAME
		$svg.text($table.name)\
			.position($table.left+($table.width/2); $table.top+15)\
			.alignment(Align center:K42:3)
		
		If ($table.field#Null:C1517)
			
			$table.top:=$table.top+20
			
			If (Value type:C1509($table.field)=Is object:K8:27)
				
				$table.field:=New collection:C1472($table.field)
				
			End if 
			
			// FIELD ORDER
			Case of 
					
					//______________________________________________________
				: (Num:C11($table.table_extra.editor_table_info.fields_ordering)=1)  // Creation
					
					// <NOTHING MORE TO DO>
					
					//______________________________________________________
				: (Num:C11($table.table_extra.editor_table_info.fields_ordering)=2)  // Custom
					
					$table.field:=$table.field.orderBy("field_extra.position")
					
					//______________________________________________________
				: (Num:C11($table.table_extra.editor_table_info.fields_ordering)=3)  // Type
					
					$table.field:=$table.field.orderBy("type")
					
					//______________________________________________________
				: (Num:C11($table.table_extra.editor_table_info.fields_ordering)=4)  // Alphabetic
					
					$table.field:=$table.field.orderBy("name")
					
					//______________________________________________________
				: (Num:C11($table.table_extra.editor_table_info.fields_ordering)=5)  // Related fields
					
					// MARK:TO DO
					
					//______________________________________________________
				: (Num:C11($table.table_extra.editor_table_info.fields_ordering)=6)  // Indexed fields
					
					$table.field:=$table.field.orderBy("index_ref")
					
					//______________________________________________________
				: (Num:C11($table.table_extra.editor_table_info.fields_ordering)=7)  // Visibility
					
					$table.field:=$table.field.orderBy("field_extra.visible desc")
					
					//______________________________________________________
			End case 
			
			For each ($field; $table.field)
				
				// FONT DECORATION
				$field.fontStyle:=Plain:K14:1
				
				If ($field.field_extra.visible#Null:C1517)\
					 & (Not:C34(Bool:C1537($field.field_extra.visible)))
					
					$field.fontStyle:=Italic:K14:3
					
				End if 
				
				If ($field.index_ref#Null:C1517)
					
					$field.fontStyle:=$field.fontStyle+Bold:K14:2
					
				End if 
				
				If ($field.name=String:C10($table.primary_key.field_name))
					
					$field.fontStyle:=$field.fontStyle+Underline:K14:4
					
				End if 
				
				// FONT COLOR
				$r:=Num:C11($field.field_extra.editor_field_info.color.red)
				$g:=Num:C11($field.field_extra.editor_field_info.color.green)
				$b:=Num:C11($field.field_extra.editor_field_info.color.blue)
				
				If (($r+$g+$b)=0)\
					 | (($r=255) & ($g=$r) & ($b=$r))
					
					// Default
					$field.color:="black"
					
				Else 
					
					$field.color:="rgb("+String:C10($r)+","+String:C10($g)+","+String:C10($b)+")"
					
				End if 
				
				// Keep coordinates for relation management
				$field.coordinates:=New object:C1471(\
					"x"; $table.left; \
					"y"; $table.top; \
					"width"; $table.width; \
					"height"; 20)
				
				$svg.rect(25; $table.width; "structure")\
					.position($field.coordinates.x; $field.coordinates.y)\
					.size($field.coordinates.width; $field.coordinates.height)\
					.strokeColor("black")\
					.fillColor($table.color)\
					.id($field.uuid)
				
				$svg.rect(25; $table.width; "structure")\
					.position($field.coordinates.x; $field.coordinates.y)\
					.size($field.coordinates.width; $field.coordinates.height)\
					.strokeColor("none")\
					.fillColor("white")\
					.fillOpacity(0.3)
				
				$field.coordinates.y:=$field.coordinates.y+15
				
				// FIELD NAME
				$svg.text($field.name; "structure")\
					.position($field.coordinates.x+8; $field.coordinates.y)\
					.alignment(Align left:K42:2)\
					.fontStyle($field.fontStyle)\
					.fill($field.color)\
					.stroke($field.color)
				
				// FIELD TYPE
				$svg.text(Choose:C955($field.limiting_length#Null:C1517; "A"; $structure.types[Num:C11($field.type)]); "structure")\
					.position($field.coordinates.x+$field.coordinates.width-15; $field.coordinates.y)\
					.alignment(Align center:K42:3)\
					.fontSize(10)
				
				$table.top:=$field.coordinates.y+5
				
			End for each 
			
		End if 
		
		$tables.push($table)
		
	End for each 
	
	If ($structure.relation#Null:C1517)
		
		If (Value type:C1509($structure.relation)=Is object:K8:27)
			
			$structure.relation:=New collection:C1472($structure.relation)
			
		End if 
		
		For each ($relation; $structure.relation)
			
			$relation.source:=$relation.related_field.query("kind = source").pop()
			$relation.destination:=$relation.related_field.query("kind = destination").pop()
			
			If ($relation.source#Null:C1517)\
				 & ($relation.destination#Null:C1517)
				
				$src:=$tables.query("field[].uuid = :1"; $relation.source.field_ref.uuid).pop()\
					.field.query("uuid = :1"; $relation.source.field_ref.uuid).pop()\
					.coordinates
				
				$tgt:=$tables.query("field[].uuid = :1"; $relation.destination.field_ref.uuid).pop()\
					.field.query("uuid = :1"; $relation.destination.field_ref.uuid).pop()\
					.coordinates
				
				// COLOR
				$r:=Num:C11($relation.relation_extra.editor_relation_info.color.red)
				$g:=Num:C11($relation.relation_extra.editor_relation_info.color.green)
				$b:=Num:C11($relation.relation_extra.editor_relation_info.color.blue)
				
				If (($r+$g+$b)=0)\
					 | (($r=255) & ($g=$r) & ($b=$r))
					
					// Default
					$relation.color:="black"
					
				Else 
					
					$relation.color:="rgb("+String:C10($r)+","+String:C10($g)+","+String:C10($b)+")"
					
				End if 
				
				$sourceMiddle:=($src.x+$src.width)/2
				$destinationMiddle:=($tgt.x+$tgt.width)/2
				$middleOffset:=$destinationMiddle-$sourceMiddle
				
				If ($src.x<$tgt.x)
					
					$offsetX:=$tgt.x-$src.x
					
				Else 
					
					$offsetX:=$src.x-$tgt.x
					
				End if 
				
				$isRegular:=(Abs:C99($middleOffset)>80)
				
				If (($tgt.x-$src.x)>$src.width)
					
					If ($isRegular)
						
						$x1:=$src.x+$src.width
						
					Else 
						
						$x1:=$src.x
						
					End if 
					
					$x2:=$tgt.x
					
				Else 
					
					$x1:=$src.x
					
					If ($isRegular)
						
						$x2:=$tgt.x+$tgt.width
						
					Else 
						
						$x2:=$tgt.x
						
					End if 
					
				End if 
				
				$y1:=$src.y-15+($src.height/2)
				$y2:=$tgt.y-15+($tgt.height/2)
				
				If (Abs:C99($y2-$y1)<2)
					
					$y1:=$y2
					
				End if 
				
				If ($isRegular)
					
					$middle:=($x2-$x1)/2
					$via:=$x1+$middle
					
				Else 
					
					If ($x2>($x1+$src.width))
						
						$via:=$x2-Abs:C99($middleOffset)-50
						
					Else 
						
						$via:=$x1-Abs:C99($middleOffset)
						
					End if 
					
				End if 
				
				$data:=String:C10($x1; "&xml")+","+String:C10($y1; "&xml")+" "\
					+String:C10($via; "&xml")+","+String:C10($y1; "&xml")+" "\
					+String:C10($via; "&xml")+","+String:C10($y2; "&xml")+" "\
					+String:C10($x2; "&xml")+","+String:C10($y2; "&xml")
				
				$svg.polyline($data; "structure")\
					.stroke($relation.color)\
					.strokeWidth(3)\
					.setAttributes(New object:C1471("marker-start"; "url(#relation_N)"; \
					"marker-end"; "url(#relation_1)"; \
					"stroke-linejoin"; "round"; \
					"stroke-opacity"; "0.8"))
				
				// RELATION NAMES
				$svg.text($relation.name_Nto1; "root")\
					.position($x1+8; $y1-5)\
					.alignment(Align left:K42:2)\
					.fontSize(10)\
					.fill($relation.color)
				
				$svg.text($relation.name_1toN; "root")\
					.position($x2-8; $y2+15)\
					.alignment(Align right:K42:4)\
					.fontSize(10)\
					.fill($relation.color)
				
			End if 
		End for each 
	End if 
End if 

$svg.width($maxWidth+10; "root")
$svg.height($maxHeight+10; "root")

$image:=$svg.picture()

If (Count parameters:C259>=2)
	
	If ($options.codec#Null:C1517)
		
		CONVERT PICTURE:C1002($image; String:C10($options.codec))
		
		If ($options.pathname#Null:C1517)
			
			WRITE PICTURE FILE:C680(String:C10($options.pathname); $image; String:C10($options.codec))
			
		End if 
	End if 
End if 