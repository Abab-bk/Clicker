#============================================================
#    Gquery
#============================================================
# - author: zhangxuetu
# - datetime: 2023-05-01 17:00:51
# - version: 4.0
#============================================================
class_name GQuery


#============================================================
#  执行功能
#============================================================
class QFunction:
	
	# 数据
	var _data : Array = []
	# 原始数据是否是 Array 类型
	var _is_array : bool = false
	
	func _init(data):
		_is_array = (data is Array)
		if _is_array:
			_data.append_array(data)
		else:
			_data.append(data)
	
	func get_data():
		if _is_array:
			return _data
		else:
			return _data[0]
	
	func property(property_name: String, value) -> QFunction:
		for i in _data:
			i[property_name] = value
		return self
	
	func method(method_name: StringName, parameters: Array = []) -> QFunction:
		var list = []
		for i in _data:
			list.append(i.callv(method_name, parameters))
		return QFunction.new(list)
	
	func emit(signal_name: StringName, parameters: Array = []) -> QFunction:
		if not _data.is_empty():
			var first = _data[0]
			for object in _data:
				SignalUtil.emit_signalv(object, signal_name, parameters)
		return self
	
	func foreach(callable: Callable, call_deferred: bool = false) -> QFunction:
		if call_deferred:
			for object in _data:
				callable.call_deferred(object)
		else:
			for object in _data:
				callable.call(object)
		return self
	
	func foreachs(callables: Array[Callable], call_deferred: bool = false) -> QFunction:
		for callable in callables:
			foreach(callable, call_deferred)
		return self
	
	func map(callable: Callable) -> QFunction:
		_data = _data.map(callable)
		return self
	
	func filter(callable: Callable) -> QFunction:
		_data = _data.filter(callable)
		return self
	
	func push(data) -> QFunction:
		_is_array = true
		if data is Array:
			_data.append_array(data)
		else:
			_data.append(data)
		return self
	


#============================================================
#  自定义
#============================================================
static func from(data) -> QFunction:
	return QFunction.new(data)

