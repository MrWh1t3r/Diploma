extends Node2D


func _on_Area2D_body_entered(body):
	GameData.key = 1
	hide()

