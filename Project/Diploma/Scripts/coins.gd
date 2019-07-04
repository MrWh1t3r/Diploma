extends Area2D

var score
var taken = false


func _physics_process(delta):
	if GameData.lvl < 5:
		$Sprite/anim.play("bronze")
		score = 10
	elif GameData.lvl < 10:
		$Sprite/anim.play("silver")
		score = 50
	elif GameData.lvl >= 10:
		$Sprite/anim.play("gold")
		score = 100

func _on_coins_body_entered(body):
	if taken != true:
		GameData.score += score
		taken = true
		hide()
	
