extends ColorRect

var pause = false

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused == true:
			show()
		else:
			hide()
		
func _physics_process(delta):
	if pause:
		get_tree().paused = true
		show()

func _on_Resume_pressed():
	get_tree().paused = false
	pause = false
	hide()


func _on_Menu_pressed():
	get_tree().paused = false
	pause = false
	get_tree().change_scene("res://Scenes/Menu.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_PauseButton_pressed():
	pause = true
	pass # Replace with function body.
