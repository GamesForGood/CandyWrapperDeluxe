extends Node2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
onready var timer: Timer = get_node("Timer")


var timer_duration = 10.0
var seconds_change = 2.0
var check = false

func _ready():
	$Timer.start()
	anim_player.play("zoom_in")
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
	
func _on_Timer_timeout():
	$Timer.stop()
	$Timer.queue_free()
	queue_free()
	#$TuturialNormal.visible = false

func _physics_process(delta):
	if Input.is_action_just_pressed("enter") || btn.just_pressed("ui_select"):
		queue_free()

func _process(delta):
	var seconds_left = timer.time_left
	#print("Segundos restantes: ", timer_duration - seconds_left)
	if $TuturialNormal.visible:
		if int(timer_duration - seconds_left) == int(seconds_change):
			print("Segundos restantes: ", timer_duration - seconds_left)
			if int(seconds_change) == 2:
				$TuturialNormal/Title2.text = "Left"
			if int(seconds_change) == 4:
				$TuturialNormal/Title2.text = "Right"
			if int(seconds_change) == 6:
				$TuturialNormal/Title2.text = "Up"
			if int(seconds_change) == 8:
				$TuturialNormal/Title2.text = "Down"
			seconds_change = seconds_change + 2
	elif $ConsolasTuturial.visible:
		
		if int(timer_duration - seconds_left) == int(seconds_change):
			print("Segundos restantes: ", timer_duration - seconds_left)
			if int(seconds_change) == 2:
				$TuturialNormal/Title2.text = "Left"
			if int(seconds_change) == 4:
				$TuturialNormal/Title2.text = "Right"
			if int(seconds_change) == 6:
				$TuturialNormal/Title2.text = "Up"
			if int(seconds_change) == 8:
				$TuturialNormal/Title2.text = "Down"
			seconds_change = seconds_change + 2
