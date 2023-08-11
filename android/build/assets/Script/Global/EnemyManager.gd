extends Node

signal die

var current_damage:Big = Big.new(1)
var temp_hp:Big = Big.new(0):
    set(n):
        temp_hp = n
        if temp_hp.isLessThanOrEqualTo(0):
            die.emit()

var current_hp:Big = Big.new(0):
    set(n):
        current_hp = n
        reset()

var current_level:Big = Big.new(0):
    set(n):
        current_level = n
        if current_level.isLargerThanOrEqualTo(140):
            # 向下取整{10 * (139 + 1.5^139 * 1.1 ^ level - 140) * [isBoss * 10]}
            current_hp = Big.new(1.5).power(139).multiply(Big.new(1.1).power(Big.new(current_level).minus(140))).plus(139).multiply(10).roundDown()
        # 向下取整{10 * (level - 1 + 1.55 ^ level - 1) * [isBoss * 10]}
        else:
            current_hp = Big.new(current_level).minus(1).plus(1.5).power(Big.new(current_level).minus(1)).multiply(10).roundDown()

func reset() -> void:
    temp_hp = Big.new(current_hp)
