extends Node2D

var generalLabel: Label

func _ready():
	generalLabel = get_node("generalLabel")
	
	identifyInputOnLoad()

	Input.connect("joy_connection_changed", Callable(self, "_on_joy_connection_changed"))

#Real time Input controller device identification
func _on_joy_connection_changed(device_id: int, connected: bool):
	if connected:
		generalLabel.text = "START";
	else:
		generalLabel.text = "ENTER";
		
#When the game loads, it automatically identify the Input device controller
func identifyInputOnLoad():
	if Input.is_joy_known(0):
		generalLabel.text = "START";
	else:
		generalLabel.text = "ENTER";

