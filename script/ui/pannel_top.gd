extends Node

signal pause

var textures_fruit: Array[Texture2D] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	for fruit_name in Global.fruit_names:
		var path: String = "res://asset/image/fruit/%s.svg" % [fruit_name]
		var texture: Texture2D = load(path)
		textures_fruit.append(texture)


func set_score(score: int, score_best: int):
	$Score.text = "Score: %d\nBest Score: %d" % [score, score_best]


func set_next_fruit(fdx: int):
	$Next/Holder/FruitImage.texture = textures_fruit[fdx]


func _on_pause_button_pressed():
	emit_signal("pause")
