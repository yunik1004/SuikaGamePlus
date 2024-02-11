extends Node

var pause_pannel: Node
var scene: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_pannel = $PausePannel
	pause_pannel.visible = false
	scene = get_parent()


func _on_pause_button_pressed():
	pause_pannel.visible = true


func _on_close_button_pressed():
	pause_pannel.visible = false


func _on_scene_restart():
	$TopPannel/Score.text = "Score: %d\nBest Score: %d" % [scene.score, scene.score_best]	
	pause_pannel.visible = false
