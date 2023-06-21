extends Node

const event_panel := preload("res://Scence/UI/EventPop.tscn")

func new_event(event_id:int = 30001) -> void:
	var new_event_pop = event_panel.instantiate()
	Global.main_scence.add_child(new_event_pop)
	

func action_event() -> void:
	pass

func _ready() -> void:
	Global.money_change.connect(Callable(self, "action_event"))

