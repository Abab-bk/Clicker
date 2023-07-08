class_name Enemy extends RefCounted

signal die

var id
var name:String
var hp:Big = Big.new(0):
    set(n):
        hp = n
        if hp.isLessThanOrEqualTo(0):
            die.emit()

func reset() -> void:
    hp = Big.new(Settings.Enemy.data[id]["hp"])
