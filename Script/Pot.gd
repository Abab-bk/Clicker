extends Control

@onready var grid: GridContainer = $Back/Center/VBox/Margin/VBox/Scroll/Grid
@onready var pot_pos: Vector2 = $Back/Center/VBox/Pot.position + $Back/Center/VBox/Pot.size / 2 * $Back/Center/VBox/Pot.scale
@onready var animation = $AnimationPlayer
@onready var yes: Button = $Back/Center/VBox/Margin/VBox/VBox/Yes

const ICON := preload("res://Scence/UI/icon.tscn")
const ITEM := preload("res://Scence/UI/aitem.tscn")
const ITEM_COUNT:int = 106

var cost:Big = Big.new(800000)

func _ready() -> void:
	gen_item()
	update_cost()
	yes.pressed.connect(Callable(self, "start_work"))
	$Back/Center/VBox/Margin/VBox/VBox/Cancle.pressed.connect(func():
		$"..".go_home())

func update_cost() -> void:
	if Global.min_coins.isLargerThanOrEqualTo(cost):
		cost = Global.min_coins
		yes.text = "炼金 花费 " + cost.toAA() + " 金币"
	else:
		yes.text = "炼金 花费 " + cost.toAA() + " 金币"

func start_work() -> void:
	if not Global.coins.isLargerThanOrEqualTo(cost):
		Uhd.new_message_popup("金币不足", "金币不足")
		return
	
	var all:Array = []
	
	for i in grid.get_children():
		if i.button_pressed:
			i.button_pressed = false
			all.append(i.id)
			var new = ICON.instantiate()
			new.target = pot_pos
			new.global_position = i.global_position
			new.frame = i.id
			Uhd.add_child(new)
			# 删除物品
			Global.pot_bag[i.id] = Global.pot_bag[i.id] - 1
			if Global.pot_bag[i.id] <= 0:
				Global.pot_bag.erase(i.id)
	
	gen_item()
	
	if all.is_empty():
		Uhd.new_message_popup("材料不足", "请至少放入一个材料")
		return
	
	Global.coins.minus(cost)
	
	animation.play("ok")
	await animation.animation_finished
	
	var work:Dictionary
	
	if all.size() < 3:
		work = Settings.Recipe.data[60003]
	else:
		work = Settings.Recipe.data[randi_range(60001, 60029)]
	
	var temp = Global.read_effect(work["bonus"])
	print("尝试应用效果")
	Global.apply_effect(temp)
	
	Uhd.new_message_popup("获得：" + work["name"], work["desc"])


func gen_item() -> void:
	for i in grid.get_children():
		i.queue_free()
	for i in Global.pot_bag:
		var new_item = ITEM.instantiate()
		new_item.id = int(i)
		new_item.num = Global.pot_bag[i]
		grid.call_deferred("add_child", new_item)
#		grid.add_child(new_item)
