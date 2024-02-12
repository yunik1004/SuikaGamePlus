extends RigidBody2D
class_name Fruit

var radius: float


# Called when the node enters the scene tree for the first time.
func _ready():
	radius = $CollisionShape2D.shape.radius * $CollisionShape2D.scale.x


func deactivate_rigidbody():
	self.freeze = true
	self.lock_rotation = true
	$CollisionShape2D.disabled = true


func activate_rigidbody():
	self.freeze = false
	self.lock_rotation = false
	$CollisionShape2D.disabled = false
