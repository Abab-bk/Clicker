extends Node

## Global：几乎有全局的所有数据

## 如果消息框被确认
signal message_pre_yes
## 金钱改变时发出
signal money_change
## 主场景准备好时发出
signal main_ready
## 天堂筹码改变时发出，不确定用不用，好像已经迁移到ChipsManager
signal chips_change

## 每日最大观看广告次数
const MAX_AD:int = 6
## 背包最大空间
const MAX_BAG_SPACE:int = 20
## 未知物品节点（一切等待伟大的炼金术士探索）
const UNKONW_NODE = preload("res://Scence/UI/unkonw.tscn")
## 最多有多少个物品
const MAX_LEVEL:int = 20
## 兑换码
const CODES:Array = ["2023617", "旺仔", "炼金术士Clicker", "AcidWallStudio"]
## 最大挂机时间
const MAX_TIME_DISTANCE:int = 172800
## 内部版本号
const VER = 8

## 当前观看广告次数
var current_ad:int = 0
## 上一次观看广告时间：20230704
var last_ad_time:int = 0

## 背包内含有的数据
var pot_bag:Dictionary = {} # {106: 7} -> id： 数量

## 已经使用过的兑换码
var used_codes:Array = []
## 未知物品节点
var unknow:NinePatchRect = null
## 位置技能节点
var unknow_skill:NinePatchRect = null

## 已经解锁的物品（显示，不一定购买）
var level_list:Array = []
## 当前解锁到哪里
var level:int = 1
## 同上，不过并没有使用，因为各种原因没写好
var skill_level_list:Array = []
var skill_level:int = 1
## 物品商店的父节点
var items:VBoxContainer
## 技能商店的父节点
var skills:VBoxContainer
## 忘了
var not_added_skills:Array = []

var background_audio = AudioServer.get_bus_index("Master")
var first_game:bool = true

var main_scence
var min_coins = Big.new(0)

# (10^12) * ((K+1)^3 - K^3) -> K: 已拥有的Chip数量
# 还需要多少饼干可以获得下一个天堂筹码
#var coins_needed:Big = Big.new(0)
# 开立方(N/10^12).向下取整
#var chips_total:Big = Big.new(0)
#var needed_total_coins:Big = Big.new(0)
#var chips:Big = Big.new(0):
#	set(n):
#		chips = n
#		chips_change.emit()

## 金币数量
var coins:Big = Big.new(0) :
	set(new_value):
		if new_value.isLessThanOrEqualTo(0):
			coins = Big.new(0)
		coins = new_value
		all_coins.plus(all_coins.minus(coins))
		money_change.emit()

## 获得的所有金币数量，没写好
var all_coins:Big = Big.new(0):
	set(n):
		if n.isLessThanOrEqualTo(0):
			all_coins = Big.new(0)

## 每秒自动加金币的数量
var auto_coin:Big = Big.new(0):
	set(n):
		auto_coin = n
		min_coins = Big.new(auto_coin).multiply(60)

## 点击添加金币的倍数
var added_money_mult:Big = Big.new(1)
## 点击添加的金币
var added_money:Big = Big.new(1, 12)

# {
#   10001（ID）: Item_Class（对象）
# }
var owned_items:Dictionary = {}
## 已购买的物品，基于数据的，保存存档用
var owned_items_dic:Dictionary = {}
## 同上
var owned_skills:Dictionary = {}
var owned_skills_dic:Dictionary = {}

## 金币文本，好像是因为toAA()比较慢写的，但是有没有用不知道
var coins_text:String = coins.toAA()

## 挂机时间，单位：秒
var time_distance:int :
	set(new_value):
		time_distance = int(Time.get_unix_time_from_system()) - new_value
		
		if time_distance >= MAX_TIME_DISTANCE:
			var temp_func:Callable = func():
				make_money(Big.new(auto_coin).multiply(MAX_TIME_DISTANCE))
			
			Uhd.new_ad_pop(temp_func, "双倍奖励", "光看广告，获得挂机双倍奖励", "mult_max")
		else:
			var temp_func:Callable = func():
				make_money(Big.new(auto_coin).multiply(time_distance))
			
			Uhd.new_ad_pop(temp_func, "双倍奖励", "观看广告，获得挂机双倍奖励", "mult_max")

# =========== 技能相关 ===========
## 目标物品ID
var target_item_id:int
## 物品数量
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

## 自动加钱
func auto_make_money() -> void:
	make_money(auto_coin)
	Uhd.new_tip_toolbar("+" + auto_coin.toAA())

## 加钱
func make_money(value) -> void:
	coins.plus(value)
	money_change.emit()

## 花钱
func spent_money(value) -> void:
	coins.minus(value)
	money_change.emit()

func get_item_by_id(id) -> Array:
	return owned_items[id]

## 重新计算升级收益
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

## 应用升级效果
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
				print(owned_items)
				print("id ", target_item_id)
				return
			# 获取受影响物品的总数
			item_count = owned_items[target_item_id]["owned"]
			# 先拿到受影响物品
			var target_item:Item_Class = owned_items[target_item_id]
			# 先判断目标是否有这个效果
			if not target_item.get(target_effect["Properties"]):
				print(target_effect)
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
			var multiplier = target_effect["Multiplier"]
			if effect[3] == "time":
				var timer = get_tree().create_timer(int(effect[2]))
				
				timer.timeout.connect(Callable(self, "click_timeout").bind(multiplier))
				main_scence.new_effect_pointer(multiplier, int(effect[2]))
				
				added_money = added_money.multiply(multiplier)
			else:
				added_money = added_money.multiply(multiplier)
		"reduce":
			print("减少钱")
			coins.minus(int(target_effect["Multiplier"]))
		"coins":
			print("增加钱")
			coins.plus(int(target_effect["Multiplier"]))
		"nothing":
			pass

## 点击金币除以XX，主要是有增加点击金币倍数的效果（炼金获得），但是效果是限时的
func click_timeout(multiplier) -> void:
	added_money.divide(multiplier)

## 读取效果文本，effect是正则
func read_effect(effect:String) -> PackedStringArray:
	var reg := RegEx.new()
	reg.compile("^(\\w+)\\[(\\d+)\\]\\[(\\w+)\\]\\[(\\w+)\\]\\[(\\d+(?:\\.\\d+)?)\\]$")
	var result := reg.search(effect).strings
	return result

## 如果点击确认兑换码
func yes_gifts(code:String) -> void:
	if code in used_codes:
		Uhd.new_message_popup("兑换结果", "此兑换码已经被使用了...")
	elif code in CODES:
		Uhd.new_message_popup("兑换结果", "兑换成功！获得 金币*1000000 ")
		get_gifts(Big.new(1000000))
		used_codes.append(code)
	else:
		Uhd.new_message_popup("兑换结果", "礼包码不存在..")

## 兑换码正确
func get_gifts(number:Big) -> void:
	make_money(number)

## 设置声音大小
func set_audio_size(value:float) -> void:
	AudioServer.set_bus_volume_db(background_audio, linear_to_db(value))

func _ready() -> void:
	money_change.connect(Callable(self, "update_coins_text"))
	money_change.connect(Callable(self, "change"))
	
	## 读取存档
	load_save()
	
	# 开立方(N/10^12).向下取整
#	chips_total = Big.new(all_coins).divide(Big.new(1, 10)).squareRoot().roundDown()
#	needed_total_coins = Big.new(1, 12).multiply(Big.new(chips_total).power(3))
	
	min_coins = Big.new(auto_coin).multiply(60)
	
	## 防止游戏无法进行
	if auto_coin.isLessThanOrEqualTo(0):
		auto_coin = Big.new(1)
	
	if added_money.isLessThanOrEqualTo(0):
		added_money = Big.new(1)
	
	if added_money_mult.isLessThanOrEqualTo(0):
		added_money_mult = Big.new(1)
	
	## 修改最后看广告的时间
	last_ad_time = await BjTime.get_time()
	
	## 如果已经过了一天，次数清零
	if await BjTime.over_a_day(last_ad_time):
		current_ad = 0

## 修改金币文本
func update_coins_text() -> void:
	coins_text = coins.toAA()

## 读档
func load_save() -> void:
	SaveAndLoad.load_save()
	set_audio_size(5.0)

## 存档
func save() -> bool:
	var new_save_dic:Dictionary = {}
	for i in owned_items.keys():
		new_save_dic[i] = owned_items[i].get_save_data()
	
	var new_skill_save_dic:Dictionary = {}
	for i in owned_skills.keys():
		new_skill_save_dic[i] = owned_skills[i].get_save_data()
	
	print(new_save_dic, new_skill_save_dic)
	var save_dic = {
		"skills": new_skill_save_dic,
		"items": new_save_dic,
		"coins": coins.get_save_data(),
		"auto_coin": auto_coin.get_save_data(),
		"added_money": added_money.get_save_data(),
		"time": Time.get_unix_time_from_system(),
		"all_coins": all_coins.get_save_data(),
		"chips": ChipsManager.chips.get_save_data(),
		"added_money_mult": added_money_mult.get_save_data(),
		"level": level,
		"used_codes": used_codes,
		"last_ad_time": last_ad_time,
		"current_ad": current_ad,
		"ver": VER,
		"first_game": first_game,
		"pot_bag": pot_bag,
		"not_added_skills": not_added_skills
	}
	print("save")
	
	SaveAndLoad.save(save_dic)
	return true

## 监听退出游戏并存档
func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		if save():
			get_tree().quit()

	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if save():
			get_tree().quit()

## 
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

## 移除未知节点
func remove_unknow_node() -> void:
	if is_instance_valid(unknow):
		unknow.queue_free()
		unknow = null

## 添加未知节点
func add_unknow_node() -> void:
	var new_node = UNKONW_NODE.instantiate()
	items.add_child(new_node)
	unknow = new_node

## 开始修改未知节点
func start():
	remove_unknow_node()
	
	for i in range(items.get_child_count()):
		var child = items.get_child(i)
		child.visible = i < level
	
#	for i in range(skills.get_child_count()):
#		var child = skills.get_child(i)
#		child.visible = i < level
	
	add_unknow_node()
