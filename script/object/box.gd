extends Node2D

signal full

@export var border: int = 20
@export var time_max: float = 2

@onready var pos: Vector2 = self.get_position()
var left: float
var right: float
var top: float
var bottom: float
var _num_top_collision: int = 0
var _time_collision: float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var size: Vector2 = Vector2($Sprite2D.texture.get_width(), $Sprite2D.texture.get_height()) * $Sprite2D.scale * self.scale
	left = pos.x - size.x / 2 + border
	right = pos.x + size.x / 2 - border
	top = pos.y - size.y / 2 + border
	bottom = pos.y + size.y / 2 - border


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _num_top_collision > 0:
		_time_collision += delta
	else:
		_time_collision = 0
	if _time_collision > time_max:
		emit_signal("full")


func _on_check_full_body_entered(_body):
	_num_top_collision += 1


func _on_check_full_body_exited(_body):
	_num_top_collision -= 1
