extends NinePatchRect

var multiper:int
var time:int

func _ready() -> void:
	$Timer.start()
	$Timer.timeout.connect(func():
		time -= 1
		if time <= 0:
			queue_free()
		$HBox/Time.text = str(time)
		)
	$HBox/Time.text = str(time)
	$HBox/HBox/Multiper.text = str(multiper)
