extends Control

var LastNode:NodePath
var url := "https://eoc51iyh2mrie8h.m.pipedream.net"

func _make_post_request(_url, data_to_send):
	# Convert data to json string:
	var query := JSON.stringify(data_to_send)
	# Add 'Content-Type' header:
	var headers := ["Content-Type: application/json"]
	$HTTPRequest.request(_url, headers, HTTPClient.METHOD_POST, query)

func _on_submit_pressed():
	@warning_ignore("unassigned_variable")
	var Order:Dictionary
	var i:int = 0
	
	for child in $HBoxContainer/VBoxContainer2.get_children():
		if child.get_class() == "Label":
			i += 1
			Order[i] = child.text
	
	_make_post_request(url, Order)
