extends Node2D

@export var border: int = 20

@onready var pos: Vector2 = self.get_position()
var left: float
var right: float
var top: float
var bottom: float


# Called when the node enters the scene tree for the first time.
func _ready():
	var size: Vector2 = Vector2($Sprite2D.texture.get_width(), $Sprite2D.texture.get_height()) * $Sprite2D.scale * self.scale
	left = pos.x - size.x / 2 + border
	right = pos.x + size.x / 2 - border
	top = pos.y - size.y / 2 + border
	bottom = pos.y + size.y / 2 - border
