extends VBoxContainer

@onready var progress_bar: TextureProgressBar = $ProgressBar
@onready var need_coins_label: Label = $ProgressBar/Label
@onready var chips_label: Label = $HBox/Label

var progress:int

func _ready() -> void:
	ChipsManager.chipsChange.connect(Callable(self, "update"))
	progress_bar.value_changed.connect(Callable(self, "is_fill"))
	$ProgressBar/Button.pressed.connect(Callable(Uhd, "fly"))
	
	Global.money_change.connect(func():
		need_coins_label.text = "距离下一个天堂筹码：" + Big.new(Global.coins).minus(ChipsManager.coins_needed).toAA()
		
		# 设置进度条，进度 == 当前金币/所需要的金币 * 100%
		progress_bar.value = int(Big.new(Global.coins).divide(ChipsManager.coins_needed).multiply(0.1).toPrefix())
		)
	
	need_coins_label.text = "距离下一个天堂筹码：0"
	chips_label.text = ChipsManager.chips.toAA()

func is_fill(value:float) -> void:
	if value == progress_bar.max_value:
		ChipsManager.get_chips()
		progress_bar.value = 0

func update() -> void:
	chips_label.text = ChipsManager.chips.toAA()

