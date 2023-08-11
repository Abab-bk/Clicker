extends Node

## 天堂筹码改变时发出
signal chipsChange
## 忘了，好像没用了
signal workChips
## 飞升完毕发出
signal flyOK

var prestige:Big = Big.new(0)
# 还需要多少饼干可以获得下一个天堂筹码
var coins_needed:Big = Big.new(0):
    set(n):
        coins_needed = n

var benchmark:Big = Big.new(1, 12)
var chips:Big = Big.new(0)

func _ready() -> void:
    Global.money_change.connect(func():
        coins_needed = Big.new(benchmark).multiply(Big.new(chips).plus(1).power(3).minus(Big.new(chips).power(3)))
        )
    coins_needed = Big.new(benchmark).multiply(Big.new(chips).plus(1).power(3).minus(Big.new(chips).power(3)))

func get_chips() -> void:
    chips.plus(1)
    chipsChange.emit()

func yes_fly() -> void:
    get_tree().paused = true
    
    Global.owned_items_dic = {}
    Global.owned_items = {}
    Global.owned_skills = {}
    Global.owned_skills_dic = {}
    
    Global.coins = Big.new(0)
    Global.added_money = Big.new(1)
    Global.auto_coin = Big.new(1)
    Global.all_coins = Big.new(0)
    Global.min_coins = Big.new(0)
    Global.level = 1
    Global.skill_level = 1
    Global.skill_level_list = []
    Global.level_list = []
    Global.not_added_skills = []
    Global.pot_bag = {}
    Global.not_added_skills = []
    
    Global.added_money_mult.plus(0.1)
    
    Global.save()
    Uhd.hide_color()
    workChips.emit()
    flyOK.emit()
    get_tree().paused = false
    SaveAndLoad.load_save()
    
    get_tree().change_scene_to_packed(load("res://Scence/Game/heaven.tscn"))
    
