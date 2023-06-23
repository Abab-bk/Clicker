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
	
	if orginal_data.has("ver"):
		Global.owned_skills_dic = orginal_data["skills"]
	
	if orginal_data.has("first_game"):
		Global.first_game = orginal_data["first_game"]
	
	Global.used_codes = orginal_data["used_codes"]
	Global.owned_items_dic = orginal_data["items"]
	Global.coins.load_form_save(orginal_data["coins"])
	Global.auto_coin.load_form_save(orginal_data["auto_coin"])
	Global.added_money.load_form_save(orginal_data["added_money"])
	Global.time_distance = int(orginal_data["time"])
	Global.level = orginal_data["level"]
	
	
