extends RigidBody2D
class_name Fruit

@export var fruit_idx: int = -1

@onready var radius: float = $CollisionShape2D.shape.radius * $CollisionShape2D.scale.x
@onready var _num_fruits: int = len(Global.fruit_names)


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", _on_body_entered)


func deactivate_rigidbody():
	self.freeze = true
	self.lock_rotation = true
	$CollisionShape2D.disabled = true


func activate_rigidbody():
	self.freeze = false
	self.lock_rotation = false
	$CollisionShape2D.disabled = false


func _on_body_entered(col: Node):
	var col_idx: int = -1
	for fname in Global.fruit_names:
		if col.name.begins_with(fname):
			col_idx = col.fruit_idx
			break
	if col_idx != fruit_idx or fruit_idx == _num_fruits - 1:
		return

	var self_pos: Vector2 = get_position()
	var col_pos: Vector2 = col.get_position()

	if self_pos.y > col_pos.y or (self_pos.y == col_pos.y and self_pos.x < col_pos.x):
		call_deferred("upgrade", self, col)


static func upgrade(col_main: Fruit, col_sub: Fruit):
	var parent: Node2D = col_main.get_parent()
	col_main.deactivate_rigidbody()
	col_main.visible = false
	col_sub.deactivate_rigidbody()
	col_sub.visible = false

	var new_fruit: Fruit = Global.scenes_fruit[col_main.fruit_idx + 1].instantiate()
	new_fruit.name = "%su"  % [col_main.name]
	new_fruit.set_position(col_main.get_position())
	parent.add_child(new_fruit)
	parent.get_parent().update_score(Global.fruit_scores[col_main.fruit_idx])

	col_main.queue_free()
	col_sub.queue_free()
