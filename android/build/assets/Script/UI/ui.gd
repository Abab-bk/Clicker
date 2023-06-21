extends CanvasLayer

@onready var coins = $UI/Black/VBox/Title
@onready var bonus = $UI/Black/VBox/Bonus

const tip_text := preload("res://Scence/UI/TipText.tscn")
const message_pop := preload("res://Scence/UI/MessagePopup.tscn")
const gift_pop := preload("res://Scence/UI/GiftPop.tscn")

var format_string:String
var coin_unit:String = ""

func _ready() -> void:
	$ColorRect.hide()
	Global.money_change.connect(Callable(self, "update_ui"))
	update_ui()

func new_message_popup(Title:String, Desc:String) -> void:
	var new_pop = message_pop.instantiate()
	new_pop.title = Title
	new_pop.desc = Desc
	show_color()
	add_child(new_pop)

func update_ui() -> void:
	coins.update_self()
	bonus.text = Global.auto_coin.toString() + " / s"

func new_tip(text:String, color:Color = Color("ffe2b2"), pos:Vector2 = (coins.global_position + Vector2(coins.total_character_count*50, 0))) -> void:
	var new_tip_text = tip_text.instantiate()
	new_tip_text.set("theme_override_colors/font_color", color)
	new_tip_text.text = text
	
	new_tip_text.global_position = pos
	
	add_child(new_tip_text)

func new_tip_toolbar(text:String, color:Color = Color("ffe2b2"), pos:Vector2 = (coins.global_position + Vector2(coins.total_character_count*50, 0))) -> void:
	var new_tip_text = tip_text.instantiate()
	new_tip_text.set("theme_override_colors/font_color", color)
	new_tip_text.text = text
	
	new_tip_text.global_position = pos
	
	$UI.add_child(new_tip_text)

func new_gifts() -> void:
	var new_gift_pop = gift_pop.instantiate()
	show_color()
	add_child(new_gift_pop)

func show_color() -> void:
	$ColorRect.show()

func hide_color() -> void:
	$ColorRect.hide()

func hide_ui() -> void:
	$UI.hide()

func show_ui() -> void:
	$UI.show()
