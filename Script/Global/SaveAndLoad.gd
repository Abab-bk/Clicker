extends Node

var save_path:String = "user://save.save"

func save(data:Dictionary) -> void:
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data, true)
	file.close()

func load_save() -> void:
	if not FileAccess.file_exists(save_path):
		return
	
	var file = FileAccess.open(save_path, FileAccess.READ)
	# 拿到了原始数据
	var orginal_data:Dictionary = file.get_var(true)
	file.close()
	
	Global.used_codes = orginal_data["used_codes"]
	Global.owned_items_dic = orginal_data["items"]
	Global.coins.load_form_save(orginal_data["coins"])
	Global.auto_coin.load_form_save(orginal_data["auto_coin"])
	Global.added_money.load_form_save(orginal_data["added_money"])
	Global.time_distance = int(orginal_data["time"])
	Global.level = orginal_data["level"]
	
	if orginal_data.has("ver"):
		Global.owned_skills_dic = orginal_data["skills"]
		if orginal_data["ver"] < 5:
			print("版本过低，重新计算收益")
			Global.rework_skill()
		if orginal_data["ver"] < 7:
			# 转换存档
			for id in orginal_data["skills"]:
				Global.not_added_skills.append(id)
	
	if orginal_data.has("last_ad_time"):
		Global.last_ad_time = orginal_data["last_ad_time"]
	if orginal_data.has("current_ad"):
		Global.current_ad = orginal_data["current_ad"]
	
	if orginal_data.has("all_coins"):
		Global.all_coins.load_form_save(orginal_data["all_coins"])
	if orginal_data.has("chips"):
		ChipsManager.chips.load_form_save(orginal_data["chips"])
	if orginal_data.has("added_money_mult"):
		Global.added_money_mult.load_form_save(orginal_data["added_money_mult"])
	
	if orginal_data.has("first_game"):
		Global.first_game = orginal_data["first_game"]
	
	if orginal_data.has("pot_bag"):
		Global.pot_bag = orginal_data["pot_bag"]
	
	if orginal_data.has("not_added_skills"):
		Global.not_added_skills = orginal_data["not_added_skills"]
	
