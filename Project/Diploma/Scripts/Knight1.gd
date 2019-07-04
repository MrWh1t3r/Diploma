extends KinematicBody2D

const gravitation = 15
const speed = 200
const vectorTop = Vector2(0, -1) 
var hp = 1
var dead = false

var velocity = Vector2()
var direction = -1

var on_knight = false
var attack_delay_timer = null
var attack = true
var is_attack = false

var state = ["Idle", "Walk"]
var currentState
var i
var r
var randstate = ["Idle", "Walk"]

onready var DetectFloorLeft = $DetectFloorLeft
onready var DetectWallLeft = $DetectWallLeft
onready var DetectFloorRight = $DetectFloorRight
onready var DetectWallRight = $DetectWallRight

func _ready():
	attack_delay_timer = Timer.new()
	attack_delay_timer.set_one_shot(true)
	attack_delay_timer.set_wait_time(2)
	attack_delay_timer.connect("timeout", self, "attack_delay_timeout")
	add_child(attack_delay_timer)


func _physics_process(delta):
	
	if on_knight && attack && GameData.hit && GameData.hp > 0:
		GameData.hit = false
		is_attack = true
		GameData.damage_delay_timer.start()
		$Sprite/anim.current_animation = "Attack1"
		yield($Sprite/anim, "animation_finished")
		is_attack = false
		if on_knight:
			GameData.hp -= 1

	
	
	
#	if on_knight && attack && GameData.hit && GameData.hp > 0:
##		$Sprite/anim.play("Attack1")
#		attack = false
#		GameData.damage_delay_timer.start()
#		#		GameData.damage_delay_timer.start()
#		$Sprite/anim.current_animation = "Attack1"
#		yield($Sprite/anim, "animation_finished")
#		GameData.hit = false
#		GameData.hp -= 1
#		is_attack = false
		
	elif is_on_floor():
		$Sprite/anim.play("Walk")
		velocity.x = direction * speed
		
#	if dead:
#		$Sprite/anim.current_animation = "Death"
#		yield($Sprite/anim, "animation_finished")
#		print("1")
#	if on_knight && attack && GameData.hit && GameData.hp > 0 && !dead:
#		GameData.hit = false
#		is_attack = true
#		GameData.damage_delay_timer.start()
#		$Sprite/anim.current_animation = "Attack1"
#		yield($Sprite/anim, "animation_finished")
#		is_attack = false
#		if on_knight:
#			GameData.hp -= 1
#
#
#	elif is_on_floor() && !dead && !is_attack:
#		currentState = state[randi() % state.size()]
#		print('randi')
#		if currentState == "Idle":
#			i = randi() % 3 + 1
#			r = i
#			print('1')
#			print(i)
#			while i != 0:
#				if on_knight && attack:
#					print('attack')
#					i = 0
#				print('current i')
#				print(i)
#				$Sprite/anim.current_animation = "Idle"
#				yield($Sprite/anim, "animation_finished")
#				print('animation finished')
#
#		if currentState == "Walk":
#			i = randi() % 6 + 1
#			r = i
#			print('walk')
#			while i != 0:
#				if on_knight && attack:
#					i = 0
#				$Sprite/anim.current_animation = "Walk"
#				yield($Sprite/anim, "animation_finished")
		
#		$Sprite/anim.play("Walk")
#		velocity.x = direction * speed
#		if $Sprite/anim.current_animation == "Walk":
#			velocity.x = direction * speed
#		else:
#			velocity.x = 0
#
		if not DetectFloorLeft.is_colliding() or DetectWallLeft.is_colliding():
			direction = 1.0
			$Sprite.set_scale(Vector2(-1,1))

		if not DetectFloorRight.is_colliding() or DetectWallRight.is_colliding():
			direction = -1.0
			$Sprite.set_scale(Vector2(1,1))
	if !is_on_floor():
		velocity.y += gravitation
	if !dead && !is_attack:
		move_and_slide(velocity, vectorTop)

func damaged():
	print("3")
	if hp > 0:
		hp -= GameData.playerDamage
		print("2")
	else:
		dead = true

func attack_delay_timeout():
	attack = true
	
func _on_Area2D_body_entered(body):
	on_knight = true


func _on_Area2D_body_exited(body):
	on_knight = false
