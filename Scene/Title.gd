extends Node2D

var startLabel: Label
var spaceLabel: Label
var joypads = Input.get_connected_joypads()

func _ready():
	
	#The two labels are not visible by default
	startLabel = get_node("startLabel")
	spaceLabel = get_node("spaceLabel")
	
	#Setting the menu according to the connected device
	if joypads.size() > 0:
		startLabel.visible = true
	else:
		spaceLabel.visible = true
		
	#Changing the menu dynamically when the joystick is connected or desconnected
	for joypad in Input.get_connected_joypads():
		print("Detected joypad device: ", joypad)
		
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

func _on_joy_connection_changed(device: int, connected: bool) -> void:
	if connected:
		startLabel.visible = true
		spaceLabel.visible = false
	else:
		spaceLabel.visible = true
		startLabel.visible = false
		
