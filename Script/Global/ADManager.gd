extends Node

var ad

signal reward_get
signal reward_failed
signal reward_closed
signal reward_skip

func _ready() -> void:
	if ad != null:
		ad.adReady.connect(Callable(self, "adReady"))
		ad.RewardGet.connect(Callable(self, "RewardGet"))
		ad.RewardClosed.connect(Callable(self, "RewardClosed"))
		ad.RewardFailed.connect(Callable(self, "RewardFailed"))
		ad.RewardSkip.connect(Callable(self, "RewardSkip"))
		ad.InitAD.connect(Callable(self, "InitAD"))

func is_android() -> bool:
	if OS.get_name() == "Android" && Engine.has_singleton("RealPocket"):
		return true
	else:
		return false

func InitAD():
	print("广告初始化成功")

func _init() -> void:
	if OS.get_name() == "Android" && Engine.has_singleton("RealPocket"):
		ad = Engine.get_singleton("RealPocket")
	else:
		print("无法初始化广告")

func adReady() -> void:
	if ad != null:
		Uhd.new_message_popup("广告", "准备完毕")

func ShowRewardAD(id:String = "57075") -> void:
	if ad != null:
		print("点击广告")
		ad.ShowRewardVideoAd(id)

func RewardSkip():
	if ad != null:
		reward_skip.emit()

func RewardClosed():
	if ad != null:
		reward_closed.emit()

func RewardGet():
	if ad != null:
		reward_get.emit()

func RewardFailed():
	if ad != null:
		reward_failed.emit()
