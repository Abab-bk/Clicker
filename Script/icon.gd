extends Sprite2D

var target:Vector2

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target, 1)
	await tween.finished
	queue_free()
