extends Control

func _ready() -> void:
	$Popup/VBox/HBoxContainer/yes.pressed.connect(Callable(self, "yes"))
	$Popup/VBox/HBoxContainer/no.pressed.connect(Callable(self, "no"))

func yes() -> void:
	Global.first_game = false
	Uhd.hide_color()
	queue_free()

func no() -> void:
	Global.first_game = true
	get_tree().quit()
