extends Node2D

var record = preload("res://Scenes/record.tscn")
var list = "Records/List"

var names = [GameData.name1, GameData.name2, GameData.name3, GameData.name4, GameData.name5]
var scores = [GameData.score1, GameData.score2, GameData.score3, GameData.score4, GameData.score5,]
var k = 0
var obj = {
	"sd" : 23,
	"grt" : 54,
	"sad" : 1,
	"kuku" : 100,
	"cs" : 66
}
var arr = [["sd", 23], ["grt",  54], ["sad", 1], ["kuku", 100], ["cs", 66]]

func _ready():
	for i in range(scores.size()):
		if scores[i] > 0:
			k+=1
	print(k)
	for i in range(k):
		var ra = record.instance()
		if names[i] != "":
			ra.get_node('Position').text = str(i+1)
			ra.get_node('Name').text = str(names[i])
			ra.get_node('Score').text = str(scores[i])
			$Records/List.add_child(ra)
			print(i)


	

	

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
#	var r = record.instance()
#	r.get_node("Name").text = "ujujkuj"
#	r.get_node("Score").text = "978978"
#	$Records/List.add_child(r)
	pass # Replace with function body.


func _on_Button2_pressed():
	var ar = record.instance()
	GameData.name = 'asdas'
	GameData.score = 345
	ar.get_node("Name").text = GameData.name
	ar.get_node("Score").text = str(GameData.score)
	$Records/List.add_child(ar)
#	get_node("res://Scenes/record.tscn").add_child(r)
#	arr.sort_custom(self, "mySort")
#	for i in arr:
#		print(i)
#	for o in obj.values():
#		print(o)
#	for i in obj:
#		print(i) 
	pass # Replace with function body.
 
func mySort(a,b):
	if a[0] < b[0]:
		return true
	return false