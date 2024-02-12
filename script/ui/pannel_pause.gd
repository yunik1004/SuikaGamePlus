extends Node

signal close
signal restart


func _on_close_button_pressed():
	emit_signal("close")


func _on_restart_button_pressed():
	emit_signal("restart")
