extends CanvasLayer

func _ready() -> void:
	$Control/Panel/Margin/VBox/Block/HBox/Del.pressed.connect(Callable(self, "del_save"))
	$Control/Panel/Margin/VBox/Block/HBox/Gift.pressed.connect(Callable(self, "gifts"))
	$Control/Panel/Margin/VBox/Block2/HBox/HSlider.value_changed.connect(Callable(self, "set_audio"))

func set_audio(value:float) -> void:
	Global.set_audio_size(value)

func del_save() -> void:
	if not FileAccess.file_exists(SaveAndLoad.save_path):
		Uhd.new_message_popup("文件不存在", "请尝试退出游戏重新进入再次删除存档。")
		return
	DirAccess.remove_absolute(SaveAndLoad.save_path)
	Uhd.new_message_popup("删除成功！", "按下按钮继续。")
	get_tree().quit()

func gifts() -> void:
	Uhd.new_gifts()
