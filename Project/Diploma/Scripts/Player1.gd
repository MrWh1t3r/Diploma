extends KinematicBody2D



enum STATE {idle, run, jump, dead, attack}
var state
const g = 20
var gravitation = 15
const speed = 600
const jump = 700
const vectorTop = Vector2(0, -1) 


var velocity = Vector2()
#var idle = true

func isAboveGround():  #Used because is_on_floor() doesn't always return true after pushing out
	if is_on_floor():  return true
	return test_move(transform, Vector2(0,2), true)

func _ready():
	$Sprite/anim.set_blend_time("Attack", "Run", 1.8)
	$Sprite/anim.set_blend_time("Attack", "Jump", 1.8)
	$Sprite/anim.set_blend_time("Run", "Attack", 1.8)
	$Sprite/anim.set_blend_time("Jump", "Attack", 1.8)
	$Sprite/anim.set_blend_time("Idle", "Attack", 1.8)

func _physics_process(delta):
	
	if GameData.hp > 0:
		if Input.is_action_pressed('ui_left'):
			velocity.x = -speed
			$Sprite.set_scale(Vector2(-1,1))
			if isAboveGround():
				$Sprite/anim.play("Run")
	
		elif Input.is_action_pressed('ui_right'):
			velocity.x = speed
			$Sprite.set_scale(Vector2(1,1))
			if isAboveGround():
				$Sprite/anim.play("Run")
	
		else:
			velocity.x = 0
		if velocity.x == 0 && isAboveGround():
			$Sprite/anim.play("Idle")
		if !isAboveGround():
			gravitation = g
			velocity.y += gravitation
		if isAboveGround():
			gravitation = 0
	
		if isAboveGround() && Input.is_action_pressed('ui_up'):
			velocity.y = -jump
	
		if !isAboveGround() && !Input.is_action_pressed('ui_action1'):
			$Sprite/anim.play("Jump")
		elif !isAboveGround() && Input.is_action_pressed("ui_action1"):
			$Sprite/anim.play("Attack")
	
		if Input.is_action_just_pressed('ui_action1'):
			$Sprite/anim.play("Attack")
	
	#	if Input.is_action_pressed('ui_left') || Input.is_action_pressed('ui_right') || Input.is_action_pressed('ui_up') || Input.is_action_just_pressed('ui_action1') || is_on_floor() == false:
	#		idle = false
	#	else:
	#		if is_on_floor():
	#			idle = true
	#			$AnimatedSprite.play("Idle")
	
		
		move_and_slide(velocity, vectorTop)
	else:
		$Sprite/anim.play("Death")