extends CanvasLayer

@onready var coins: Label = $Control/Panel/Scroll/Items/Coins
@onready var owned: Label = $Control/Panel/Scroll/Items/Owned

func _ready() -> void:
	visibility_changed.connect(Callable(self, "update_self"))

func update_self() -> void:
	coins.text = Global.coins.toAA()
	if not is_instance_valid(Global.owned_items):
		owned.text = "暂无"
		return
	owned.text = str(Global.owned_items)
	
