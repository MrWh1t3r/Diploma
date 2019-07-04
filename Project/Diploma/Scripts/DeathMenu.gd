extends ColorRect

var camera = "../../Camera2D"

func _on_Okay_pressed():
	GameData.name = $Name.text
	print(name)
	if GameData.score > GameData.score1:
		GameData.score5 = GameData.score4
		GameData.score4 = GameData.score3
		GameData.score3 = GameData.score2
		GameData.score2 = GameData.score1
		GameData.score1 = GameData.score
		GameData.name5 = GameData.name4
		GameData.name4 = GameData.name3
		GameData.name3 = GameData.name2
		GameData.name2 = GameData.name1
		GameData.name1 = GameData.name
	elif GameData.score > GameData.score2:
		GameData.score5 = GameData.score4
		GameData.score4 = GameData.score3
		GameData.score3 = GameData.score2
		GameData.score2 = GameData.score
		GameData.name5 = GameData.name4
		GameData.name4 = GameData.name3
		GameData.name3 = GameData.name2
		GameData.name2 = GameData.name
	elif GameData.score > GameData.score3:
		GameData.score5 = GameData.score4
		GameData.score4 = GameData.score3
		GameData.score3 = GameData.score
		GameData.name5 = GameData.name4
		GameData.name4 = GameData.name3
		GameData.name3 = GameData.name
	elif GameData.score > GameData.score4:
		GameData.score5 = GameData.score4
		GameData.score4 = GameData.score
		GameData.name5 = GameData.name4
		GameData.name4 = GameData.name
	elif GameData.score > GameData.score5:
		GameData.score5 = GameData.score
		GameData.name5 = GameData.name
	$"../../Camera2D".current = true
	get_tree().change_scene("res://Scenes/Menu.tscn")
	pass # Replace with function body.
