extends Node2D

const Goober = preload("res://Script/Goober.gd")

var max_lives = 3
var lives = max_lives

var level = 0
var lastLevel = 21

var Main
var Game

var OST = load("res://Audio/OST.ogg")
var audio

func _ready():
	await get_tree().create_timer(0.1).timeout
	
	audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = OST
	audio.play()
	audio.finished.connect(audio.play)
