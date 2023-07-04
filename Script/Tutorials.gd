extends Node2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
onready var timer: Timer = get_node("Timer")


var timer_duration = 10.0

func _ready():
	$Timer.start()
	anim_player.play("zoom_in")
	Input.connect("joy_connection_changed", self, "_joy_connection_changed")
	if Input.get_connected_joypads().size() > 0:
		$ConsolasTuturial.visible = false
		$TuturialNormal.visible = true
	else:
		$TuturialNormal.visible = false
		$ConsolasTuturial.visible = true

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
	var seconds_change = 5.0
	#print("Segundos restantes: ", timer_duration - seconds_left)
	if $TuturialNormal.visible:
		if int(timer_duration - seconds_left) == int(seconds_change):
			print("Segundos restantes: ", timer_duration - seconds_left)
			$TuturialNormal/Right.visible = false
			$TuturialNormal/Up.visible = false
			$TuturialNormal/Left.visible = false
			$TuturialNormal/Label.visible = false
			$TuturialNormal/Title2.visible = false
			$TuturialNormal/Title3.visible = true
	elif $ConsolasTuturial.visible:
		seconds_change = 5.0
		if int(timer_duration - seconds_left) == int(seconds_change):
			print("Segundos restantes: ", timer_duration - seconds_left)
			$ConsolasTuturial/DPAD_Left.visible = false
			$ConsolasTuturial/DPAD_Right.visible = false
			#$ConsolasTuturial/DPAD_Up.visible = true
			#$ConsolasTuturial/DPAD_Down.visible = true
			$ConsolasTuturial/Label2.text = "Up"
			$ConsolasTuturial/Label.text = "Down"
