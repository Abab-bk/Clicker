extends Control

var img:String
var the_name:String
var desc:String
var effect:String

func _ready() -> void:
	%Cancel.pressed.connect(Callable(self, "queue_self"))
	update_self()

func queue_self() -> void:
	Uhd.hide_color()
	queue_free()

func update_self() -> void:
	%Name.text = the_name
	%Desc.text = desc
	%Effect.text = effect
	%Img.texture = load("res://Asset/img/Character/" + img)
