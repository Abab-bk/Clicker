extends Control

@export var scene:String = "res://Scence/main.tscn"

signal loaded

var progress = []
var scene_load_status = 0

var played_anima:bool = false

func _ready() -> void:
    loaded.connect(self.load_ok)
    Tap.logined.connect(self.login_ok)
    Tap.login_fail.connect(self.login_fail)
#    if Tap.tap:
#        print("初始化TAPTAP")
#        Tap.tap.initSDK()    
    $Login.pressed.connect(self.login)
    Uhd.hide()
    $AnimationPlayer.play("come")
    await $AnimationPlayer.animation_finished
    $Back/Vbox.show()
    ResourceLoader.load_threaded_request(scene)
    played_anima = true

func load_ok() -> void:
    print("加载完毕")
    # Tap.is_logined()

func login() -> void:
    # 开始登录
    print("开始登录")
    Tap.login()

func login_ok() -> void:
    # 进入游戏
    enter_game()

func login_fail() -> void:
    Uhd.new_message_popup("登录失败", "登录失败")

func enter_game() -> void:
    print("进入游戏")
    Uhd.show()
    get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene))

func _process(delta: float) -> void:
    scene_load_status = ResourceLoader.load_threaded_get_status(scene,progress)
    $Back/Vbox/Bar.value = progress[0] * 100
    if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED and played_anima == true:
        enter_game()
#        loaded.emit()
#        set_process(false)
        
        
