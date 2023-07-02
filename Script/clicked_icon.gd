extends Sprite2D

func _ready() -> void:
	frame = randi_range(0, 106)
	randomize()
	if randi_range(1, 20) == 1:
		if Global.pot_bag.has(frame):
			if bag_not_fill():
				Global.pot_bag[frame] = Global.pot_bag[frame] + 1
		else:
			if bag_not_fill():
				Global.pot_bag[frame] = 1
	
	$"../../Timer".wait_time = 1
	$"../../Timer".start()

func bag_not_fill() -> bool:
	if Global.get_bag_size() >= Global.MAX_BAG_SPACE:
		return false
	else:
		return true

func _process(delta: float) -> void:
	$"..".progress_ratio += delta
	await $"../../Timer".timeout
	$"../..".queue_free()
