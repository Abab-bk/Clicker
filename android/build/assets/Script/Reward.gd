extends Node

const CHEST_NODE := preload("res://Scence/chest.tscn")

@onready var timer: Timer = $Timer


func _ready() -> void:
    timer.wait_time = 1
    timer.one_shot = true
    timer.timeout.connect(Callable(self, "show_a_reward"))
    AdManager.reward_get.connect(Callable(self, "done"))
    timer.start()

func show_a_reward() -> void:
    var n = CHEST_NODE.instantiate()
    n.done.connect(Callable(self, "done"))
    Uhd.add_child(n)

func done() -> void:
    if is_connected("done", Callable(self, "done")):
        disconnect("done", Callable(self, "done"))
    timer.wait_time = 60
    timer.start()
