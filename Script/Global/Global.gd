extends Node

signal message_pre_yes
signal money_change
signal main_ready

const MAX_BAG_SPACE:int = 20
const UNKONW_NODE = preload("res://Scence/UI/unkonw.tscn")
const MAX_LEVEL:int = 20
const CODES:Array = ["2023617", "程怡然", "旺仔", "炼金术士Clicker", "AcidWallStudio"]
const MAX_TIME_DISTANCE:int = 172800
const VER = 7

var pot_bag:Dictionary = {} # {106: 7}

var used_codes:Array = []
var unknow:NinePatchRect
var unknow_skill:NinePatchRect

var level_list:Array = []
var level:int = 1
var skill_level_list:Array = []
var skill_level:int = 1
var items:VBoxContainer
var skills:VBoxContainer
var not_added_skills:Array = []

var background_audio = AudioServer.get_bus_index("Master")
var first_game:bool = true

var main_scence

var min_coins = Big.new(0)
var coins:Big = Big.new(0) :
	set(new_value):
#		if new_value.isLessThanOrEqualTo(0):
#			coins = Big.new(0)
		coins = new_value
		money_change.emit()

var auto_coin:Big = Big.new(0):
	set(n):
		auto_coin = n
		min_coins = Big.new(auto_coin).multiply(60)

var added_money:Big = Big.new(1000000)
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
		
		if time_distance >= MAX_TIME_DISTANCE:
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

func get_bag_size() -> int:
	var temp:int = 0
	for i in Global.pot_bag:
		temp += Global.pot_bag[i]
	return temp

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

func rework_skill() -> void:
	print("重新计算收益")
	# 先恢复原始收益
#	for id in Global.owned_items_dic:
#		var item = Settings.Items.data[id]["bonus"]
#		var temp:Big = Big.new(item[0], item[1])
#
#		for i in Global.owned_items
	
	for id in Global.owned_skills_dic:
		for effect in Settings.Skills.data[id]["effect"]:
			Global.apply_effect(Global.read_effect(effect))

func apply_effect(effect:PackedStringArray) -> void:
	# ["add[10001][bonus][efficiency][2.0]", "add", "10001", "bonus", "efficiency", "2.0"]
	# ["click[10001][bonus][efficiency][2.0]", "click", "10001", "bonus", "efficiency", "2.0"]
	print("应用效果")
	target_effect["Type"] = effect[1] # -> add
	print(target_effect["Type"], effect[1])
	target_effect["Properties"] = effect[3]
	target_effect["Multiplier"] = float(effect[5])
	target_item_id = int(effect[2]) # -> 10001
	
	# 匹配效果
	match target_effect["Type"]:
		"add":
			# 判断该物品是否存在：
			if not owned_items.has(target_item_id):
				return
			# 获取受影响物品的总数
			item_count = owned_items[target_item_id]["owned"]
			# 先拿到受影响物品
			var target_item:Item_Class = owned_items[target_item_id]
			# 先判断目标是否有这个效果
			if not target_item.get(target_effect["Properties"]):
				return
			# 拿到原始效果
			var origin_pro:Big = target_item.get(target_effect["Properties"]) # -> bonus
			
			# 然后设置新效果
			# bonus = 20 * 2.0
			var new_effect:Big = Big.new(origin_pro).multiply(target_effect["Multiplier"])
			
			# 把新值应用到目标物品
			target_item.set(target_effect["Properties"], new_effect)
			
			# 把倍率应用的目标物品
#			target_item.now_level = target_effect["Multiplier"]
			
			# 最后让受影响物品增加效果
			# plus(单个物品的收益 * 物品数量 - 原来单个收益 * 物品数量)
			auto_coin.plus(Big.new(new_effect).multiply(item_count).minus(Big.new(origin_pro).multiply(item_count)))
		"click":
			added_money = added_money.multiply(target_effect["Multiplier"])
		"reduce":
			print("减少钱")
			coins.minus(int(target_effect["Multiplier"]))
		"coins":
			print("增加钱")
			coins.plus(int(target_effect["Multiplier"]))

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
	
	min_coins = Big.new(auto_coin).multiply(60)

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
		"first_game": first_game,
		"pot_bag": pot_bag,
		"not_added_skills": not_added_skills
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
	
	for i in level_list:
		if Global.coins.isLargerThanOrEqualTo(i):
			level += 1
			temp.append(i)
	
	if temp.is_empty():
		return
	
	for i in temp:
		level_list.erase(i)
	
	start()

func remove_unknow_node() -> void:
	if unknow:
		unknow.queue_free()

func add_unknow_node() -> void:
	var new_node = UNKONW_NODE.instantiate()
	items.add_child(new_node)
	unknow = new_node

func start():
	remove_unknow_node()
	
	for i in range(items.get_child_count()):
		var child = items.get_child(i)
		child.visible = i < level
	
#	for i in range(skills.get_child_count()):
#		var child = skills.get_child(i)
#		child.visible = i < level
	
	add_unknow_node()
