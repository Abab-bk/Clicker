extends Control

signal change_page_to_other
signal change_page_to_home

@onready var chip_progress: TextureProgressBar = $UI/VBox/ProgressBar
@onready var pointers: VBoxContainer = $UI/Pointer
@onready var timer: Timer = $Timer
@onready var main_item: Control = $Node2D/Mogu/Control
@onready var Main_Item_UI: Sprite2D = $Node2D/Mogu
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var items: VBoxContainer = $UI/Store/Control/Panel/VBox/Center2/VBox/Store/VBox/Scroll/Items
@onready var skills: VBoxContainer = $UI/Store/Control/Panel/VBox/Center2/VBox/Store/VBox/Scroll2/Skill

@onready var Store_Panel: NinePatchRect = $UI/Store/Control/Panel/VBox/Center2/VBox/Store

@onready var My_UI: CanvasLayer = $UI/My
@onready var Chart_UI: CanvasLayer = $UI/Chart
@onready var Sotre_UI: CanvasLayer = $UI/Store
@onready var Tower_UI: CanvasLayer = $UI/Battle
@onready var Sotre_Skill_UI: ScrollContainer = $UI/Store/Control/Panel/VBox/Center2/VBox/Store/VBox/Scroll2
@onready var Sotre_Item_UI: ScrollContainer = $UI/Store/Control/Panel/VBox/Center2/VBox/Store/VBox/Scroll

@onready var coin_audio: Array = [$Node2D/Mogu/audio1, $Node2D/Mogu/audio2, $Node2D/Mogu/audio3, $Node2D/Mogu/audio4, $Node2D/Mogu/audio5, $Node2D/Mogu/audio6, $Node2D/Mogu/audio7]

## 限时效果治时期
const EFFECT_POINTER := preload("res://Scence/UI/effect_pointer.tscn")
## 点击时弹出的物品
const clicked_icon := preload("res://Scence/clicked_icon.tscn")
const clicked_icon2 := preload("res://Scence/clicked_icon_2.tscn")
## 物品节点
const item_scence := preload("res://Scence/UI/item.tscn")
## 升级节点
const skill_scence := preload("res://Scence/UI/Skill.tscn")
## _ready后会同步为Global的同变量，Big类都是引用传递
var added_money:Big = Big.new(100)

## 页面枚举
enum PAGE {
	HOME,
	CHART,
	MY,
	STORE,
	ITEM,
	SKILL,
	TOWER,
}

#func _process(delta: float) -> void:
#	Store_Panel.custom_minimum_size.y = (ProjectSettings.get("display/window/size/viewport_height") * 0.73)
#
## 当购买一个升级，添加下一个对应升级
func add_next_skill(id:int) -> void:
	if Settings.Skills.data.has(id + 1):
		if Settings.Skills.data[id + 1]["last"] != 0:
			var new_skill_node = skill_scence.instantiate()
			new_skill_node.Skill.update_info(Settings.Skills.data[id + 1])
	#		skills.add_child(new_skill_node)
			skills.call_deferred("add_child", new_skill_node)

func _ready() -> void:
	Global.main_scence = self
	
	$UI/ToolBar/HBox/Home.pressed.connect(Callable(self, "change_page").bind(PAGE.HOME))
	$UI/ToolBar/HBox/Store.pressed.connect(Callable(self, "change_page").bind(PAGE.STORE))
	$UI/ToolBar/HBox/My.pressed.connect(Callable(self, "change_page").bind(PAGE.MY))
	$UI/ToolBar/HBox/Chart.pressed.connect(Callable(self, "change_page").bind(PAGE.CHART))
	$UI/ToolBar/HBox/Battle.pressed.connect(Callable(self, "change_page").bind(PAGE.TOWER))
	
	$UI/Store/Control/Panel/VBox/Center2/VBox/Bar/HBox/Item.pressed.connect(Callable(self, "change_page").bind(PAGE.ITEM))
	$UI/Store/Control/Panel/VBox/Center2/VBox/Bar/HBox/Skill.pressed.connect(Callable(self, "change_page").bind(PAGE.SKILL))
	
#	$UI/Store/Control/Panel/VBox/Center2/VBox/Store.custom_minimum_size.y = DisplayServer.    ProjectSettings.get("display/window/size/viewport_height") * 0.7
	
	timer.timeout.connect(Callable(self, "auto_add_money"))
	main_item.gui_input.connect(Callable(self, "on_click"))
	Global.money_change.connect(Callable(self, "update_ui"))
	
	added_money = Global.added_money
	
	for i in Settings.Items.data:
		var new_item_node = item_scence.instantiate()
		new_item_node.Item.update_info(Settings.Items.data[i])
#		items.add_child(new_item_node)
		items.call_deferred("add_child", new_item_node)
	
	# TODO: 按照可以被添加的升级数组添加
	if not Global.not_added_skills.is_empty():
		for i in Settings.Skills.data:
			if Global.not_added_skills.has(i):
				continue
			
			if Global.not_added_skills.has(i - 1):
				var new_skill_node = skill_scence.instantiate()
				new_skill_node.Skill.update_info(Settings.Skills.data[i])
			#	skills.add_child(new_skill_node)
				skills.call_deferred("add_child", new_skill_node)
				continue
			
			if Settings.Skills.data[i]["last"] == 0:
				var new_skill_node = skill_scence.instantiate()
				new_skill_node.Skill.update_info(Settings.Skills.data[i])
			#	skills.add_child(new_skill_node)
				skills.call_deferred("add_child", new_skill_node)
	else:
		for i in Settings.Skills.data:
			if Settings.Skills.data[i]["last"] == 0:
				var new_skill_node = skill_scence.instantiate()
				new_skill_node.Skill.update_info(Settings.Skills.data[i])
			#	skills.add_child(new_skill_node)
				skills.call_deferred("add_child", new_skill_node)
	
	Global.items = items
	Global.skills = skills
	change_page(PAGE.HOME)
	timer.start()
	Global.start()
	
	if Engine.has_singleton("PockADPlugin"):
		var singleton = Engine.get_singleton("PockADPlugin")
		singleton.preLoadFullScreenAD("Hello, PocketAD By BR")
	
	Global.main_ready.emit()

func new_effect_pointer(multiper:int, time:int) -> void:
	var new_pointer = EFFECT_POINTER.instantiate()
	new_pointer.multiper = multiper
	new_pointer.time = time
	pointers.add_child(new_pointer)

func change_page(page:int) -> void:
	Main_Item_UI.hide()
	My_UI.hide()
	Sotre_UI.hide()
	Sotre_Item_UI.hide()
	Sotre_Skill_UI.hide()
	Chart_UI.hide()
	Tower_UI.hide()
	
	Uhd.hide_ui()
	
	match page:
		PAGE.HOME:
			change_page_to_home.emit()
			Main_Item_UI.show()
			Uhd.show_ui()
		PAGE.STORE:
			change_page_to_other.emit()
			Sotre_Item_UI.show()
			Sotre_UI.show()
		PAGE.MY:
			change_page_to_other.emit()
			My_UI.show()
		PAGE.CHART:
			change_page_to_other.emit()
			Chart_UI.show()
		PAGE.ITEM:
			change_page_to_other.emit()
			Sotre_UI.show()
			Sotre_Skill_UI.hide()
			Sotre_Item_UI.show()
		PAGE.SKILL:
			change_page_to_other.emit()
			Sotre_UI.show()
			Sotre_Item_UI.hide()
			Sotre_Skill_UI.show()
		PAGE.TOWER:
			change_page_to_other.emit()
			Tower_UI.show()
			$UI/Battle/Pot.gen_item()

func auto_add_money() -> void:
	Global.auto_make_money()

func update_ui() -> void:
	Uhd.update_ui()

func clicked() -> void:
	Global.make_money(Big.new(added_money).multiply(Global.added_money_mult))
	
	if randi_range(1,2) == 1:
		var new_icon = clicked_icon.instantiate()
		new_icon.position = get_global_mouse_position()
		Uhd.add_child(new_icon)
	else:
		var new_icon = clicked_icon2.instantiate()
		new_icon.position = get_global_mouse_position()
		Uhd.add_child(new_icon)
	
	Uhd.new_tip("+" + added_money.toAA(), Color.WHITE, get_global_mouse_position())

func on_click(event:InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed == true:
		animation.play("on_click")
		coin_audio[randi_range(0, 6)].play()
		clicked()
