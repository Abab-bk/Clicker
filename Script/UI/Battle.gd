extends CanvasLayer

@onready var Home_UI: Control = $Home
@onready var Pot_UI: Control = $Pot
@onready var Battle_UI: MarginContainer = $Margin

enum PAGE {
	HOME,
	GARDEN,
	BATTLE,
	POT,
}

func _ready() -> void:
	go_home()
	$Home/Back/Center/Scroll/VBox/Garden.pressed.connect(Callable(self, "change_page").bind(PAGE.GARDEN))
	$Home/Back/Center/Scroll/VBox/Pot.pressed.connect(Callable(self, "change_page").bind(PAGE.POT))

func go_home() -> void:
	change_page(PAGE.HOME)

func change_page(page) -> void:
	Battle_UI.hide()
	Pot_UI.hide()
	Home_UI.hide()
	
	match page:
		PAGE.HOME:
			Home_UI.show()
		PAGE.GARDEN:
			pass
		PAGE.POT:
			Pot_UI.update_cost()
			Pot_UI.gen_item()
			Pot_UI.show()
