#============================================================
#    State Node
#============================================================
# - author: zhangxuetu
# - datetime: 2022-12-01 12:48:31
# - version: 4.0
#============================================================
## 状态节点
##
##通过 [method add_state] 进行添加子状态，返回添加的状态节点可以继续进行添加下一层级的状态
##[br]通过 [method listen_enter] 等开头为 [code]listen[/code] 的方法进行监听状态的改变。然后通过
##[method trans_to_child] 方法进行切换状态
##[br]
##[br]示例。场景有个 state_root 名称的 [StateNode] 根节点，并向其添加如下几个状态：
##[codeblock]
##enum States {
##    IDLE,
##    MOVE,
##    JUMP,
##}
##[/codeblock]
##
##[br]添加状态
##[codeblock]
##var idle_state = state_root.add_state(States.IDLE)
##var move_state = state_root.add_state(States.MOVE)
##var jump_state = state_root.add_state(States.JUMP)
### 或者
##var state_list = state_root.add_multi_states(States.values())
##[/codeblock]
##
##[br]监听状态
##[codeblock]
##idle_state.listen_enter(func(data: Dictionary):
##    print("已进入 idle 状态：", data)
##)
##idle_state.listen_exit(func():
##    print("已退出 idle 状态：")
##)
##idle_state.listen_process(func(delta: float):
##    print("正在执行 idle 过程")
##)
## 
##[/codeblock]
##
##[br]启动或切换状态
##[codeblock]
### 切换到 move 状态
##idle_state.trans_to(States.MOVE)
### 或者 state_root 对子节点进行切换，是两个功能是等价的
##state_root.trans_to_child(State.Move)
##
### 默认启动 idle 状态
##idle_state.auto_start = true
##state_root.enter_state({})
### 或者直接启动和上面的是相同的
##state_root.enter_child_state(States.IDLE)
##[/codeblock]
class_name StateNode
extends Node


## 进入当前状态
signal entered_state(data: Dictionary)
## 执行线程
signal state_processed(delta: float)
## 退出当前状态
signal exited_state
## 子节点进入状态
signal child_state_entered(state_name, data: Dictionary)
## 子节点退出状态
signal child_state_exited(state_name)
## 状态发生切换。[code]previous[/code]上个状态名称，[code]current[/code]当前状态名，
##[code]data[/code]当前状态进入时传入的数据
signal child_state_changed(previous, current, data: Dictionary)

## 新增状态
signal newly_added_state(state_name)
## 移除状态
signal removed_state(state_name)


## 自动启动当前状态
@export
var auto_start : bool = false


# 初始化状态
var __init_state__ = self.tree_entered.connect(
	func():
		var p = self
		while p is StateNode:
			_root_state = p
			p = p.get_parent()
		
		self.ready.connect(func():
			set_physics_process(false)
			set_process(false)
			
			if _root_state == self:
				if auto_start:
					enter_state({})
		, Object.CONNECT_ONE_SHOT)
		
)

# 根节点状态
var _root_state : StateNode
# 父状态节点
var _parent_state : StateNode
# 名称应的状态节点
var _name_to_state_node : Dictionary = {}
# 节点对应的状态
var _state_node_to_name : Dictionary = {}
# ID 对应的断开这个 [Callable] 连接的 [Callable] 回调
var _id_callable : Dictionary = {}

# 最后一次进入状态时的数据
var _last_enter_data : Dictionary = {}
# 当前执行的子状态
var _current_child_state = null



#============================================================
#  SetGet
#============================================================
## 生成ID
func _register_id(callable: Callable) -> int:
	_id_callable[callable.hash()] = callable
	return callable.hash()

## 获取状态。通过枚举添加时使用这个进行获取会很方便。
func get_child_state_name(state_node: StateNode):
	return _state_node_to_name.get(state_node)

## 获取子级状态节点
func get_child_state_node(state_name) -> StateNode:
	return _name_to_state_node.get(state_name) as StateNode

## 是否存在有这个子状态
func has_child_state(state_name) -> bool:
	return _name_to_state_node.has(state_name)

## 获取子状态名列表
func get_child_state_name_list() -> Array:
	return _name_to_state_node.keys()

## 获取当前执行的子级状态名称
func get_current_child_state():
	return _current_child_state

## 获取当前运行的状态子节点
func get_current_child_state_node() -> StateNode:
	return get_child_state_node(_current_child_state) \
		if _current_child_state != null \
		else null

## 获取进入这个状态时的数据。如果是根状态节点，可以当做一个全局的数据
func get_last_data() -> Dictionary:
	return _last_enter_data

## 获取父状态
func get_parent_state() -> StateNode:
	return _parent_state

## 当前状态是否正在运行中
func is_running() -> bool:
	return (_root_state == self 
		or get_parent_state().get_current_child_state_node() == self
	)

## 子状态是否正在运行
func child_state_is_running(state_name: String) -> bool:
	return _current_child_state == state_name

## 获取根节点状态
func get_root_state_node() -> StateNode:
	return _root_state

## 获取当前状态名称
func get_state_name():
	if _root_state == self:
		return null
	return get_parent_state().get_child_state_name(self)

## 查找子状态节点
##[br]
##[br][code]state_name[/code]  状态名
##[br][code]from_parent[/code]  从这个状态开始。不传入默认为当前根节点
##[br][code]return[/code]  返回找到的状态节点
func find_state_node(state_name, from_parent: StateNode = null) -> StateNode:
	if from_parent == null:
		from_parent = _root_state
	if from_parent.has_child_state(state_name):
		return get_child_state_node(state_name)
	var state_node : StateNode
	for child_state_name in get_child_state_name_list():
		state_node = find_state_node(state_name, get_child_state_node(child_state_name))
		if state_node != null:
			return state_node
	return null


## 获取所有父节点的名称
func get_all_parent_state_name() -> Array:
	if self == _root_state:
		return []
	var list : Array = []
	var p = self
	while p != _root_state:
		list.append(p.get_parent_state().get_child_state_name(p))
		p = p.get_parent_state()
	list.reverse()
	return list


## 获取所有父节点
##[br]
##[br][b]注意：[/b] 不包含根节点
func get_all_parent_state_node() -> Array[StateNode]:
	if self == _root_state:
		return []
	var list : Array = []
	var p = self
	while p != null:
		list.append(p.get_parent_state())
		p = p.get_parent_state()
	list.reverse()
	return list



#============================================================
#  内置
#============================================================
func _physics_process(delta: float) -> void:
	self.state_processed.emit(delta)



#============================================================
#  自定义
#============================================================
## 注册状态
func register_state(state_name, state_node: StateNode) -> void:
	assert(not _name_to_state_node.has(state_name), "已经添加过 " + str(state_name) + " 状态")
	
	# 连接信号
	state_node.entered_state.connect( func(data):  self.child_state_entered.emit( state_name, data ) )
	state_node.exited_state.connect( func(): self.child_state_exited.emit( state_name ) )
	
	# 存储数据
	_name_to_state_node[state_name] = state_node
	_state_node_to_name[state_node] = state_name
	state_node._parent_state = self
	
	
	self.newly_added_state.emit(state_name)


## 添加状态
##[br]
##[br][code]state[/code]  状态名。可以是任意类型
##[br][code]state_node[/code]  指定的状态节点
##[br][code]return[/code]  返回添加的状态节点
func add_state(state_name, state_node: StateNode = null) -> StateNode:
	if state_node == null:
		state_node = StateNode.new()
	register_state(state_name, state_node)
	add_child(state_node, true)
	return state_node


## 添加多个状态节点
##[br]
##[br][code]list[/code]  状态名列表
##[br][code]return[/code]  返回对应状态节点列表
func add_multi_states(list: Array) -> Array[StateNode]:
	var nodes : Array[StateNode] = []
	for state in list:
		nodes.append(add_state(state))
	return nodes


## 移除状态
func remove_state(state_name) -> bool:
	if has_child_state(state_name):
		assert(_current_child_state != state_name, "当前状态正在运行！")
		var state_node : StateNode = get_child_state_node(state_name)
		_state_node_to_name.erase(state_node)
		_name_to_state_node.erase(state_name)
		self.removed_state.emit(state_name)
		return true
	return false


## 进入当前状态
func enter_state(data: Dictionary, enter_auto_state: bool = true) -> void:
	assert(self.is_inside_tree(), "状态还未添加到节点树中")
	
	if _root_state != self:
		_last_enter_data = data
	
	if enter_auto_state:
		# 获取当前状态控制的子节点
		for child in get_children():
			if child is StateNode and child.auto_start:
				# 存在有自动登录的子节点，则进行登录
				enter_child_state(get_child_state_name(child))
				break
	set_physics_process(true)
	set_process(true)
	self.entered_state.emit(data)


## 退出当前状态
func exit_state() -> void:
	assert(self.is_inside_tree(), "状态还未添加到节点树中")
	assert(_root_state != self, "根状态节点不能退出")
	assert(is_running(), "状态还未启动，不能退出状态")
	
	exit_child_state()
	set_physics_process(false)
	set_process(false)
	self.exited_state.emit()


## 进入子状态
func enter_child_state(state_name, data: Dictionary = {}, enter_auto_state : bool = true) -> void:
	assert(self.is_inside_tree(), "状态还未添加到节点树中")
	assert(_name_to_state_node.has(state_name), "没有这个状态")
	assert(state_name != _current_child_state, "已经在这个状态中，不能重复切换")
	assert(is_running(), "当前状态还未启动！")
	
	if _current_child_state:
		trans_to_child(state_name, data)
	
	else:
		_current_child_state = state_name
		get_current_child_state_node().enter_state(data, enter_auto_state)


## 退出子状态
func exit_child_state() -> void:
	if _current_child_state:
		get_current_child_state_node().exit_state()
		_current_child_state = null


## 当前子状态切换到另一种状态
func trans_to_child(state_name, data: Dictionary = {}, enter_auto_state: bool = true) -> void:
	assert(self.is_inside_tree(), "此状态还未添加到树中")
	assert(is_running(), "当前状态还未启动")
	assert(_current_child_state != null, "子状态机还未启动")
	assert(_name_to_state_node.has(state_name), "没有这个状态")
	assert(state_name != _current_child_state, "已经在这个状态中，不能重复切换")
	
	# 退出上次状态
	var previous_state = _current_child_state
	get_current_child_state_node().exit_state()
	# 进入当前状态
	_current_child_state = state_name
	get_current_child_state_node().enter_state(data, enter_auto_state)
	
	self.child_state_changed.emit( previous_state, state_name, data )


## 切换到其他状态中
func trans_to(state, data: Dictionary = {}) -> void:
	assert(_root_state != self, "当前是根状态，不能切换到其他状态")
	assert(get_parent_state().get_current_child_state_node() == self, "当前状态没有运行，不能切换这个状态")
	assert(is_running(), "当前状态还未启动")
	
	get_parent_state().trans_to_child(state, data)


## 全局切换状态
func global_trans_to(state_name, data: Dictionary) -> void:
	var state_node = find_state_node(state_name)
	assert(state_node, "没有这个状态")
	
	var list = state_node.get_all_parent_state_node()
	list.reverse()
	# 逐个登入
	var curr_state_name = state_name
	for parent_state_node in list:
		parent_state_node.enter_child_state(curr_state_name, {}, false)
		curr_state_name = parent_state_node.get_state_name()
	


#============================================================
#  监听状态
#============================================================
##  监听登录状态
##[br]
##[br][code]callable[/code]  登录回调方法。这个方法需要有一个 [Dictionary] 参数接收登录数据
##[br][code]return[/code]  返回连接的ID
func listen_enter(callable: Callable) -> int:
	if self.entered_state.is_connected(callable):
		printerr("已经监听过这个方法")
		return -1
	self.entered_state.connect(callable)
	return _register_id(func(): self.entered_state.disconnect(callable))


##  监听退出状态
##[br]
##[br][code]callable[/code]  登录回调方法。这个回调方法没有参数
##[br][code]return[/code]  返回连接的ID
func listen_exit(callable: Callable) -> int:
	if self.exited_state.is_connected(callable):
		printerr("已经监听过这个方法")
		return -1
	self.exited_state.connect(callable)
	return _register_id(func(): self.exited_state.disconnect(callable))


##  监听状态线程
##[br]
##[br][code]callable[/code]  回调方法。如果返回状态名，则自动切换到对应状态。这个回调需要有一个
##[float] 类型的参数，用于接收游戏执行的每帧时间
##[br][code]return[/code]  返回连接的ID
func listen_process(callable: Callable) -> int:
	if self.state_processed.is_connected(callable):
		printerr("已经监听过这个方法")
		return -1
	self.state_processed.connect(callable)
	return _register_id(func(): self.state_processed.disconnect(callable))


## 断开监听
func disconnect_listen(id: int) -> bool:
	if _id_callable.has(id):
		Callable(_id_callable[id]).call()	# 调用“断开这个 ID 的 Callable 连接”的 Callable 回调
		_id_callable.erase(id)
		return true
	return false


