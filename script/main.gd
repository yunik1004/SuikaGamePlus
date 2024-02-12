extends Node2D

signal score_update
signal game_end

@export var fruit_init_pos_y_offset: int = -30

var score: int = 0
var score_best: int = 0
var turn_current: int
var fruit_idx_current: int
var fruit_idx_next: int
var _fruit_init_pos: Vector2
var _fruit_current: Fruit

@onready var _box = $Background/Box


# Called when the node enters the scene tree for the first time.
func _ready():
	_fruit_init_pos = Vector2(_box.pos.x, _box.top - _box.border + fruit_init_pos_y_offset)
	_initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_pos: float = get_global_mouse_position().x
	_fruit_current.position.x = clamp(mouse_pos, _box.left + _fruit_current.radius, _box.right - _fruit_current.radius)
	_fruit_current.position.y = _fruit_init_pos.y


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not event.pressed:
				_fruit_current.activate_rigidbody()
				_change_turn()


func _on_gui_restart():
	_initialize()


func _initialize():
	if score > score_best:
		score_best = score
	score = 0
	emit_signal("score_update")
	turn_current = -1
	fruit_idx_next = _sample_fruit_idx(turn_current)
	for child in $Fruits.get_children():
		$Fruits.remove_child(child)
		child.queue_free()
	_change_turn()


func _change_turn():
	turn_current += 1
	fruit_idx_current = fruit_idx_next
	fruit_idx_next = _sample_fruit_idx(turn_current + 1)
	$GUI/TopPannel.set_next_fruit(fruit_idx_next)

	_fruit_current = Global.scenes_fruit[fruit_idx_current].instantiate()
	_fruit_current.name = "%s_%d" % [Global.fruit_names[fruit_idx_current], turn_current]
	_fruit_current.deactivate_rigidbody()
	_fruit_current.set_position(_fruit_init_pos)
	$Fruits.add_child(_fruit_current)


func _sample_fruit_idx(turn: int) -> int:
	var probs: Array[float] = [0.2, 0.2, 0.2, 0.2, 0.2]
	if turn < 2:
		probs = [1, 0, 0, 0, 0]
	elif turn < 4:
		probs = [0.5, 0.5, 0, 0, 0]
	elif turn < 8:
		probs = [0.34, 0.33, 0.33, 0, 0]
	elif turn < 16:
		probs = [0.25, 0.25, 0.25, 0.25, 0]

	var random_float: float = randf()
	var prob_tmp: float = 0
	for pdx in len(probs):
		prob_tmp += probs[pdx]
		if random_float <= prob_tmp:
			return pdx

	return 0


func update_score(score_plus: int):
	score += score_plus
	emit_signal("score_update")


func _on_box_full():
	emit_signal("game_end")
