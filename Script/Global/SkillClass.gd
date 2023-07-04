extends Node

## 所有升级的类，包含升级的数据。
class_name Skill_Class

signal buyed
signal queue_self

var owned:bool = false :
	set(new_value):
		if new_value == true:
			owned = true
			queue_self.emit()

var id:int
var the_name:String
var desc:String
var effect:Array
var img_path:String
var cost:Big
var cost_str:String = "0"

func check_load() -> void:
	if Global.owned_skills_dic.has(id):
		load_form_save(Global.owned_skills_dic[id])
		Global.owned_skills[id] = self

func set_to_default() -> void:
	
	var Info = Settings.Skills.data[id]
	owned = false
	id = Info["id"]
	the_name = Info["name"]
	desc = Info["desc"]
	img_path = Info["img"]
	cost = Big.new(Info["cost"][0], Info["cost"][1])
	effect = Info["effect"]
	cost_str = cost.toAA()
	Global.skill_level_list.append(cost)

func get_save_data() -> Dictionary:
	var new_dic:Dictionary = {
		"cost": cost.get_save_data(),
		"owned": owned,
	}
	return new_dic

func load_form_save(save:Dictionary) -> void:
	cost.load_form_save(save["cost"])
	owned = save["owned"]

func update_info(Info:Dictionary) -> void:
	id = Info["id"]
	the_name = Info["name"]
	desc = Info["desc"]
	img_path = Info["img"]
	cost = Big.new(Info["cost"][0], Info["cost"][1])
	effect = Info["effect"]
	cost_str = cost.toAA()
	Global.skill_level_list.append(cost)

## 按下购买按钮触发的函数
func try_to_buy(mouse_pos:Vector2) -> bool:
	if Global.coins.isLessThan(cost):
		Uhd.new_tip("金币不足", Color.RED, mouse_pos)
		Global.save()
		return false
	else:
		Uhd.new_tip("-" + cost_str, Color.WHITE, mouse_pos)
		Global.spent_money(cost)
		buyed.emit(id)
		Global.not_added_skills.append(id)
		Global.owned_skills[id] = self
		owned = true
		return true

func apply_effect() -> void:
	for i in effect:
		var effect_:Array = Global.read_effect(i)
		Global.apply_effect(effect_)
