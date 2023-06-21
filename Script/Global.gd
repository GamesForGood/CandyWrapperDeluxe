extends Node2D

const Goober = preload("res://Script/Goober.gd")

var max_lives = 3
var lives = max_lives
var level = 0
var lastLevel = 21

var Main
var Game

func ModifyLives(var live, var action):
	if(action == "Win"):
		if(lives < max_lives):
			lives += live
	if(action == "Lose"):
		lives += live
		if(lives <= 1):
			lives = 1

