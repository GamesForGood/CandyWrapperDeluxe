extends Node2D

var generalLabel: Label

func _ready():
	generalLabel = get_node("generalLabel")

	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

func _on_joy_connection_changed(device_id: int, connected: bool):
	if connected:
		generalLabel.text = "START";
	else:
		generalLabel.text = "SPACE";

