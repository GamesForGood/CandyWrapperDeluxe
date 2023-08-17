extends CharacterBody2D

const flr = Vector2(0, -1)

func wrapObject():
	if position.x < 0:
		position.x += 144
	elif position.x > 144:
		position.x -= 144
	if position.y < 0:
		position.y += 144
	elif position.y > 144:
		position.y -= 144
