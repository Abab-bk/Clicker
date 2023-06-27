extends Timer

func _ready() -> void:
	timeout.connect(Callable(self, "on_timeout"))
	wait_time = 5
	start()

func on_timeout() -> void:
	Global.save()
	
