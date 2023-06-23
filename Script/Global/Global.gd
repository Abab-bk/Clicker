extends Node

signal message_pre_yes

const UNKONW_NODE = preload("res://Scence/UI/unkonw.tscn")
const MAX_LEVEL:int = 20
const CODES:Array = ["2023617", "程怡然", "旺仔"]
const MAX_TIME_DISTANCE:int = 172800
const VER = 2

var used_codes:Array = []
var unknow:NinePatchRect
var unknow_skill:NinePatchRect

var level_list:Array = []
var level:int = 1
var skill_level_list:Array = []
var skill_level:int = 1
var items:VBoxContainer
var skills:VBoxContainer

var background_audio = AudioServer.get_bus_index("Master")
var first_game:bool = true

var main_scence

var coins:Big = Big.new(0) :
	set(new_value):
		coins = new_value
		money_change.emit()

var auto_coin:Big = Big.new(0)
var added_money:Big = Big.new(1)
# {
#   10001（ID）: Item_Class（对象）
# }
var owned_items:Dictionary = {}
var owned_items_dic:Dictionary = {}
var owned_skills:Dictionary = {}
var owned_skills_dic:Dictionary = {}

var coins_text:String = coins.toAA()

var time_distance:int :
	set(new_value):
		time_distance = int(Time.get_unix_time_from_system()) - new_value
		
		
		var added_new_coins:Big = Big.new(auto_coin).multiply(time_distance)
		
		
		if added_new_coins.isLargerThanOrEqualTo(MAX_TIME_DISTANCE):
			make_money(Big.new(auto_coin).multiply(MAX_TIME_DISTANCE))
		else:
			make_money(added_new_coins)

# =========== 技能相关 ===========
var target_item_id:int
var item_count:int
# 目标效果影响的属性
var target_effect:Dictionary = {
	"Type": "add",
	"Method": "efficiency",
	"Properties": "bonus",
	"Multiplier": 2.0,
}
# ==============================

signal money_change

func title_bar() -> void:
	pass

func auto_make_money() -> void:
	make_money(auto_coin)
	Uhd.new_tip_toolbar("+" + auto_coin.toString())

func make_money(value) -> void:
	coins.plus(value)
	money_change.emit()

func spent_money(value) -> void:
	coins.minus(value)
	money_change.emit()

func get_item_by_id(id) -> Array:
	return owned_items[id]

func apply_effect(effect:PackedStringArray) -> void:
	# ["add[10001][bonus][efficiency][2.0]", "add", "10001", "bonus", "efficiency", "2.0"]
	# ["click[10001][bonus][efficiency][2.0]", "click", "10001", "bonus", "efficiency", "2.0"]
	
	target_effect["Type"] = effect[1] # -> add
	target_effect["Properties"] = effect[3]
	target_effect["Multiplier"] = float(effect[5])
	target_item_id = int(effect[2]) # -> 10001
	
	# 判断该物品是否存在：
	if not owned_items.has(target_item_id):
		return
	
	# 获取受影响物品的总数
	item_count = owned_items[target_item_id]["owned"]
	
	# 匹配效果
	match target_effect["Type"]:
		"add":
			# 先拿到受影响物品的效果
			var target_item:Item_Class = owned_items[target_item_id]
			# 先判断目标是否有这个效果
			if not target_item.get(target_effect["Properties"]):
				return
			var effected_properties:Big = target_item.get(target_effect["Properties"]) # -> bonus
			
			# 然后设置新效果
			# bonus = 20 * 2.0
			var new_effect:Big = Big.new(effected_properties).multiply(target_effect["Multiplier"])
			
			# 最后让受影响物品增加效果
			auto_coin.plus(Big.new(new_effect).multiply(item_count).minus(Big.new(effected_properties).multiply(item_count)))
			
			target_item.set(target_effect["Properties"], new_effect)
		"click":
			added_money = added_money.multiply(target_effect["Multiplier"])

func read_effect(effect:String) -> PackedStringArray:
	var reg := RegEx.new()
	reg.compile("^(\\w+)\\[(\\d+)\\]\\[(\\w+)\\]\\[(\\w+)\\]\\[(\\d+(?:\\.\\d+)?)\\]$")
	var result := reg.search(effect).strings
	return result

func yes_gifts(code:String) -> void:
	if code in used_codes:
		Uhd.new_message_popup("兑换结果", "此兑换码已经被使用了...")
	elif code in CODES:
		Uhd.new_message_popup("兑换结果", "兑换成功！获得 金币*1000000 ")
		get_gifts(Big.new(1000000))
		used_codes.append(code)
	else:
		Uhd.new_message_popup("兑换结果", "礼包码不存在..")

func get_gifts(number:Big) -> void:
	make_money(number)

func set_audio_size(value:float) -> void:
	AudioServer.set_bus_volume_db(background_audio, linear_to_db(value))

func _ready() -> void:
	money_change.connect(Callable(self, "update_coins_text"))
	money_change.connect(Callable(self, "change"))
	
	load_save()

func update_coins_text() -> void:
	coins_text = coins.toAA()

func load_save() -> void:
	SaveAndLoad.load_save()
	set_audio_size(5.0)

func save() -> bool:
	var new_save_dic:Dictionary = {}
	for i in owned_items.keys():
		new_save_dic[i] = owned_items[i].get_save_data()
	
	var new_skill_save_dic:Dictionary = {}
	for i in owned_skills.keys():
		new_skill_save_dic[i] = owned_skills[i].get_save_data()
	
	var save_dic = {
		"skills": new_skill_save_dic,
		"items": new_save_dic,
		"coins": coins.get_save_data(),
		"auto_coin": auto_coin.get_save_data(),
		"added_money": added_money.get_save_data(),
		"time": Time.get_unix_time_from_system(),
		"level": level,
		"used_codes": used_codes,
		"ver": VER,
		"first_game": first_game
	}
	print("save")
	SaveAndLoad.save(save_dic)
	return true

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		if save():
			get_tree().quit()

	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if save():
			get_tree().quit()

func change() -> void:
	var temp:Array = []
	var temp2:Array = []
	
	for i in level_list:
		if Global.coins.isLargerThanOrEqualTo(i):
			level += 1
			temp.append(i)
	
	for i in skill_level_list:
		if Global.coins.isLargerThanOrEqualTo(i):
			skill_level += 1
			temp2.append(i)
	
	if temp.is_empty():
		return
	
	if temp2.is_empty():
		return
	
	for i in temp:
		level_list.erase(i)
	
	for i in temp2:
		skill_level_list.erase(i)
	
	start()

func remove_unknow_node() -> void:
	if unknow:
		unknow.queue_free()
	if unknow_skill:
		unknow_skill.queue_free()

func add_unknow_node() -> void:
	var new_node = UNKONW_NODE.instantiate()
	items.add_child(new_node)
	var new_node2 = UNKONW_NODE.instantiate()
	skills.add_child(new_node2)
	unknow = new_node
	unknow_skill = new_node2

func start():
	remove_unknow_node()
	
	for i in range(items.get_child_count()):
		var child = items.get_child(i)
		child.visible = i < level
	
#	for i in range(skills.get_child_count()):
#		var child = skills.get_child(i)
#		child.visible = i < level
	
	add_unknow_node()
