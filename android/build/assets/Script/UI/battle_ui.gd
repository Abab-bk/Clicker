extends Control

@onready var enemy_node = preload("res://Scence/UI/enemy.tscn")
@onready var player_node = preload("res://Scence/UI/player.tscn")

@onready var enemy_group: VBoxContainer = $EnemyGroup
@onready var player_group: VBoxContainer = $PlayerGroup

func _ready() -> void:
	pass

func gen_items() -> void:
	var items = Global.owned_items.duplicate()
	var ids:Array = []
	
	for i in items.keys():
		ids.append([[i], items[i]])
	
	ids.sort_custom(func(a, b):
		if a[1] >= b[1]:
			return true
		else :
			return false)
	
	if ids.size() >= 3:
		var new_node = player_node.instantiate()
		player_group.add_child(new_node)


