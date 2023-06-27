extends Control

var mode:String = "AD"

func _ready() -> void:
	%Set1.pressed.connect(Callable(self, "yes"))
	%Set2.pressed.connect(Callable(self, "no"))
	if mode == "AD":
#		%Img.texture = load("res://Asset/img/Thing/Made.png")
		%Name.text = "意外产物"
		%Desc.text = "炼金术士工作时的意外产物，要打开看看吗？\
		（看广告获得奖励）"
		AdManager.reward_failed.connect(Callable(self, "ad_failed"))
		AdManager.reward_skip.connect(Callable(self, "ad_skip"))
		AdManager.reward_get.connect(Callable(self, "ad_get"))
	else:
#		%Img.texture = load("res://Asset/img/Thing/Made.png")
		%Name.text = "飞升"
		%Desc.text = "你已经洞察了世间的一切。\
		要飞升吗？"

func ad_skip():
	Uhd.new_message_popup("广告被跳过", "广告被跳过，无法获得奖励")
	queue_free()

func ad_failed() -> void:
	Uhd.new_message_popup("加载失败", "广告加载失败")
	queue_free()

func ad_get() -> void:
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
			var new_coins = Big.new(Global.min_coins).divide(50)
			Uhd.new_message_popup("获得奖励", "每秒钟点击金币 + " + new_coins.toAA())
			Global.added_money.plus(new_coins)
			
#			# + 物品
#			for i in Settings.Items.data[randi_range(10001, 10020)]:
#				Global.auto_coin.plus(i.bonus)
#				Uhd.new_tip("-" + cost.toAA(), Color.WHITE, mouse_pos)
#				owned += 1
#
#				Global.owned_items[id] = self
#				Global.save()
	queue_free()

func yes() -> void:
	if mode == "AD":
		if AdManager.is_android():
			if AdManager.ad != null:
				AdManager.ShowRewardAD()
	else:
		fly()

func fly() -> void:
	pass

func no() -> void:
	queue_free()
