extends Node

signal logined
signal login_not
signal login_fail

var tap

func _init() -> void:
    print(Engine.get_singleton_list())
    if OS.get_name() == "Android" && Engine.has_singleton("FlowerTapSDK"):
        tap = Engine.get_singleton("FlowerTapSDK")
    else:
        print("无法初始化TapTapSDK")

func _ready() -> void:
    if tap != null:
        tap.logined.connect(func(): logined.emit())
        tap.loginNot.connect(func(): 
            login_not.emit()
            print("未登录")
            )
        tap.loginFail.connect(func(): login_fail.emit())

func is_logined() -> void:
    if tap != null:
        tap.isLogined()

func login() -> void:
    print("登录")
    tap.Login()
    #if tap != null:
     #   tap.Login()
