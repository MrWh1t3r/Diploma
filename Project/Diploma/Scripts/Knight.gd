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

onready var DetectFloorLeft = $DetectFloorLeft
onready var DetectWallLeft = $DetectWallLeft
onready var DetectFloorRight = $DetectFloorRight
onready var DetectWallRight = $DetectWallRight

func _ready():
	attack_delay_timer = Timer.new()
	attack_delay_timer.set_one_shot(true)
	attack_delay_timer.set_wait_time(1.4)
	attack_delay_timer.connect("timeout", self, "attack_delay_timeout")
	add_child(attack_delay_timer)


func _physics_process(delta):
	if dead:
		$Sprite/anim.current_animation = "Death"
		yield($Sprite/anim, "animation_finished")
		print("1")
	if on_knight && attack && GameData.hit && GameData.hp > 0:
		GameData.hit = false
		is_attack = true
		GameData.damage_delay_timer.start()
		$Sprite/anim.current_animation = "Attack1"
		yield($Sprite/anim, "animation_finished")
		is_attack = false
		if on_knight:
			GameData.hp -= 1
		
	
	elif is_on_floor() && !dead && !is_attack:
		$Sprite/anim.play("Walk")
		velocity.x = direction * speed
		
		if not DetectFloorLeft.is_colliding() or DetectWallLeft.is_colliding():
			direction = 1.0
			$Sprite.set_scale(Vector2(-1,1))
			$Area2D.set_scale(Vector2(-1,1))

		if not DetectFloorRight.is_colliding() or DetectWallRight.is_colliding():
			direction = -1.0
			$Sprite.set_scale(Vector2(1,1))
			$Area2D.set_scale(Vector2(1,1))
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
