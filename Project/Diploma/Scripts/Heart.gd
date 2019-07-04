extends Node2D

var taken = false

func _on_Area2D_body_entered(body):
	if GameData.maxHP > GameData.hp && taken != true:
		GameData.hp += 1
		taken = true
		hide()
