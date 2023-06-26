extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	LoadHearts()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func LoadHearts():
	$HeartsFull.rect_size.x = global.lives * 16
	$HeartsEmpty.rect_size.x = (global.max_lives - global.lives) * 16
	$HeartsEmpty.rect_position.x = $HeartsFull.rect_position.x + $HeartsFull.rect_size.x * $HeartsFull.rect_scale.x
