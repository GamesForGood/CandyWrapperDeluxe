extends GutTest

var Level = load("res://test/resources/TestIntegrationPlayer.tscn")

var character = null
var level = null
var sender = InputSender.new(Input)


func before_each():
	level = add_child_autofree(Level.instance())
	character = level.get_node("Player")
	yield(yield_frames(1), YIELD)

func after_each():
	sender.release_all()
	sender.clear()

# Test if level and chaacters are loaded properly
func test_level_loaded():
	assert_not_null(level, "Level should be loaded")
	assert_not_null(character, "Character should be loaded")
	assert_true(character.is_on_floor(), "Character should be in the floor")
	

# Test if character moves right on right key pressed
func test_move_right():
	var expected_result = character.position + Vector2(1, 0)
	sender.action_down("right").wait("1f")
	yield(sender, "idle")
	var result = character.position
	assert_eq(result, expected_result, "Should move right")


# Test if character moves left on left key pressed
func test_move_left():
	var expected_result = character.position + Vector2(-1, 0)
	sender.action_down("left").wait("1f")
	yield(sender, "idle")
	var result = character.position
	assert_eq(result, expected_result, "Should move left")


# Test if character jumps on jump key pressed
func test_jump():
	sender.action_down("jump").wait("1f")
	yield(sender, "idle")
	assert_false(character.is_on_floor(), "Should jump and not be on floor")
	assert_lt(character.vel.y, 0, "Should jump and not be on floor")


# Test if character jumps on jump key pressed
func test_jump_specific_amount_jumped():
	var expected_result = character.position + Vector2(0, -2.287498)
	sender.action_down("jump").wait("1f")
	yield(sender, "idle")
	var result = character.position
	assert_eq(result, expected_result, "Should jump and not be on floor")

# Test if wrap around works
func test_wrap_around():
	var original_position = character.position.x
	sender.action_down("left").wait(1.5)
	yield(sender, "idle")
	var result = character.position.x
	assert_gt(result, original_position, "Should wrap around")