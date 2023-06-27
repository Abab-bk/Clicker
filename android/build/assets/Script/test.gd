extends Control

var new_num:Big
var new_num2:Big
var n_value

enum FLAG {
	POWER,
	PLUS,
	DIVIDE,
	MINUS,
}

func change_text(new) -> void:
	new_num = Big.new(int($LineEdit.text), int($LineEdit3.text))
	new_num2 = Big.new(int($LineEdit2.text), int($LineEdit4.text))
	$label1.text = new_num.toString()
	$Label2.text = new_num2.toString()

func _ready() -> void:
	$Button.pressed.connect(Callable(self, "output").bind(FLAG.PLUS, new_num, new_num2))
	$Button2.pressed.connect(Callable(self, "output").bind(FLAG.POWER, new_num, new_num2))
	$Button3.pressed.connect(Callable(self, "output").bind(FLAG.DIVIDE, new_num, new_num2))
	$LineEdit.text_changed.connect(Callable(self, "change_text"))
	$LineEdit2.text_changed.connect(Callable(self, "change_text"))
	$LineEdit3.text_changed.connect(Callable(self, "change_text"))
	$LineEdit4.text_changed.connect(Callable(self, "change_text"))

func output(flag, target:Big, value):
	var result:Big = Big.new(target)
	
	match output:
		FLAG.PLUS:
			result.plus(value)
		FLAG.DIVIDE:
			result.divide(value)
		FLAG.POWER:
			result.power(value)
		FLAG.MINUS:
			result.minus(value)
	
	$output.text = result.toString()

