extends Node

var hp = 5
var maxHP = 5
var score = 0
var lvl = 1
var key = 0
var playerDamage = 1
var speed = 600
var gravity = 1225
var jump_velocity = -780 
var dead = false
var hit = true
var attack = true
var attack_delay_timer = null
var damage_delay_timer = null
var hit_delay = 1
var locations = ["res://Locations/Location1.tscn", "res://Locations/Location2.tscn", "res://Locations/Location3.tscn"]

var name1 = ""
var name2 = ""
var name3 = "" 
var name4 = ""
var name5 = ""
var score1 = 0
var score2 = 0
var score3 = 50
var score4 = 0
var score5 = 0

var HighScore = {
	'stepa' : 50,
	'Fred' : 123,
	'Georg' : 23
}

var interapt = false

func _ready():
	damage_delay_timer = Timer.new()
	damage_delay_timer.set_one_shot(true)
	damage_delay_timer.set_wait_time(hit_delay)
	damage_delay_timer.connect("timeout", self, "damage_delay_timeout")
	add_child(damage_delay_timer)
	
	attack_delay_timer = Timer.new()
	attack_delay_timer.set_one_shot(true)
	attack_delay_timer.set_wait_time(0.1)
	attack_delay_timer.connect("timeout", self, "attack_delay_timeout")
	add_child(attack_delay_timer)
	
	
func damage_delay_timeout():
	hit = true
	
func attack_delay_timeout():
	attack = true
	
