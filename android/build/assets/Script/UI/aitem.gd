extends TextureButton

const ICON = preload("res://Scence/UI/icon.tscn")

var num:int
var id:int

func _ready() -> void:
	$Label.text = str(num)
	$Marker2D/Icon.frame = id


