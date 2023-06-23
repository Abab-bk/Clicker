extends Sprite2D

#func _ready() -> void:
#	var mouse_pos:Vector2 = get_global_mouse_position()
#	var tween = get_tree().create_tween()
#	frame = randi_range(0, 106)
#	tween.tween_property(self, "position", Vector2(mouse_pos.x, mouse_pos.y - 200), 0.2)
#	tween.tween_property(self, "position", Vector2(mouse_pos.x - randi_range(-200, 200), mouse_pos.y - 200), 0.2)
#	await tween.finished
#	queue_free()

func _ready() -> void:
	frame = randi_range(0, 106)
	$"../../Timer".start()

func _process(delta: float) -> void:
	$"..".progress_ratio += delta
	await $"../../Timer".timeout
	queue_free()
	
