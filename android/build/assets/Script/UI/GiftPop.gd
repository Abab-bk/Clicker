extends Control

func _ready() -> void:
	$Popup/VBox/Yes.pressed.connect(Callable(self, "yes").bind(func():
		if $Popup/VBox/VBox/LineEdit.text:
			return $Popup/VBox/VBox/LineEdit.text
		else:
			return ""
		))

func yes(code:Callable) -> void:
	Global.yes_gifts(code.call())
	Uhd.hide_color()
	queue_free()
