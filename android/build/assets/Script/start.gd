extends Control

@export var scene:String = "res://Scence/main.tscn"

var progress = []
var scene_load_status = 0

var played_anima:bool = false

func _ready() -> void:
	ResourceLoader.load_threaded_request(scene)
	Uhd.hide()
	$AnimationPlayer.play("come")
	await $AnimationPlayer.animation_finished
	$Back/Vbox.show()
	Uhd.show()
	played_anima = true

func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(scene,progress)
	$Back/Vbox/Bar.value = progress[0] * 100
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED and played_anima == true:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene))
