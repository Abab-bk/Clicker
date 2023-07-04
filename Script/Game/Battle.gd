extends MarginContainer

@onready var health: TextureProgressBar = $VBox/Back/VBox/Enemy/MarginContainer/Health
@onready var enemy_name: Label = $VBox/Back/VBox/VBox/Info/Rect/EnemyName
@onready var level_name: Label = $VBox/Back/VBox/VBox/Level/Rect/Lvel

var current_level:Big = Big.new(1)

func _ready() -> void:
	pass

## 切换下一个敌人
func next_enemy() -> void:
	level_name.text = "第 " + current_level.toAA() + " 层"
	enemy_name.name = Settings.Enemy.data[randi_range(50001, 50010)]

## 更新UI
func update_ui() -> void:
	health
	pass
