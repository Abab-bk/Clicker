extends NinePatchRect

var Skill:Skill_Class = Skill_Class.new()

func queue_self() -> void:
	queue_free()

func try_to_buy() -> void:
	if not Skill.try_to_buy(get_global_mouse_position()):
		return
	
	Skill.apply_effect()
	Global.save()

func update_cost_ui() -> void:
	$HBox/Center/HBox/Buy/VBox/Cost.text = Skill.cost_str

func _ready() -> void:
	update_self()
	Skill.queue_self.connect(Callable(self, "queue_self"))
	Skill.check_load()
	Skill.buyed.connect(Callable(Global.main_scence, "add_next_skill"))
	$HBox/Center/HBox/Buy.pressed.connect(Callable(self, "try_to_buy"))
	$HBox/Center/HBox/Info.pressed.connect(Callable(self, "show_info"))

func show_info() -> void:
	var popup = load("res://Scence/UI/Popup.tscn")
	var new_popup = popup.instantiate()
	new_popup.the_name = Skill.the_name
#	new_popup.desc = Skill.desc
	new_popup.effect_desc = Skill.desc
	new_popup.img = Skill.img_path
	Uhd.show_color()
	Uhd.add_child(new_popup)

func update_self() -> void:
	$HBox/HBox/Vbox/Name.text = Skill.the_name
	$HBox/HBox/Vbox/Desc.text = Skill.desc
	update_cost_ui()
	$HBox/HBox/Container/Icon.texture = load("res://Asset/img/Character/" + Skill.img_path)
