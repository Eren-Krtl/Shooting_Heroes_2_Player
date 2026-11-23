extends StaticBody2D

@export var UpgradeUI:PackedScene

func _ready() -> void:
	%P1Score.text = str(GlobalPlayer.P1.Score)
	%P2Score.text = str(GlobalPlayer.P2.Score)
	GlobalPlayer.Nodes.P1 = %Player_1
	GlobalPlayer.Nodes.P2 = %Player_2
	get_tree().paused = false

func _on_player_2_p_2_lost() -> void:
	print("p2 hp 0")
	GlobalPlayer.P1.Score += 1
	get_tree().paused = true
	if(GlobalPlayer.P1.Score == GlobalPlayer.ScoreToEnd):
		%WinningScreen.visible = true
	else:
		var PreUpgradeUI = UpgradeUI.instantiate()
		PreUpgradeUI.Target = "P2"
		add_child(PreUpgradeUI)

func _on_player_1_p_1_lost() -> void:
	print("p1 hp 0")
	GlobalPlayer.P2.Score += 1
	get_tree().paused = true
	if(GlobalPlayer.P1.Score == GlobalPlayer.ScoreToEnd):
		%WinningScreen.visible = true
	else:
		var PreUpgradeUI = UpgradeUI.instantiate()
		PreUpgradeUI.Target = "P1"
		add_child(PreUpgradeUI)

func _on_restart_button_pressed() -> void:
	GlobalPlayer.P1.Score = 0
	GlobalPlayer.P1.HP = 25.0
	GlobalPlayer.P1.Acceleration = 5.0
	GlobalPlayer.P1.MaxSpeed = 150.0
	GlobalPlayer.P1.BulletDamage = 5.0
	GlobalPlayer.P1.BulletCooldown = 0.5
	GlobalPlayer.P1.BulletSpeed = 400.0
	GlobalPlayer.P1.BulletRepeat = 0
	GlobalPlayer.P1.BulletSpread = 3.0
	GlobalPlayer.P2.Score = 0
	GlobalPlayer.P2.Speed = 100.0
	GlobalPlayer.P2.HP = 25.0
	GlobalPlayer.P2.Acceleration = 5.0
	GlobalPlayer.P2.MaxSpeed = 150.0
	GlobalPlayer.P2.BulletDamage = 5.0
	GlobalPlayer.P2.BulletCooldown = 0.5
	GlobalPlayer.P2.BulletSpeed = 400.0
	GlobalPlayer.P2.BulletRepeat = 0
	GlobalPlayer.P2.BulletSpread = 3.0
	get_tree().change_scene_to_file("res://main_game.tscn")
