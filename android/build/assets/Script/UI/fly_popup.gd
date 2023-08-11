extends Control

var text:String = """
[center]你已经洞察了世间的一切。要飞升吗？
飞升后，你所拥有的一切重置为 [b][color=#FFE2B2]0[/color][/b] ，并获得 [b][color=#FFE2B2]{get_chip}[/color][/b] 天堂筹码。(不好意思技能树还没做)
并且，你的每秒点击金币永久 * 1.1 倍（可叠加）。
你需要 [b][color=#FFE2B2]{need_coins}[/color][/b] 金币。[/center]
"""

func _ready() -> void:
    %Set1.pressed.connect(Callable(self, "yes"))
    %Set2.pressed.connect(Callable(self, "no"))
    %Desc.text = text.format({"get_chip": ChipsManager.chips.toAA(), "need_coins": ChipsManager.coins_needed.toAA()})

func yes() -> void:
    if Global.coins.isLessThanOrEqualTo(ChipsManager.coins_needed):
        Uhd.new_message_popup("金币不足", "金币不足")
        queue_free()
    else:
        ChipsManager.yes_fly()
        queue_free()

func no() -> void:
    Uhd.hide_color()
    queue_free()
