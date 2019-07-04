extends KinematicBody2D

const gravitation = 15
const speed = 600
const jump = 600
const vectorTop = Vector2(0, -1) 

var velocity = Vector2()
#var idle = true

func _physics_process(delta):
		
	if Input.is_action_pressed('ui_left'):
		velocity.x = -speed
		$AnimatedSprite.flip_h = true
		if is_on_floor():
			$AnimatedSprite.play("Run")
		
	elif Input.is_action_pressed('ui_right'):
		velocity.x = speed
		$AnimatedSprite.flip_h = false
		if is_on_floor():
			$AnimatedSprite.play("Run")
		
	else:
		velocity.x = 0
	if velocity.x == 0 && is_on_floor():
		$AnimatedSprite.play("Idle")
	if !is_on_floor():
		velocity.y += gravitation
	
	if is_on_floor() && Input.is_action_pressed('ui_up'):
		velocity.y = -jump
	
	if !is_on_floor() && !Input.is_action_pressed('ui_action1'):
		$AnimatedSprite.play("Jump")
	elif !is_on_floor() && Input.is_action_pressed("ui_action1"):
		$AnimatedSprite.play("Attack")
		
	if Input.is_action_just_pressed('ui_action1'):
		$AnimatedSprite.play("Attack")
	
#	if Input.is_action_pressed('ui_left') || Input.is_action_pressed('ui_right') || Input.is_action_pressed('ui_up') || Input.is_action_just_pressed('ui_action1') || is_on_floor() == false:
#		idle = false
#	else:
#		if is_on_floor():
#			idle = true
#			$AnimatedSprite.play("Idle")
	
	
	move_and_slide(velocity, vectorTop)