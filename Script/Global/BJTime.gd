extends HTTPRequest

var result:int

signal done

func _ready() -> void:
    request_completed.connect(self._http_request_completed)

func get_time() -> int:
    var error = request("http://quan.suning.com/getSysTime.do")
    if error != OK:
        push_error("在HTTP请求中发生了一个错误。")
    await done
    return result

func over_a_day(time:int = 0) -> bool:
    if time == 0:
        await get_time()
    
    if result > time:
        print("过了一天")
        return true
    else:
        print("过了0天")
        return false

# 当 HTTP 请求完成时调用。
func _http_request_completed(result, response_code, headers, body):
    var json = JSON.new()
    json.parse(body.get_string_from_utf8())
    var response = json.get_data()
    result = int(response["sysTime1"])
    done.emit()
