extends GutTest

var Game = load('res://Script/Game.gd')
var _game = null;

func before_each():
	_game = Game.new()
	
func after_each():
	_game.free()

#Pay atection on ModifyLives(int,action) method it takes two parameters where:
#First one you set how many lives would you want to increase or remove on your player
#Second one we use to set whitch action is happening and we set as defaults action
# "Win" and "Lose" actions. Let's test it, how it works like.

#The way we use to increment life on the player
func test_increment_life():
	global.lives = 1
	_game.ModifyLives(1) #Would be _global.Game.ModifyLives(1) means the same but with diferent condition
	assert_eq(global.lives,2,'value should be equals')

#The way we use to decrement life on the player
func test_decrement_life():
	global.lives = 3
	_game.ModifyLives(-1)
	assert_eq(global.lives,2,'value should be equals')

#The way we use to control if life is not below zero and if it is we set life to zero again in the player
func test_take_life_not_below_zero():
	global.lives = 0
	_game.ModifyLives(-1)
	assert_eq(global.lives,0,'value should be equals')

func test_take_life_not_over_three():
	global.lives = 3
	_game.ModifyLives(1)
	assert_eq(global.lives,3,'value should be equals')

#This tests was successfully done and the method should be applied on Game.gd in Lose() and Win() methods
#Make sure you decrement lives OnFloor on Player.gd when your player die.
#At least do forget to verify when your player lose the game how many lives he has got if it's equals to
#zero take the player to previous level else keep him at the level he is.


func test_modify_level_up():
	global.level = 3
	_game.ModifyLevel(1)
	assert_eq(global.level,4,'value should be equals')

func test_modify_level_down():
	global.level = 3
	_game.ModifyLevel(-1)
	assert_eq(global.level,2,'value should be equals')

func test_modify_level_up_boundary():
	global.level = global.lastLevel
	_game.ModifyLevel(1)
	assert_eq(global.level,global.lastLevel,'value should be equals')

func test_modify_level_down_boundary():
	global.level = 1
	_game.ModifyLevel(-11)
	assert_eq(global.level,1,'value should be equals')