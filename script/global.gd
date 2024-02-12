extends Node

const fruit_names: Array[StringName] = ["0_cherry", "1_strawberry", "2_grape", "3_orange", "4_persimmon", "5_apple", "6_pear", "7_peach", "8_pineapple", "9_melon", "10_watermelon"]
const fruit_scores: Array[int] = [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22]
var scenes_fruit: Array[PackedScene] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for fruit_name in fruit_names:
		var path: String = "res://scene/fruit/%s.tscn" % [fruit_name]
		var scene: PackedScene = load(path)
		scenes_fruit.append(scene)
