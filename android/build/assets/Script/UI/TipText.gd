extends Label

func _ready() -> void:
	var tween:Tween = create_tween()
	tween.tween_property(self, "position", Vector2(global_position + Vector2(0, -50)), 0.5)
	tween.tween_callback(Callable(self, "queue_free"))
