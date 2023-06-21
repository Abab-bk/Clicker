extends Node

class_name Skill_Class

var id:int
var the_name:String
var desc:String
var effect:String
var img_path:String
var cost:Big
var cost_str:String = "0"

func update_info(Info:Dictionary) -> void:
	id = Info["id"]
	the_name = Info["name"]
	desc = Info["desc"]
	img_path = Info["img"]
	cost = Big.new(Info["cost"][0], Info["cost"][1])
	effect = Info["effect"]
	cost_str = cost.toAA()

func try_to_buy(mouse_pos:Vector2) -> bool:
	if Global.coins.isLessThan(cost):
		Uhd.new_tip("金币不足", Color.RED, mouse_pos)
		return false
	else:
		# 先判断有没有目标物品
		Uhd.new_tip("-" + cost_str, Color.WHITE, mouse_pos)
		Global.spent_money(cost)
		cost.toAA()
		return true

func apply_effect() -> void:
	var effect_:PackedStringArray = Global.read_effect(effect)
	Global.apply_effect(effect_)
