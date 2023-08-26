extends "res://Script/BaseKine.gd"
class_name Goober

@onready var NodeCast := $RayCast2D
@onready var NodeSprite := $Sprite2D

var spd = 31

func _ready():
	# move_and_collide(Vector2(0, 1)) # snap to floor
	velocity = Vector2(spd, 0)
	# # change starting direction
	randomize()
	if randf() > 0.5:
		velocity.x = -velocity.x
		NodeSprite.flip_h = true

func _physics_process(delta):
	var cast = NodeCast.is_colliding()
	
	if cast == false:
		velocity.x = -velocity.x
		NodeSprite.flip_h = !NodeSprite.flip_h
	
	move_and_slide()
	
	# if stuck on wall, change direction
	var mov = velocity
	if mov.x == 0:
		velocity.x = -velocity.x
		NodeSprite.flip_h = !NodeSprite.flip_h
	wrapObject()

	





