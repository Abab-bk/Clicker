extends Control

@onready var node := preload("res://Scence/UI/HeavenItem.tscn")

var node_size:Vector2 = Vector2(132, 132)
var node_space:Vector2 = Vector2(50, 60)
var root:Node

func _ready() -> void:
	Uhd.hide()
	rebuild()

func rebuild() -> void:
	for i in Settings.Trees.data:
		if Settings.Trees.data[i]["id"] == 70001:
			var new_node = node.instantiate()
			new_node.id = Settings.Trees.data[i]["id"]
			new_node.last = Settings.Trees.data[i]["last"]
			root = new_node
			add_child(new_node)
			continue
		var new_node = node.instantiate()
		new_node.id = Settings.Trees.data[i]["id"]
		new_node.last = Settings.Trees.data[i]["last"]
		add_child(new_node)

func _draw() -> void:
	for i in get_child_count():
		if (i + 1) >= get_child_count():
			return
		else:
			draw_line(get_child(i).global_position, get_child(i + 1).global_position, Color.GREEN, 10.0)
