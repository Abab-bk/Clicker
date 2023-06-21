extends TextureRect

@onready var coins_node = $CenterContainer/HBox/Coins
@onready var animation = $AnimationPlayer

const REDUCE_COINS = 1
const NO_COINS = 2

var total_character_count

func _ready() -> void:
	Global.money_change.connect(Callable(self, "update_self"))
	total_character_count = coins_node.get_total_character_count()

func update_self() -> void:
	coins_node.text = Global.coins_text

func play_animation(mode:int) -> void:
	match mode:
		REDUCE_COINS:
			animation.play("reduce")
		NO_COINS:
			animation.play("no")
