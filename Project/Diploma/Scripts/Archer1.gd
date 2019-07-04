extends KinematicBody2D

#export (PackedScene) var Arrow 

#var arrow = preload("res://Scenes/Arrow.tscn")

const gravitation = 15
const speed = 200
const vectorTop = Vector2(0, -1) 

var arrowDirection = Vector2(-108, -73)
var velocity = Vector2()
var direction = -1

onready var DetectFloorLeft = $DetectFloorLeft
onready var DetectWallLeft = $DetectWallLeft
onready var DetectFloorRight = $DetectFloorRight
onready var DetectWallRight = $DetectWallRight

	

func _physics_process(delta):
	var arrow = load("res://Scenes/Arrow.tscn").instance()
	
	if Input.is_action_just_pressed("ui_action1"):
		get_node("Sprite/Position2D").add_child(arrow)
		if direction == 1.0:
			arrow.apply_scale(Vector2(-1,1))
			arrow.apply_impulse(Vector2(), Vector2(1000,0))
		else:
			arrow.apply_impulse(Vector2(), Vector2(-1000,0))
			arrow.apply_scale(Vector2(1,1))
		
	if is_on_floor():
		$Sprite/anim.play("Walk")
		velocity.x = direction * speed
		
		if !DetectFloorLeft.is_colliding() || DetectWallLeft.is_colliding():
			direction = 1.0
			arrowDirection = Vector2(108, -73)
			$Sprite.set_scale(Vector2(-1,1))

		if !DetectFloorRight.is_colliding() || DetectWallRight.is_colliding():
			direction = -1.0
			arrowDirection = Vector2(-108,-73)
			$Sprite.set_scale(Vector2(1,1))
	if !is_on_floor():
		velocity.y += gravitation
	move_and_slide(velocity, vectorTop)
	
func damaged():
	queue_free()