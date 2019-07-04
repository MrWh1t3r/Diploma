extends KinematicBody2D

const gravitation = 15
const speed = 200
const vectorTop = Vector2(0, -1) 

var velocity = Vector2()
var direction = -1

onready var DetectFloorLeft = $DetectFloorLeft
onready var DetectWallLeft = $DetectWallLeft
onready var DetectFloorRight = $DetectFloorRight
onready var DetectWallRight = $DetectWallRight

func _physics_process(delta):
	
	if is_on_floor():
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