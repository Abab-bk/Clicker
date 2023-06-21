#============================================================
#    Event
#============================================================
# - author: zhangxuetu
# - datetime: 2023-03-20 23:43:30
# - version: 4.0
#============================================================
## 全局事件
##
## 与信号同的是，这个是作为全局进行连接调用，且ID可以是任意值
##[br]示例
##[codeblock]
##var id = Event.listen("测试", 
##    func(data, extra_data):
##        print("测试监听数据！ data = ", data)
##)
##[/codeblock]
##[br]
##[br]发送数据
##[codeblock]
##Event.send("测试", 123456)
##[/codeblock]
##[br]取消监听
##[codeblock]
##Event.cancel("enter_room", id)
##[/codeblock]
class_name Event


## 监听标识
enum {
	DEFAULT,	# 默认监听方式
	ONE_SHOT,	# 调用一次之后消失
	TIME,		# 时间结束后消失。需要传入 [float] 参数作为时间长度
	COUNTRE,	# 调用达到次数后消失。需要传入 [int] 参数作为调用次数
	CONDITION,	# 到达条件后监听消失。需要传入 [Callable] 参数。这个参数返回 [bool] 类型的值。这个在调用时进行判断，如果条件不符合则会消失
}

const ListenTypeMap : Dictionary = {
	DEFAULT: ListenExecutor_Default,
	ONE_SHOT: ListenExecutor_OneShot,
	TIME: ListenExecutor_Time,
	COUNTRE: ListenExecutor_Counter,
	CONDITION: ListenExecutor_Condition,
}


class ListenExecutorBase:
	var items : Array = []
	var callable : Callable
	
	func _init(items: Array, callable: Callable, param):
		self.callable = callable
		self.items = items
		items.append(self)
	
	func execute(data, extra_data):
		callable.call(data, extra_data)
	


class ListenExecutor_Default:
	extends ListenExecutorBase


class ListenExecutor_OneShot:
	extends ListenExecutorBase
	
	func execute(data, extra_data):
		callable.call()
		items.erase(self)
	


class ListenExecutor_Time:
	extends ListenExecutorBase
	
	func _init(items: Array, callable: Callable, param: float):
		super._init(items, callable, param)
		assert(param > 0, "时间不能少于 0！")
		Engine.get_main_loop().create_timer(param).timeout.connect(func():
			items.erase(self)
		)


class ListenExecutor_Counter:
	extends ListenExecutorBase
	
	var count : int = 0
	
	func _init(items: Array, callable: Callable, param: int):
		super._init(items, callable, param)
		assert(param > 0, "数量必须超过 0！")
		self.count = param
	
	func execute(data, extra_data):
		callable.call()
		count -= 1
		if count <= 0:
			items.erase(self)


class ListenExecutor_Condition:
	extends ListenExecutorBase
	
	var  condition : Callable
	
	func _init(items: Array, callable: Callable, param: Callable):
		super._init(items, callable, param)
		assert(param.is_valid(), "回调必须是有效的！")
		self.condition = param
	
	func execute(data, extra_data):
		if condition.call():
			callable.call()
		else:
			items.erase(self)



#============================================================
#  SetGet
#============================================================
# 获取事件数据
static func _get_data() -> Dictionary:
	const KEY = &"Event_get_data_dict"
	if not Engine.has_meta(KEY):
		Engine.set_meta(KEY, {})
	return Engine.get_meta(KEY)


## 获取这个组的监听的回调列表
static func get_group_list(group) -> Array[ListenExecutorBase] :
	var data = _get_data()
	var list : Array[ListenExecutorBase] 
	if data.has(group):
		list = data[group]
	else:
		list = []
		data[group] = list
	return list


## 监听一个组
##[br]
##[br][code]group[/code]  监听的组
##[br][code]callable[/code]  这个组的回调，这个方法需要有两个参数
##[br] - data [Variant] 类型的参数接收数据
##[br] - extra_data [Variant] 类型的参数接收额外附加数据
##[br][code]listen_flag[/code]  监听标识。监听方式
##[br][code]flag_params[/code]  监听标识所需参数。
##[br][code]return[/code]  返回连接的ID
static func listen(group, callable: Callable, listen_flag: int = DEFAULT, flag_params = null) -> int:
	var list : Array[ListenExecutorBase] = get_group_list(group)
	var id = callable.hash()
	
	# 监听类型
	assert(ListenTypeMap.has(listen_flag), "错误的连接标识！")
	
	# 创建这种类型监听
	ListenTypeMap[listen_flag].new(list, callable, flag_params)
	
	return id


##  发送一个事件消息
##[br]
##[br][code]group[/code] 发送到的组
##[br][code]data[/code]  数据
##[br][code]extra_data[/code]  额外的数据。可以发送唯一 ID 数据，进行消息的区分
static func send(group, data, extra_data = null) -> void:
	var list : Array[ListenExecutorBase] = get_group_list(group)
	for listen_data in list:
		listen_data.execute(data, extra_data)


##  取消监听
##[br]
##[br][code]group[/code]  监听的组
##[br][code]id[/code]  取消的回调ID
static func cancel(group, id) -> int:
	var list : Array[ListenExecutorBase] = get_group_list(group)
	var idx : int = -1
	for executor in list:
		idx += 1
		if executor.callable.hash() == id:
			list.remove_at(idx)
			return 1
	return 0


## 取消这个组的所有监听
##[br]
##[br][code]return[/code] 返回移除的数量
static func cancel_all(group) -> int:
	var list = get_group_list(group)
	var count = list.size()
	list.clear()
	return count

