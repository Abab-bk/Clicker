extends Node2D

var main = preload("res://Scence/main.tscn")

func _ready() -> void:
	Uhd.hide()
	$UI/UI/End/Back.pressed.connect(func():
		$UI.hide()
		$AnimationPlayer.play("back")
		await $AnimationPlayer.animation_finished
		Uhd.show()
		get_tree().change_scene_to_packed(main)
		)

