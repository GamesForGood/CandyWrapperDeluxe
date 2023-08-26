extends "res://Script/BaseKine.gd"
class_name Player

var NodeScene
var NodeSprite
var NodeArea2D
var NodeAudio
var NodeAnim

var PLAYER_EXPLOSION = load("res://Scene/Explosion.tscn")
var GREEN_ENEMY_EXPLOSION = load("res://Scene/ExplosionGreenEnemy.tscn")

var HUD
var read = []


var spd = 60
var grv = 255
var jumpSpd = 133
var termVel = 400

var onFloor = false
var jump = false


func _ready():
	velocity = Vector2.ZERO
	NodeScene = global.Game
	# reference nodes
	NodeSprite = get_node("Sprite2D")
	NodeArea2D = get_node("Area2D")
	NodeAudio = get_node("Audio")
	NodeAnim = get_node("AnimationPlayer")

func DOHUD(arg : int):
	var fnt = load("res://Font/m3x6.tres")
	HUD = NodeScene.get_node("HUD")
	for i in range(arg):
		var nNode = Label.new()
		nNode.name = "Label" + str(i)
		nNode.text = nNode.name
		nNode.offset_top = (i * 7) - 4
		nNode.offset_left = 1
		nNode.uppercase = true
		nNode.add_theme_color_override("font_color", Color.BLACK)
		nNode.add_theme_font_override("font", fnt)
		HUD.add_child(nNode, true)
		read.append(HUD.get_node(nNode.name))

func _physics_process(delta):
	# gravity
	velocity.y += grv * delta
	velocity.y = clamp(velocity.y, -termVel, termVel)
	
	# horizontal input
	var btnx = btn.pressed("right") - btn.pressed("left")
	velocity.x = btnx * spd
	
	# jump
	if onFloor:
		if btn.just_pressed("jump"):
			jump = true
			velocity.y = -jumpSpd
			NodeAudio.play()
	elif jump:
		if !btn.pressed("jump") and velocity.y < jumpSpd / -3:
			jump = false
			velocity.y = jumpSpd / -3
	
	# apply movement
	set_up_direction(flr)
	move_and_slide()
	var mov = velocity
	wrapObject()
	# check for Goobers
	var hit = Overlap()
	if !hit:
		if mov.y == 0:
			velocity.y = 0
		# check for floor 0.1 pixel down
		onFloor = test_move(transform, Vector2(0, 0.1))
	
	# sprite flip
	if btnx !=0:
		NodeSprite.flip_h = btn.pressed("left")
	
	# animation
	if onFloor:
		if btnx == 0:
			TryLoop("Idle")
		else:
			TryLoop("Run")
	else:
		TryLoop("Jump")
	
	
	# HUD
	#read[0].text = "onFloor: " + String(onFloor)
	#read[1].text = "pos.x: " + String(position.x)
	#read[2].text = "pos.y: " + String(position.y)
	#read[3].text = "vel.x: " + String(vel.x)
	#read[4].text = "vel.y: " + String(vel.y)



func Explode(arg : Vector2, explosionType):
	explosionType.position = arg
	NodeScene.add_child(explosionType)

func Die():
	queue_free()
	Explode(position, PLAYER_EXPLOSION.instantiate())
	global.Game.Lose()

func Overlap():
	var hit = false
	var overlap = NodeArea2D.get_overlapping_areas()
	for o in overlap:
		print ("Overlapping: ", o.get_parent().name)
		var par = o.get_parent()
		#print()
		if par is global.Goober:
			if onFloor:
				Die()
			else:
				if btn.pressed("jump"):
					jump = true
					velocity.y = -jumpSpd
				else:
					jump = false
					velocity.y = -jumpSpd * 0.6
				par.queue_free()
				Explode(par.position, GREEN_ENEMY_EXPLOSION.instantiate())
				NodeScene.check = true
				print("Goober destroyed")
				hit = true
	return hit

func TryLoop(arg : String):
	if arg == NodeAnim.current_animation:
		return false
	else:
		NodeAnim.play(arg)
		return true
