extends Node2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

var seconds_change = 0
var check = false

func _ready():
	anim_player.play("zoom_in")
	print(get_parent().name)
	Input.connect("joy_connection_changed", self, "_joy_connection_changed")
	if Input.get_connected_joypads().size() > 0:
		$ConsolasTuturial.visible = true
		$TuturialNormal.visible = false
	else:
		$TuturialNormal.visible = true
		$ConsolasTuturial.visible = false


func joy_connection_changed(device_id: int, connected : bool) -> void:
	if connected:
		$ConsolasTuturial.visible = true
		$TuturialNormal.visible = false
	else:
		$TuturialNormal.visible = true
		$ConsolasTuturial.visible = false
	
func _process(delta):
	if(global.level < 5):
		if $TuturialNormal.visible:
			var up_events = InputMap.get_action_list("jump")
			var left_events = InputMap.get_action_list("left")
			var right_events = InputMap.get_action_list("right")
			if int(seconds_change) == 0:
				$TuturialNormal/left_arrow.visible = true
				$TuturialNormal/right_arrow.visible = true
				$TuturialNormal/up_arrow.visible = true
			if int(seconds_change) == 2:
				$TuturialNormal/left_arrow.visible = false
				$TuturialNormal/right_arrow.visible = false
				$TuturialNormal/up_arrow.visible = false
				$TuturialNormal/left.visible = true
				$TuturialNormal/right.visible = true
				$TuturialNormal/up.visible = true
				if(left_events[1].is_class("InputEventKey")):
					$TuturialNormal/left.text = OS.get_scancode_string(left_events[1].scancode)
				if(right_events[1].is_class("InputEventKey")):
					$TuturialNormal/right.text = OS.get_scancode_string(right_events[1].scancode)
				if(up_events[1].is_class("InputEventKey")):
					$TuturialNormal/up.text = OS.get_scancode_string(up_events[1].scancode)
			if int(seconds_change) == 4:
				if(left_events[2].is_class("InputEventKey")):
					$TuturialNormal/left.text = OS.get_scancode_string(left_events[2].scancode)
				if(right_events[2].is_class("InputEventKey")):
					$TuturialNormal/right.text = OS.get_scancode_string(right_events[2].scancode)
				if(up_events[2].is_class("InputEventKey")):
					$TuturialNormal/up.text = OS.get_scancode_string(up_events[2].scancode)
			if int(seconds_change) == 6:
				$TuturialNormal/left.visible = false
				$TuturialNormal/right.visible = false
				$TuturialNormal/up.visible = false
				seconds_change = 0

			seconds_change += delta

	if btn.just_pressed("ui_select"):
		queue_free()
