extends KinematicBody2D

const gravitation = 15
const speed = 200
const vectorTop = Vector2(0, -1) 

var velocity = Vector2()
var direction = -1
var attack_delay_timer = null
var attack = true
var on_warrior = false

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
		$Sprite/anim.play("Attack1")
		GameData.hit = false
		GameData.hp -= 1
		GameData.damage_delay_timer.start()
		
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
	move_and_slide(velocity, vectorTop)
	
func attack_delay_timeout():
	attack = true



func _on_Area2D_body_entered(body):
	on_warrior = true

func _on_Area2D_body_exited(body):
	on_warrior = false


