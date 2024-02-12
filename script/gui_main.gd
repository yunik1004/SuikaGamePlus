extends Node

signal restart

@onready var _scene: Node = get_parent()
@onready var _pause_pannel: Node = $PausePannel


# Called when the node enters the scene tree for the first time.
func _ready():
	_pause_pannel.visible = false


func _on_top_pannel_pause():
	_pause_pannel.visible = true


func _on_pause_pannel_close():
	_pause_pannel.visible = false


func _on_pause_pannel_restart():
	_pause_pannel.visible = false
	$EndPannel.visible = false
	emit_signal("restart")


func _on_main_scene_score_update():
	$TopPannel.set_score(_scene.score, _scene.score_best)


func _on_main_scene_game_end():
	$EndPannel.visible = true
