#============================================================
#    Node Db
#============================================================
# - author: zhangxuetu
# - datetime: 2023-03-07 12:56:42
# - version: 4.x
#============================================================
## 场景节点中的对象进行记录
##
##用于方便获取对应类型的节点
class_name NodeDb
extends Node


## 新的节点
##[br]
##[br][code]node[/code]  新增的节点
##[br][code]type[/code]  节点类型。比如：[code]Node[/code]，[code]Node2D[/code]
##类值，这个值是类名是类值，比如 [code]type[/code] 信号参数的值为 [Node]，即 [code]type == Node[/code]，
## [code]type!="Node"[/code] 或者为自定义脚本类资源对象
signal newly_node(node, type)
## 移除掉的节点
##[br]
##[br][code]_class[/code]  移除的节点
##[br][code]return[/code]  节点类型
signal removed_node(node, type)


## 扫描的节点
@export
var root : Node :
	set(v):
		root = v
		root.child_entered_tree.connect(_record_child_data)
		root.child_exiting_tree.connect(_remove_child_data)
@export
var record_all_child : bool = true


# 这个脚本类的继承链数据
var _script_extends_link_map : Dictionary =  DataUtil.get_meta_dict_data("NodeDb_memeber_script_extends_link_map")
# 类对应的节点列表
var _class_to_nodes_map : Dictionary = {}
# 名称对应的点列表
var _name_to_nodes_map : Dictionary = {}
# 是否正在退出
var _program_is_exiting : bool = false


#============================================================
#  SetGet
#============================================================
func _get_id(data):
	return hash(data)

func get_nodes_by_class(_class) -> Array[Node]:
	var id = _get_id(_class)
	return _class_to_nodes_map.get(id, Array([], TYPE_OBJECT, "Node", null))

func get_nodes_by_name(_name: StringName) -> Array[Node]:
	return _name_to_nodes_map.get(_name, Array([], TYPE_OBJECT, "Node", null))

func get_first_node_by_class(_class) -> Node:
	var list = get_nodes_by_class(_class)
	if list.size() > 0:
		return list[0]
	return null

func get_first_node_by_name(_name: StringName) -> Node:
	var list = get_nodes_by_name(_name)
	if list.size() > 0:
		return list[0]
	return null


#============================================================
#  内置
#============================================================
func _ready():
	get_tree().root.close_requested.connect(func():
		self._program_is_exiting = true
	)


#============================================================
#  自定义
#============================================================
func _record_child_data(node: Node) -> void:
	if not is_instance_valid(node):
		return
	if node.tree_exiting.is_connected(self._remove_child_data):
		return
	
	node.tree_exiting.connect(self._remove_child_data.bind(node))
	if record_all_child:
		node.child_entered_tree.connect(self._record_child_data)
		node.child_exiting_tree.connect(self._remove_child_data)
	
	# 节点类型及父类型
	var _classes : Array = []
	var script : GDScript = node.get_script()
	if script != null:
		_classes = DataUtil.get_value_or_set(_script_extends_link_map, script, func():
			var list = ScriptUtil.get_extends_link(script)
			return Array(list).map(func(path): return load(path))
		)
	
	var clist : Array = ScriptUtil.get_extends_link_base(node.get_class())
	for c in clist:
		var base_class = ScriptUtil.get_built_in_class(c)
		_classes.append(base_class)
	
	# 这个类型的节点列表
	for _class in _classes:
		var id = _get_id(_class)
		var ctn_list = DataUtil.get_value_or_set(_class_to_nodes_map, id, func(): return Array([], TYPE_OBJECT, "Node", null))
		ctn_list.append(node)
		self.newly_node.emit(node, _class)
	
	# 这个名称的节点列表
	var ctn_list : Array = DataUtil.get_value_or_set(_name_to_nodes_map, node.name, func(): return Array([], TYPE_OBJECT, "Node", null))
	ctn_list.append(node)
	
	# 重命名时
	var last_list : Array = [ctn_list]
	node.renamed.connect(func():
		last_list[0].erase(node)
		last_list[0] = DataUtil.get_value_or_set(_name_to_nodes_map, node.name, func(): return Array([], TYPE_OBJECT, "Node", null))
	)


func _remove_child_data(node: Node) -> void:
	if _program_is_exiting or not is_instance_valid(self):
		return
	
	if record_all_child:
		node.tree_exiting.disconnect(self._remove_child_data)
		if node.child_entered_tree.is_connected(self._record_child_data):
			node.child_entered_tree.disconnect(self._record_child_data)
			node.child_exiting_tree.disconnect(self._remove_child_data)
	
	# 节点类型及父类型
	var _classes : Array = []
	var script = node.get_script()
	if script != null:
		_classes = DataUtil.get_value_or_set(_script_extends_link_map, script, func():
			var list = ScriptUtil.get_extends_link(script)
			return Array(list).map(func(path): return load(path))
		)
	
	# 这个类型的节点列表
	for _class in _classes:
		var id = _get_id(_class)
		var ctn_list = DataUtil.get_value_or_set(_class_to_nodes_map, id, func(): return [])
		ctn_list.append(node)
		self.newly_node.emit(node, _class)
	
	# 这个类型的节点列表
	for _class in _classes:
		var id = _get_id(_class)
		var ctn_list = DataUtil.get_value_or_set(_class_to_nodes_map, id, func(): return [])
		ctn_list.erase(node)
		self.removed_node.emit(node, _class)
	
	# 这个名称的节点列表
	var ctn_list : Array = DataUtil.get_value_or_set(_name_to_nodes_map, node.name, func(): return [])
	ctn_list.erase(node)


