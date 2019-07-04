extends Node2D

var entered = false

func _process(delta):
	if GameData.key == 1:
		$Sprite/anim.play("Open")
		if Input.is_action_just_pressed("ui_interaction") && entered :
			get_tree().change_scene(GameData.locations[randi() % GameData.locations.size()])
			GameData.key  = 0
			GameData.lvl += 1
	else:
		$Sprite/anim.play("Close")


func _on_Area2D_body_entered(body):
	entered = true


func _on_Area2D_body_exited(body):
	entered = false
