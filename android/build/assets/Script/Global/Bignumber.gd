extends RefCounted

class_name Big

var mantissa: float = 0.0
var exponent: int = 1

var other = {"dynamic_decimals":true, "small_decimals":2, "thousand_decimals":2, "big_decimals":2, "thousand_separator":".", "decimal_separator":".", "postfix_separator":"", "reading_separator":"", "thousand_name":"thousand"}
var postfixes_aa = {"0":"", "1":"K", "2":"M", "3":"B", "4":"T", "5":"AA", "6":"AB", "7":"AC", "8":"AD", "9":"AE", "10":"AF", "11":"AG", "12":"AH", "13":"AI", "14":"AJ", "15":"AK", "16":"AL", "17":"AM", "18":"AN", "19":"AO", "20":"AP", "21":"AQ", "22":"AR", "23":"AS", "24":"AT", "25":"AU", "26":"AV", "27":"AW", "28":"AX", "29":"AY", "30":"AZ", "31":"BA", "32":"BB", "33":"BC", "34":"BD", "35":"BE", "36":"BF", "37":"BG", "38":"BH", "39":"BI", "40":"BJ", "41":"BK", "42":"BL", "43":"BM", "44":"BN", "45":"BO", "46":"BP", "47":"BQ", "48":"BR", "49":"BS", "50":"BT", "51":"BU", "52":"BV", "53":"BW", "54":"BX", "55":"BY", "56":"BZ", "57":"CA"}

const postfixes_metric_symbol = {"0":"", "1":"k", "2":"M", "3":"G", "4":"T", "5":"P", "6":"E", "7":"Z", "8":"Y", "9":"R", "10":"Q"}
const postfixes_metric_name = {"0":"", "1":"kilo", "2":"mega", "3":"giga", "4":"tera", "5":"peta", "6":"exa", "7":"zetta", "8":"yotta", "9":"ronna", "10":"quetta"}
const alphabet_aa = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

const latin_ones = ["", "un", "duo", "tre", "quattuor", "quin", "sex", "septen", "octo", "novem"]
const latin_tens = ["", "dec", "vigin", "trigin", "quadragin", "quinquagin", "sexagin", "septuagin", "octogin", "nonagin"]
const latin_hundreds = ["", "cen", "duocen", "trecen", "quadringen", "quingen", "sescen", "septingen", "octingen", "nongen"]
const latin_special = ["", "mi", "bi", "tri", "quadri", "quin", "sex", "sept", "oct", "non"]

const MAX_MANTISSA = 1209600.0
const MANTISSA_PRECISSION = 0.0000001

func get_save_data() -> Dictionary:
	var new_dic:Dictionary = {
		"mantissa": mantissa,
		"exponent": exponent,
	}
	return new_dic

func load_form_save(save:Dictionary) -> void:
	mantissa = save["mantissa"]
	exponent = save["exponent"]

func _init(m, e := 0):
	if typeof(m) == TYPE_STRING:
		var scientific = m.split("e")
		mantissa = float(scientific[0])
		if scientific.size() > 1:
			exponent = int(scientific[1])
		else:
			exponent = 0
	elif m is Big:
		mantissa = m.mantissa
		exponent = m.exponent
	else:
		_sizeCheck(m)
		mantissa = m
		exponent = e
	calculate(self)

func _sizeCheck(m):
	if m > MAX_MANTISSA:
		printerr(m, "BIG ERROR: MANTISSA TOO LARGE, PLEASE USE EXPONENT OR SCIENTIFIC NOTATION")

static func _typeCheck(n):
	if typeof(n) == TYPE_INT or typeof(n) == TYPE_FLOAT:
		return {"mantissa":float(n), "exponent":0}
	elif typeof(n) == TYPE_STRING:
		var split = n.split("e")
		return {"mantissa":float(split[0]), "exponent":int(0 if split.size() == 1 else split[1])}
	else:
		return n

func plus(n):
	n = Big._typeCheck(n)
	_sizeCheck(n.mantissa)
	var exp_diff = n.exponent - exponent
	if exp_diff < 248:
		var scaled_mantissa = n.mantissa * pow(10, exp_diff)
		mantissa += scaled_mantissa
	elif isLessThan(n):
		mantissa = n.mantissa #when difference between values is big, throw away small number
		exponent = n.exponent
	calculate(self)
	return self


func minus(n):
	n = Big._typeCheck(n)
	_sizeCheck(n.mantissa)
	var exp_diff = n.exponent - exponent #abs?
	if exp_diff < 248:
		var scaled_mantissa = n.mantissa * pow(10, exp_diff)
		mantissa -= scaled_mantissa
	elif isLessThan(n):
		mantissa = -MANTISSA_PRECISSION
		exponent = n.exponent
	calculate(self)
	return self


func multiply(n):
	n = Big._typeCheck(n)
	_sizeCheck(n.mantissa)
	var new_exponent = n.exponent + exponent
	var new_mantissa = n.mantissa * mantissa
	while new_mantissa >= 10.0:
		new_mantissa /= 10.0
		new_exponent += 1
	mantissa = new_mantissa
	exponent = new_exponent
	calculate(self)
	return self


func divide(n):
	n = Big._typeCheck(n)
	_sizeCheck(n.mantissa)
	if n.mantissa == 0:
		printerr("BIG ERROR: DIVIDE BY ZERO OR LESS THAN " + str(MANTISSA_PRECISSION))
		return self
	var new_exponent = exponent - n.exponent
	var new_mantissa = mantissa / n.mantissa
	while new_mantissa < 1.0 and new_mantissa > 0.0:
		new_mantissa *= 10.0
		new_exponent -= 1
	mantissa = new_mantissa
	exponent = new_exponent
	calculate(self)
	return self

func power(n: int):
	if n < 0:
		printerr("BIG ERROR: NEGATIVE EXPONENTS NOT SUPPORTED!")
		mantissa = 1.0
		exponent = 0
		return self
	if n == 0:
		mantissa = 1.0
		exponent = 0
		return self

	var y_mantissa = 1
	var y_exponent = 0

	while n > 1:
		calculate(self)
		if n % 2 == 0: #n is even
			exponent = exponent + exponent
			mantissa = mantissa * mantissa
			@warning_ignore("integer_division")
			n = n / 2  # warning-ignore:integer_division
		else:
			y_mantissa = mantissa * y_mantissa
			y_exponent = exponent + y_exponent
			exponent = exponent + exponent
			mantissa = mantissa * mantissa
			@warning_ignore("integer_division")
			n = (n-1) / 2  # warning-ignore:integer_division

	exponent = y_exponent + exponent
	mantissa = y_mantissa * mantissa
	calculate(self)
	return self


func squareRoot():
	if exponent % 2 == 0:
		mantissa = sqrt(mantissa)
		@warning_ignore("integer_division")
		exponent = exponent/2  # warning-ignore:integer_division
	else:
		mantissa = sqrt(mantissa*10)
		@warning_ignore("integer_division")
		exponent = (exponent-1)/2  # warning-ignore:integer_division
	calculate(self)
	return self


func modulo(n):
	n = Big._typeCheck(n)
	_sizeCheck(n.mantissa)
	var big = {"mantissa":mantissa, "exponent":exponent}
	divide(n)
	roundDown()
	multiply(n)
	minus(big)
	mantissa = abs(mantissa)
	return self


func calculate(big):
	if big.mantissa >= 10.0 or big.mantissa < 1.0:
		var diff = int(floor(log10(big.mantissa)))
		if diff > -10 and diff < 248:
			var div = pow(10, diff)
			if div > MANTISSA_PRECISSION:
				big.mantissa /= div
				big.exponent += diff
	while big.exponent < 0:
		big.mantissa *= 0.1
		big.exponent += 1
	while big.mantissa >= 10.0:
		big.mantissa *= 0.1
		big.exponent += 1
	if big.mantissa == 0:
		big.mantissa = 0.0
		big.exponent = 0
	big.mantissa = snapped(big.mantissa, MANTISSA_PRECISSION)


func isEqualTo(n):
	n = Big._typeCheck(n)
	calculate(n)
	return n.exponent == exponent and is_equal_approx(n.mantissa, mantissa)


func isLargerThan(n):
	return !isLessThanOrEqualTo(n)


func isLargerThanOrEqualTo(n):
	return !isLessThan(n)


func isLessThan(n):
	n = Big._typeCheck(n)
	calculate(n)
	if mantissa == 0 and (n.mantissa > MANTISSA_PRECISSION or mantissa < MANTISSA_PRECISSION) and n.mantissa == 0:
		return false
	if exponent < n.exponent:
		return true
	elif exponent == n.exponent:
		if mantissa < n.mantissa:
			return true
		else:
			return false
	else:
		return false


func isLessThanOrEqualTo(n):
	n = Big._typeCheck(n)
	calculate(n)
	if isLessThan(n):
		return true
	if n.exponent == exponent and is_equal_approx(n.mantissa, mantissa):
		return true
	return false


static func min(m, n):
	m = _typeCheck(m)
	if m.isLessThan(n):
		return m
	else:
		return n


static func max(m, n):
	m = _typeCheck(m)
	if m.isLargerThan(n):
		return m
	else:
		return n


static func abs(n):
	n.mantissa = abs(n.mantissa)
	return n


func roundDown():
	if exponent == 0:
		mantissa = floor(mantissa)
		return self
	else:
		var precision = 1.0
		for i in range(min(8, exponent)):
			precision /= 10.0
		if precision < MANTISSA_PRECISSION:
			precision = MANTISSA_PRECISSION
		mantissa = snapped(mantissa, precision)
		return self


func log10(x):
	return log(x) * 0.4342944819032518


#static func setThousandName(name):
#	other.thousand_name = name
#
#static func setThousandSeparator(separator):
#	other.thousand_separator = separator
#
#static func setDecimalSeparator(separator):
#	other.decimal_separator = separator
#
#static func setPostfixSeparator(separator):
#	other.postfix_separator = separator
#
#static func setReadingSeparator(separator):
#	other.reading_separator = separator
#
#static func setDynamicDecimals(d):
#	other.dynamic_decimals = bool(d)
#
#static func setSmallDecimals(d):
#	other.small_decimals = int(d)
#
#static func setThousandDecimals(d):
#	other.thousand_decimals = int(d)
#
#static func setBigDecimals(d):
#	other.big_decimals = int(d)

func toString():
	var mantissa_decimals = 0
	if str(mantissa).find(".") >= 0:
		mantissa_decimals = str(mantissa).split(".")[1].length()
	if mantissa_decimals > exponent:
		if exponent < 248:
			return str(mantissa * pow(10, exponent))
		else:
			return toScientific()
	else:
		var mantissa_string = str(mantissa).replace(".", "")
		for _i in range(exponent-mantissa_decimals):
			mantissa_string += "0"
		return mantissa_string


func toScientific():
	return str(mantissa) + "e" + str(exponent)


func toShortScientific():
	return str(snapped(mantissa, 0.1)) + "e" + str(exponent)


func toFloat():
	return snapped(float(str(mantissa) + "e" + str(exponent)),0.01)


func toPrefixOld(no_decimals_on_small_values = false):
	var hundreds = 1
	for _i in range(exponent % 3):
		hundreds *= 10
	var number = mantissa * hundreds
	var result = ""
	var split = str(number).split(".")
	@warning_ignore("integer_division")
	if no_decimals_on_small_values and int(exponent / 3) == 0:  # warning-ignore:integer_division
		result = split[0]
	else:
		if split[0].length() == 3:
			result = str("%1.2f" % number).substr(0,3)
		else:
			result = str("%1.2f" % number).substr(0,4)

	return result


func toPrefix(no_decimals_on_small_values = false, use_thousand_symbol=true, force_decimals=true):
	var hundreds = 1
	for _i in range(exponent % 3):
		hundreds *= 10
	var number:float = mantissa * hundreds
	var split = str(number).split(".")
	if force_decimals:
		if split.size() == 1:
			split.append("")
		split[1] += "000"
	var result = split[0]
	@warning_ignore("integer_division", "integer_division", "integer_division", "integer_division")
	if no_decimals_on_small_values and int(exponent / 3) == 0:  # warning-ignore:integer_division
		pass
	elif exponent < 3:
		if split.size() > 1 and other.small_decimals > 0:
			result += other.decimal_separator + split[1].substr(0,min(other.small_decimals, 4 - split[0].length() if other.dynamic_decimals else other.small_decimals))
	elif exponent < 6:
		if use_thousand_symbol:
			if split.size() > 1 and other.thousand_decimals > 0:
				result += other.decimal_separator + split[1].substr(0,min(other.thousand_decimals, 4 - split[0].length() if other.dynamic_decimals else other.small_decimals))
		else:
			if split.size() > 1:
				result += other.thousand_separator + (split[1] + "000").substr(0,3)
			else:
				result += other.thousand_separator + "000"
	else:
		if split.size() > 1 and other.big_decimals > 0:
			result += other.decimal_separator + split[1].substr(0,min(other.big_decimals, 4 - split[0].length() if other.dynamic_decimals else other.small_decimals))

	return result


# warning-ignore:integer_division
func _latinPower(european_system):
	if european_system:
		@warning_ignore("integer_division")
		return int(exponent / 3) / 2  # warning-ignore:integer_division
	@warning_ignore("integer_division")
	return int(exponent / 3) - 1  # warning-ignore:integer_division


func _latinPrefix(european_system):
	var ones = _latinPower(european_system) % 10
	@warning_ignore("integer_division")
	var tens = int(_latinPower(european_system) / 10) % 10
	@warning_ignore("integer_division")
	var hundreds = int(_latinPower(european_system) / 100) % 10
	@warning_ignore("integer_division")
	var millias = int(_latinPower(european_system) / 1000) % 10

	var prefix = ""
	if _latinPower(european_system) < 10:
		prefix = latin_special[ones] + other.reading_separator + latin_tens[tens] + other.reading_separator + latin_hundreds[hundreds]
	else:
		prefix = latin_hundreds[hundreds] + other.reading_separator + latin_ones[ones] + other.reading_separator + latin_tens[tens]

	for _i in range(millias):
		prefix = "millia" + other.reading_separator + prefix

	return prefix.lstrip(other.reading_separator).rstrip(other.reading_separator)


func _tillionOrIllion(european_system):
	if exponent < 6:
		return ""
	var powerKilo = _latinPower(european_system) % 1000
	if powerKilo < 5 and powerKilo > 0 and _latinPower(european_system) < 1000:
		return ""
	@warning_ignore("integer_division")
	if powerKilo >= 7 and powerKilo <= 10 or int(powerKilo / 10) % 10 == 1:
		return "i"
	return "ti"


func _llionOrLliard(european_system):
	if exponent < 6:
		return ""
	@warning_ignore("integer_division")
	if int(exponent/3) % 2 == 1 and european_system:  # warning-ignore:integer_division
		return "lliard"
	return "llion"


func getLongName(european_system = false, prefix=""):
	if exponent < 6:
		return ""
	else:
		return prefix + _latinPrefix(european_system) + other.reading_separator + _tillionOrIllion(european_system) + _llionOrLliard(european_system)


func toAmericanName(no_decimals_on_small_values = false):
	return toLongName(no_decimals_on_small_values, false)


func toEuropeanName(no_decimals_on_small_values = false):
	return toLongName(no_decimals_on_small_values, true)


func toLongName(no_decimals_on_small_values = false, european_system = false):
	if exponent < 6:
		if exponent > 2:
			return toPrefix(no_decimals_on_small_values) + other.postfix_separator + other.thousand_name
		else:
			return toPrefix(no_decimals_on_small_values)

	var postfix = _latinPrefix(european_system) + other.reading_separator + _tillionOrIllion(european_system) + _llionOrLliard(european_system)

	return toPrefix(no_decimals_on_small_values) + other.postfix_separator + postfix


func toMetricSymbol(no_decimals_on_small_values = false):
	@warning_ignore("integer_division")
	var target = int(exponent / 3)  # warning-ignore:integer_division

	if not postfixes_metric_symbol.has(str(target)):
		return toScientific()
	else:
		return toPrefix(no_decimals_on_small_values) + other.postfix_separator + postfixes_metric_symbol[str(target)]


func toMetricName(no_decimals_on_small_values = false):
	@warning_ignore("integer_division")
	var target = int(exponent / 3)  # warning-ignore:integer_division

	if not postfixes_metric_name.has(str(target)):
		return toScientific()
	else:
		return toPrefix(no_decimals_on_small_values) + other.postfix_separator + postfixes_metric_name[str(target)]


func toAA(no_decimals_on_small_values = false, use_thousand_symbol = true, force_decimals=false):
	@warning_ignore("integer_division")
	var target = int(exponent / 3)  # warning-ignore:integer_division
	var postfix = ""

	# This is quite slow for very big numbers, but we save the result for next similar target
	if not postfixes_aa.has(str(target)):
		var units = [0,0]
		var m = 0
		var u = 1
		#print("UNIT " + str(target) + " NOT FOUND IN TABLE - GENERATING IT INSTEAD")
		while (m < target-5):
			m += 1
			units[u] += 1
			if units[u] == alphabet_aa.size():
				var found = false
				for i in range(units.size()-1,-1,-1):
					if not found and units[i] < alphabet_aa.size()-1:
						units[i] += 1
						found = true
				units[u] = 0
				if not found:
					units.append(0)
					u += 1
					for i in range(units.size()):
						units[i] = 0

		for i in range(units.size()):
			postfix = postfix + str(alphabet_aa[units[i]])
		postfixes_aa[str(target)] = postfix
	else:
		postfix = postfixes_aa[str(target)]

	if not use_thousand_symbol and target == 1:
		postfix = ""

	var prefix = toPrefix(no_decimals_on_small_values, use_thousand_symbol, force_decimals)

#    if remove_trailing_zeroes and other.decimal_separator in prefix:
#        while prefix.ends_with("0"):
#            prefix = prefix.rstrip("0")
#        while prefix.ends_with(other.decimal_separator):
#            prefix = prefix.rstrip(other.decimal_separator)

	return prefix + other.postfix_separator + postfix