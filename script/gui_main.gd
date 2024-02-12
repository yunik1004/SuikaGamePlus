extends Node

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
	$TopPannel.set_score(_scene.score, _scene.score_best)
	_pause_pannel.visible = false
