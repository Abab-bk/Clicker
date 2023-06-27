extends Control

var title:String
var desc:String
var img

func _ready() -> void:
	if img:
		$Popup/VBox/VBox/img.texture = img
		custom_minimum_size.y = 1000
	$Popup/VBox/VBox/Title.text = title
	$Popup/VBox/VBox/Desc.text = desc
	$Popup/VBox/Cancel.pressed.connect(func(): 
		Uhd.hide_color()
		Global.message_pre_yes.emit()
		queue_free())
