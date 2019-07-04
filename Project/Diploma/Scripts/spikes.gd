extends Node2D

var on_spikes = false

func _physics_process(delta):
	hit()

func hit():
	if GameData.hit && on_spikes && GameData.dead != true:
		GameData.hp -= 1
		GameData.hit = false
		GameData.damage_delay_timer.start()

func _on_Area2D_body_entered(body):
	on_spikes = true

func _on_Area2D_body_exited(body):
	on_spikes = false

