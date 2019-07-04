extends KinematicBody2D

const gravitation = 15
const speed = 200
const vectorTop = Vector2(0, -1) 

var velocity = Vector2()
var direction = -1
var attack_delay_timer = null
var attack = true
var on_warrior = false
var is_attack = false

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
	if on_warrior && attack && GameData.hit && GameData.hp > 0:
		GameData.hit = false
		print("asdas")
		is_attack = true
		GameData.damage_delay_timer.start()
		print('2')
		$Sprite/anim.current_animation = "Death"
		yield($Sprite/anim, "animation_finished")
		print('1')
		is_attack = false
		if on_warrior:
			GameData.hp -= 1
		
	elif is_on_floor():
		$Sprite/anim.play("Walk")
		velocity.x = direction * speed
		
		if not DetectFloorLeft.is_colliding() or DetectWallLeft.is_colliding():
			direction = 1.0
			$Sprite.set_scale(Vector2(-1,1))

		if not DetectFloorRight.is_colliding() or DetectWallRight.is_colliding():
			direction = -1.0
			$Sprite.set_scale(Vector2(1,1))
	if !is_on_floor():
		velocity.y += gravitation
	if !is_attack:
		move_and_slide(velocity, vectorTop)
	
func attack_delay_timeout():
	attack = true



func _on_Area2D_body_entered(body):
	on_warrior = true

func _on_Area2D_body_exited(body):
	on_warrior = false


