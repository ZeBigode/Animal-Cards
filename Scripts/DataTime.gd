extends Node



var url = "http://worldtimeapi.org/api/timezone/Etc/UTC?utc=true"
var http_client = HTTPRequest.new()
var data
var horas
var dataok = false
func _ready():
	add_child(http_client )
	http_client.connect("request_completed", self, "_on_request_completed")
	http_client.request(url)
	
func _on_request_completed(result, _response_code, _headers, body):
	if  result == 0:
		var json_parse_result = JSON.parse(body.get_string_from_utf8())
		if json_parse_result.error != OK:
			print("Error parsing JSON: " + str(json_parse_result.error))
		else:
			var json_data = json_parse_result.result
			if "datetime" in json_data:
				var datetime_str = json_data["datetime"]
				var date_time = datetime_str.split("T")
				var date_str = date_time[0]
				data = date_str
				var time_str = date_time[1].substr(0, 8)
				horas = time_str
			else:
				print("Error: Unexpected JSON format")
			dataok = true
			
			
	else:
		http_client.request(url)
		
	
