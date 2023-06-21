extends GutTest

var Global = load('res://Script/Global.gd')
var _global = null;
func before_each():
	_global = Global.new()
	
func after_each():
	_global.free()

#Pay atection on ModifyLives(int,action) method it takes two parameters where:
#First one you set how many lives would you want to increase or remove on your player
#Second one we use to set whitch action is happening and we set as defaults action
# "Win" and "Lose" actions. Let's test it, how it works like.

#The way we use to increment life on the player
func test_increment_life():
	_global.lives = 2
	_global.ModifyLives(1,"Win") #Would be _global.ModifyLives(1,"Lose") means the same but with diferent condition
	assert_eq(_global.lives,3,'value should be equals')

#The way we use to decrement life on the player
func test_decrement_life():
	_global.lives = 3
	_global.ModifyLives(-1,"Lose")
	assert_eq(_global.lives,2,'value should be equals')

#The way we use to control if life is not below one and if it is we set life to one again in the player
func test_take_life_not_below_one():
	_global.lives = 1
	_global.ModifyLives(-1,"Lose")
	assert_eq(_global.lives,1,'value should be equals')

func test_take_life_not_over_three():
	_global.lives = 3
	_global.ModifyLives(1,"Win")
	assert_eq(_global.lives,3,'value should be equals')

#This tests was successfully done and the method should be applied on Game.gd in Lose() and Win() methods
#Make sure you decrement lives OnFloor on Player.gd when your player die.
#At least do forget to verify when your player lose the game how many lives he has got if it's equals to
#zero take the player to previous level else keep him at the level he is.
