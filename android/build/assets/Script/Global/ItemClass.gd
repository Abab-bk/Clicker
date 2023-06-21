extends RefCounted

class_name Item_Class

var id:int
var the_name:String
var desc:String
var img_path:String
var cost:Big
var base_cost:Big
var bonus_str:String = "0"
var bonus:Big :
	set(new_value):
		bonus = new_value
		bonus_str = new_value.toAA()
		Uhd.update_ui()

var owned:int = 0 :
	set(new_value):
		
		if not base_cost:
			return
		
		owned = new_value
		# 基础价格 * 1.15 的 该类建筑物现拥有的数目 次方
		# (base_cost) * (1.15 ^ owned)
		var temp1:Big = Big.new(1.15).power(owned)
		
		print(owned)
		print(base_cost.toString())
		print(temp1.toString())
		
		cost = Big.new(base_cost.multiply(temp1))
		
#		cost = Big.new(Big.new(1.15, owned - 0)) # -> 返回 1.15 的owed - 0 次幂

func update_info(Info:Dictionary) -> void:
	id = Info["id"]
	the_name = Info["name"]
	desc = Info["desc"]
	img_path = Info["img"]
	cost = Big.new(Info["cost"][0], Info["cost"][1])
	base_cost = Big.new(Info["cost"][0], Info["cost"][1])
	bonus = Big.new(Info["bonus"][0], Info["bonus"][1])
	Global.level_list.append(cost)

func check_load() -> void:
	if Global.owned_items_dic.has(id):
		load_form_save(Global.owned_items_dic[id])
		Global.owned_items[id] = self

func get_save_data() -> Dictionary:
	var new_dic:Dictionary = {
		"cost": cost.get_save_data(),
		"bonus": bonus.get_save_data(),
		"owned": owned,
	}
	return new_dic

func load_form_save(save:Dictionary) -> void:
	cost.load_form_save(save["cost"])
	bonus.load_form_save(save["bonus"])
	owned = save["owned"]

func try_to_buy(mouse_pos:Vector2) -> String:
	if Global.coins.isLessThan(cost):
		Uhd.new_tip("金币不足", Color.RED, mouse_pos)
		return str(owned)
	else:
		Global.spent_money(cost)
		Global.auto_coin.plus(bonus)
		Uhd.new_tip("-" + cost.toAA(), Color.WHITE, mouse_pos)
		owned += 1
		
		Global.owned_items[id] = self
		
		return str(owned)

