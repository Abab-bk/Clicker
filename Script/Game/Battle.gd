extends MarginContainer

@onready var health: TextureProgressBar = $VBox/Back/VBox/Enemy/MarginContainer/Health
@onready var enemy_name_label: Label = $VBox/Back/VBox/VBox/Info/Rect/VBoxContainer/EnemyName
@onready var time_label: Label = $VBox/Back/VBox/VBox/Info/Rect/VBoxContainer/Time
@onready var level_name: Label = $VBox/Back/VBox/VBox/Level/Rect/Level
@onready var eneny_img: TextureRect = $VBox/Back/VBox/Enemy/EnenyImg
@onready var timer: Timer = $Timer

var time:int = 0:
    set(n):
        time = n
        if time <= 0:
            real_timeout()

var current_damage:Big = EnemyManager.current_damage
var current_all_damage:Big = Big.new(0)
var current_level:Big = EnemyManager.current_level
var enemy_name:String = ""

func _ready() -> void:
    EnemyManager.die.connect(self.next_enemy)
    $VBox/Margin/Cancel.pressed.connect(func():
        $"..".change_page($"..".PAGE.HOME))
    EnemyManager.current_level = Big.new(1)    
    eneny_img.gui_input.connect(self.on_click)
    timer.one_shot = false
    timer.autostart = true
    timer.wait_time = 1
    time = 15
    timer.timeout.connect(self.timeout)
    reset()

func timeout() -> void:
    time -= 1

func real_timeout() -> void:
    time = 15
    reset()

## 切换下一个敌人
func next_enemy() -> void:
    level_name.text = "第 " + current_level.toAA() + " 层"
    enemy_name = Settings.Enemy.data[randi_range(50001, 50010)]["name"]
    enemy_name_label.text = enemy_name

func reset() -> void:
    health.value = 100
    current_all_damage = Big.new(0)
    update_ui()

func _process(delta: float) -> void:
    $VBox/Back/VBox/VBox/Info/Rect/VBoxContainer/Time.text = str(time)

## 更新UI
func update_ui() -> void:
    health.value = int(Big.new(EnemyManager.current_hp).minus(current_all_damage).multiply(0.1).toPrefix())
    print(health.value)

func on_click(event) -> void:
    if event is InputEventMouseButton and event.pressed == true:
#        animation.play("on_click")
        Global.main_scence.coin_audio[randi_range(0, 6)].play()
        clicked()

func clicked() -> void:
    EnemyManager.temp_hp.minus(current_damage)
    update_ui()
