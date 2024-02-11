extends Node2D

var score: int = 0
var score_best: int = 0

signal restart


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_button_pressed():
	if score > score_best:
		score_best = score
	score = 0
	emit_signal("restart")
