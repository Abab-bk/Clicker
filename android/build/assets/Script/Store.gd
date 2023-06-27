extends CanvasLayer

@onready var coins_node: TextureRect = $Control/Panel/VBox/Center/TextureRect/Title

func _ready() -> void:
	visibility_changed.connect(Callable(self, "show_self"))

func show_self() -> void:
	coins_node.update_self()
