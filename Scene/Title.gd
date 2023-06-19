extends Node2D

var sprite1: Sprite
var sprite2: Sprite
var startLabel: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite1 = get_node("Sprite1")
	sprite2 = get_node("Sprite2")
	startLabel = get_node("startLabel")
	
	#getting the current connect controller
	var joypads = Input.get_connected_joypads()
	
	if joypads.size() > 0:
		
		#Enabling "press start to start" when joystick is connected
		sprite2.visible = true
		startLabel.visible = true
		
		#desabling "press space to start" 
		sprite1.visible = false
	else:
		sprite1.visible = true
		sprite2.visible = false
		startLabel.visible = false


