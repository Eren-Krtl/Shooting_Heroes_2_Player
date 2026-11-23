extends Control

func _on_start_button_pressed() -> void:
	GlobalPlayer.ScoreToEnd = int(%ScoreValue.text)
	if(GlobalPlayer.ScoreToEnd >= 1):
		get_tree().change_scene_to_file("res://main_game.tscn")
