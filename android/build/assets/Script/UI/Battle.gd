extends CanvasLayer

@onready var Home_UI: Control = $Home
@onready var Pot_UI: Control = $Pot

enum PAGE {
    HOME,
    POT,
}

func _ready() -> void:
    go_home()
    $Home/Back/Center/Scroll/VBox/Pot.pressed.connect(Callable(self, "change_page").bind(PAGE.POT))

func go_home() -> void:
    change_page(PAGE.HOME)

func change_page(page) -> void:
    Pot_UI.hide()
    Home_UI.hide()
    
    match page:
        PAGE.HOME:
            Home_UI.show()
        PAGE.POT:
            Pot_UI.update_cost()
            Pot_UI.gen_item()
            Pot_UI.show()
