extends Node

func NumBool(arg : bool):
	return 1 if arg else 0

# DOWN
func pressed(arg : String):
	return NumBool(Input.is_action_pressed(arg))

# PRESSED
func just_pressed(arg : String):
	return NumBool(Input.is_action_just_pressed(arg))

# RELEASED
func just_released(arg : String):
	return NumBool(Input.is_action_just_released(arg))