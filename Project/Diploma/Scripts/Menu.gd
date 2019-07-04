extends Node2D

var HighScores = preload("res://Scenes/HighScores.tscn")

func _on_Play_pressed():
	GameData.key = 0
	GameData.dead = false
	GameData.score = 0
	GameData.hp = 5
	GameData.lvl = 1
	get_tree().change_scene(GameData.locations[randi() % GameData.locations.size()])

func _on_Exit_pressed():
	get_tree().quit()


func _on_High_Scores_pressed():
	get_tree().change_scene("res://Scenes/HighScores.tscn")