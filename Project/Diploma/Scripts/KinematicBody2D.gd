extends KinematicBody2D

var velocity = Vector2()
const SLOPE_STOP = 500
const VectorTop = Vector2(0, -1)
var speed = GameData.speed
var gravity = GameData.gravity
var jump_velocity = GameData.jump_velocity
var is_grounded
var attack = false
var a = 0
var animation_finished = false

var attacking = false

onready var raycasts = $RayCasts
onready var anim = get_node("Sprite/anim")

func _physics_process(delta):
	if GameData.hp > 0:
		_get_input()
		velocity = move_and_slide(velocity, VectorTop)
		is_grounded = _check_is_grounded()
		_assign_animation()
		if is_grounded:
			speed = GameData.speed
		else:
			speed = GameData.speed - 150
		
		
	else:
		if GameData.dead != true:
			$Sprite/anim.play("Death")
			GameData.dead = true
#			$Camera2D.current = false
			$HUD/DeathMenu/Score.text = str(GameData.score)
			$HUD/DeathMenu.show()
			
	velocity.y += gravity * delta 

	$HUD/HP.text = "HP " + str(GameData.hp) + "/" + str(GameData.maxHP)
	$HUD/SCORE.text = "SCORE " + str(GameData.score)
	

func _input(event):
	if event.is_action_pressed("ui_up") && is_grounded:
		velocity.y = jump_velocity
	if event.is_action_pressed("ui_action1") && GameData.attack:
		attack = true


func _get_input():
	var move_direction = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	velocity.x = lerp(velocity.x, speed * move_direction, _get_h_weight())
	if move_direction !=0:
		$Sprite.scale.x = move_direction

func _get_h_weight():
	return 1 if is_grounded else 0.1
	
func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false
	
func _assign_animation():
		
	if attack:
		GameData.attack = false
		anim.current_animation = "Attack"
		GameData.attack_delay_timer.start()
		yield(anim, "animation_finished")
		attack = false
		
	elif !is_grounded && !attack:
		$Sprite/anim.play("Jump")
	elif velocity.x !=0 && !attack:
		$Sprite/anim.play("Run")
	elif GameData.hp < 1:
		$Sprite/anim.play("Death")
	else:
		if !attack:
			$Sprite/anim.play("Idle")

func die():
	$Camera2D.current = false
	
	pass
	
func _on_VisibilityNotifier2D_screen_exited():
	yield(anim, "animation_finished")
	GameData.hp = 0
	
#func _on_AttackArea_body_entered(body):
#	if body.has_method("damaged"):
#		body.call("damaged")
#	pass # Replace with function body.
#
#
#func _on_RigidBody2D_body_entered(body):
#	if body.has_method("damaged"):
#		body.call("damaged")
#	pass # Replace with function body.

