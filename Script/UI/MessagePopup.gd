extends Control

var title:String
var desc:String

func _ready() -> void:
	$Popup/VBox/VBox/Title.text = title
	$Popup/VBox/VBox/Desc.text = desc
	$Popup/VBox/Cancel.pressed.connect(func(): 
		Uhd.hide_color()
		queue_free())
