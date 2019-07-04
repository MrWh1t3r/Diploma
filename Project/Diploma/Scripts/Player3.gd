extends KinematicBody2D


onready var anim = get_node("Sprite/AnimationPlayer")

const UP = Vector2(0, -1)
const GRAVITY = 10
const ACCELERATION = 50
const MAX_SPEED = 180
const JUMP_HEIGHT = -380

var motion = Vector2()
var acc = Vector2()

var attack = false

func _physics_process(delta):
    motion.y += GRAVITY
    var friction = false

    acc.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

    if acc.x == 1 && !attack:
        $Sprite.flip_h = false
        motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
        if anim.current_animation != "Run" && is_on_floor():
            anim.play("Run")        
    elif acc.x == -1 && !attack:
        $Sprite.flip_h = true
        motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
        if anim.current_animation != "Run" && is_on_floor():
            anim.play("Run")
    else:
        if anim.current_animation != "Idle" && !attack && is_on_floor():
            anim.play("Idle")
        friction = true


    if Input.is_action_just_pressed("ui_up") && is_on_floor():
        motion.y = JUMP_HEIGHT

    if is_on_floor():
        if friction == true:
            motion.x = lerp(motion.x, 0, 0.2)   
        if Input.is_action_just_pressed("ui_action1"):
            attack = true
            anim.current_animation = "Attack"
            yield(anim, "animation_finished")
            attack = false
             
    else:
        if motion.y <= JUMP_HEIGHT*0.45:
            if anim.current_animation != "Jump":
                anim.play("Jump")
        if motion.y >= 0:
            motion.y += 8
        if motion.y >= JUMP_HEIGHT*0.45 && motion.y <= JUMP_HEIGHT*(-0.45): 
            if anim.current_animation != "Jump":
                anim.play("Jump")
        if motion.y > JUMP_HEIGHT*(-0.45):
            if anim.current_animation != "Jump":
                anim.play("Jump")
        if friction == true:
            motion.x = lerp(motion.x, 0, 0.2)
    motion = move_and_slide(motion, UP)
