extends RefCounted

## 所有Item的类，包含Item的数据。
class_name Item_Class

signal update
signal owned_change

#var one_item_bonus:Big = Big.new(1)
#var now_level:float = 1.0:
#	set(n):
#		if not base_bonus:
#			return
#		one_item_bonus = Big.new(base_bonus).multiply(now_level)
#
#		# 减去原来收益
#		bonus.minus(one_item_bonus.multiply(owned))
#
#		# 重新计算一个物品收益
#		now_level = n
#		one_item_bonus = Big.new(base_bonus).multiply(now_level)
#		base_bonus = one_item_bonus
#
#		# 加上新收益
#		bonus.plus(Big.new(base_bonus).multiply(now_level))
var id:int
var the_name:String
var desc:String
var img_path:String
var cost:Big
var base_cost:Big
var bonus_str:String = "0":
    set(n):
        bonus_str = n
        update.emit()
var base_bonus:Big
var bonus:Big :
    set(new_value):
        bonus = new_value
        bonus_str = new_value.toAA()
#		Global.auto_coin.minus(Big.new(one_item_bonus).multiply(owned)).plus(Big.new(one_item_bonus).multiply(owned))
        Uhd.update_ui()

var owned:int = 0 :
    set(new_value):
        print(new_value)
        
        if not base_cost:
            return
        
        owned = new_value
        # 基础价格 * 1.15 的 该类建筑物现拥有的数目 次方
        # (base_cost) * (1.15 ^ owned)
        var temp1:Big = Big.new(1.15).power(owned)
        
        cost = Big.new(Big.new(base_cost).multiply(temp1))
        
        owned_change.emit()

func _init() -> void:
    ChipsManager.flyOK.connect(self.set_to_default)

func update_info(Info:Dictionary) -> void:
    id = Info["id"]
    the_name = Info["name"]
    desc = Info["desc"]
    img_path = Info["img"]
    cost = Big.new(Info["cost"][0], Info["cost"][1])
    base_cost = Big.new(Info["cost"][0], Info["cost"][1])
    bonus = Big.new(Info["bonus"][0], Info["bonus"][1])
    base_bonus = Big.new(Info["bonus"][0], Info["bonus"][1])
    
    Global.level_list.append(cost)

func set_to_default() -> void:
    var Info = Settings.Items.data[id]
    owned = 0
    id = Info["id"]
    the_name = Info["name"]
    desc = Info["desc"]
    img_path = Info["img"]
    cost = Big.new(Info["cost"][0], Info["cost"][1])
    base_cost = Big.new(Info["cost"][0], Info["cost"][1])
    bonus = Big.new(Info["bonus"][0], Info["bonus"][1])
    base_bonus = Big.new(Info["bonus"][0], Info["bonus"][1])
    Global.level_list.append(cost)

func check_load() -> void:
    if Global.owned_items_dic.has(id):
        load_form_save(Global.owned_items_dic[id])
        Global.owned_items[id] = self

func get_save_data() -> Dictionary:
    var new_dic:Dictionary = {
        "cost": cost.get_save_data(),
        "bonus": bonus.get_save_data(),
        "owned": owned,
    }
#	"now_level": now_level
    return new_dic

func load_form_save(save:Dictionary) -> void:
#	if save.has("now_level"):
#		now_level = save["now_level"]
    cost.load_form_save(save["cost"])
    bonus.load_form_save(save["bonus"])
    owned = save["owned"]

func try_to_buy(mouse_pos:Vector2) -> String:
    if Global.coins.isLessThan(cost):
        Uhd.new_tip("金币不足", Color.RED, mouse_pos)
        Global.save()
        return str(owned)
    else:
        Global.spent_money(cost)
        Global.auto_coin.plus(bonus)
        Uhd.new_tip("-" + cost.toAA(), Color.WHITE, mouse_pos)
        owned += 1
        
        Global.owned_items[id] = self
        Global.save()
        return str(owned)
    
