extends ColorRect

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused == true:
			show()
		else:
			hide()
		

func _on_Resume_pressed():
	get_tree().paused = false
	hide()


func _on_Menu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Menu.tscn")


func _on_Exit_pressed():
	get_tree().quit()
