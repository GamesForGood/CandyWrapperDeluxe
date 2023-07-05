extends "res://Script/BaseKine.gd"
class_name TitlePlayer

var NodeScene
var NodeSprite
var NodeArea2D
var NodeAudio
var NodeAnim

var PLAYER_EXPLOSION = load("res://Scene/Explosion.tscn")
var GREEN_ENEMY_EXPLOSION = load("res://Scene/ExplosionGreenEnemy.tscn")

var HUD
var read = []

var vel = Vector2.ZERO
var spd = 60
var grv = 255
var jumpSpd = 133
var termVel = 400

var onFloor = false
var jump = false

var startPos

func _ready():
	print("Nivel 0")
	NodeScene = global.Game
	
	# snap down 8 pixels, if floor is present
	var vecdn = Vector2(0, 8)
	if test_move(transform, vecdn):
		move_and_collide(vecdn)
	startPos = position
	# create hud labels
	#DOHUD(5)
	
	# reference nodes
	NodeSprite = get_node("Sprite")
	NodeArea2D = get_node("Area2D")
	NodeAudio = get_node("Audio")
	NodeAnim = get_node("AnimationPlayer")

func _physics_process(delta):
	# gravity
	vel.y += grv * delta
	vel.y = clamp(vel.y, -termVel, termVel)
	
	# horizontal input
	var btnx = btn.pressed("right") - btn.pressed("left")
	vel.x = btnx * spd
	
	# jump
	if onFloor:
		if btn.just_pressed("jump"):
			jump = true
			vel.y = -jumpSpd
			NodeAudio.play()
	elif jump:
		if !btn.pressed("jump") and vel.y < jumpSpd / -3:
			jump = false
			vel.y = jumpSpd / -3
	
	# apply movement
	var mov = move_and_slide(vel, flr)
	wrap()
	# check for Goobers
	var hit = Overlap()
	if !hit:
		if mov.y == 0:
			vel.y = 0
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
	

func Explode(arg : Vector2, explosionType):
	explosionType.position = arg
	NodeScene.add_child(explosionType)

func Die():
	queue_free()
	Explode(position, PLAYER_EXPLOSION.instance())
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
					vel.y = -jumpSpd
				else:
					jump = false
					vel.y = -jumpSpd * 0.6
				par.queue_free()
				Explode(par.position, GREEN_ENEMY_EXPLOSION.instance())
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
