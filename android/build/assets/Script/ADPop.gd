extends Control

var if_not:Callable
var mode:String = "AD"
var title:String = "意外产物"
var desc:String = "炼金术士工作时的意外产物，要打开看看吗？\
    （看广告获得奖励）"

func _ready() -> void:
    %Set1.pressed.connect(Callable(self, "yes"))
    %Set2.pressed.connect(Callable(self, "no"))
    %Name.text = title
    %Desc.text = desc
    AdManager.reward_failed.connect(Callable(self, "ad_failed"))
    AdManager.reward_get.connect(Callable(self, "ad_get"))

func ad_failed() -> void:
    Uhd.new_message_popup("加载失败", "广告加载失败")
    queue_free()

func ad_get() -> void:
    if mode == "AD":
        match randi_range(1, 2):
            1:
                # + 金币
                var new_coins = Big.new(Global.min_coins).multiply(60)
                
                if new_coins.isLessThanOrEqualTo(800000):
                    new_coins = Big.new(800000)
                
                Uhd.new_message_popup("获得奖励", "金币 + " + new_coins.toAA())
                Global.coins.plus(new_coins)
            2:
                # + 点击获得金币
                Uhd.new_message_popup("获得奖励", "每秒钟点击金币*20" + "，持续 60 秒。")
                Global.apply_effect(Global.read_effect("click[60][time][efficiency][20]"))
                
    #			# + 物品
    #			for i in Settings.Items.data[randi_range(10001, 10020)]:
    #				Global.auto_coin.plus(i.bonus)
    #				Uhd.new_tip("-" + cost.toAA(), Color.WHITE, mouse_pos)
    #				owned += 1
    #
    #				Global.owned_items[id] = self
    #				Global.save()
        queue_free()
    elif mode == "mult_max":
        Global.make_money(Big.new(Global.auto_coin).multiply(Global.MAX_TIME_DISTANCE))
    elif mode == "mult":
        Global.make_money(Big.new(Global.auto_coin).multiply(Global.time_distance))

func yes() -> void:
    if AdManager.is_android():
        if AdManager.ad != null:
            AdManager.ShowRewardAD()

func no() -> void:
    if mode == "mult":
        if_not.call()
    if mode == "mult_max":
        if_not.call()
    queue_free()
