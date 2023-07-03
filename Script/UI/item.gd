extends NinePatchRect

@onready var own_node:Label = $HBox/HBox/Vbox/HBox/Own
@onready var cost_node:Label = $HBox/Center/HBox/Buy/VBox/Cost
@onready var buy_btn: TextureButton = $HBox/Center/HBox/Buy

var popup = preload("res://Scence/UI/Popup.tscn")
var Item:Item_Class = Item_Class.new()

func try_to_buy() -> void:
	own_node.text = Item.try_to_buy(get_global_mouse_position())
	update_cost_ui()

func _ready() -> void:
	Item.update.connect(self.update_cost_ui)
	ChipsManager.flyOK.connect(self.update_self)
	Item.owned_change.connect(func():
		own_node.text = str(Item.owned)
		)
	$HBox/Center/HBox/Buy.pressed.connect(Callable(self, "try_to_buy"))
	$HBox/Center/HBox/Info.pressed.connect(Callable(self, "show_info"))
	Item.check_load()
	update_self()
	update_cost_ui()

func show_info() -> void:
	var new_popup = popup.instantiate()
	new_popup.img = Item.img_path
	new_popup.the_name = Item.the_name
	new_popup.desc = Item.desc
	new_popup.effect_desc = "[center]每秒 + [color=ffe2b2]" + Item.bonus_str + "[/color]金币[/center]"
	Uhd.show_color()
	Uhd.add_child(new_popup)

func update_cost_ui() -> void:
	cost_node.text = Item.cost.toAA()
	$HBox/HBox/Vbox/VBox/Earn.text = "[color=#FFE2B2]+" + Item.bonus_str + "/s" + "[/color]"

func update_buy_state() -> void:
	if Global.coins.isLessThan(Item.cost):
		buy_btn.disabled = true

func update_self() -> void:
	cost_node.text = Item.cost.toString()
	Item.bonus_str = Item.bonus.toAA()
	
	$HBox/HBox/Vbox/HBox/Name.text = Item.the_name
	$HBox/HBox/Vbox/VBox/Earn.text = "[color=#FFE2B2]+" + Item.bonus_str + "/s" + "[/color]"
	$HBox/HBox/Vbox/VBox/Desc.text = Item.desc
	$HBox/HBox/Container/Icon.texture = load("res://Asset/img/Character/" + Item.img_path)
	
	own_node.text = str(Item.owned)
