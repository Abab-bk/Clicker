extends TextureButton

signal done

var pos_ary:Array = [Vector2(845, 454), Vector2(174, 1300), Vector2(953,1399), Vector2(212, 438)]

func _ready() -> void:
	pressed.connect(Callable(self, "open_info"))
	
	AdManager.reward_get.connect(func ():
		if self:
			queue_free())
	
	global_position = pos_ary[randi_range(0, 3)]
	
	$Timer.timeout.connect(func():
		done.emit()
		queue_free())
	
	Global.main_ready.connect(Callable(self, "connect_"))

func connect_():
	Global.main_scence.change_page_to_home.connect(func():
		show())
	Global.main_scence.change_page_to_other.connect(func():
		hide())

func open_info():
	Uhd.new_ad_pop()
