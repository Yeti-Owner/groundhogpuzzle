extends Control

var url = "https://eoc51iyh2mrie8h.m.pipedream.net"
var data_to_send = {'string': "test1", 'integer': 1}

func _on_button_pressed():
	_make_post_request(url, data_to_send)

func _make_post_request(_url, _data_to_send):
	# Convert data to json string:
	var query = JSON.stringify(_data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(_url, headers, HTTPClient.METHOD_POST, query)
