extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	LoadHUDLives()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func LoadHUDLives():
	$HeartsFull.size.x = global.lives * 8
	$HeartsEmpty.size.x = (global.max_lives - global.lives) * 8
	$HeartsEmpty.position.x = $HeartsFull.position.x + $HeartsFull.size.x * $HeartsFull.scale.x
