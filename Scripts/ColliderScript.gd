extends Node2D

var p1FightColl = []
var disableColl = true

# Called when the node enters the scene tree for the first time.
func _ready():
	_Handle_All_Collider_Disabling(disableColl)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_fist_colliders_body_entered(body):
	$PunchSound.play()
	if(body.name == "Dummy"):
		print("-----")
		print("Ouch !!")
		print("-----")


func _on_foot_colliders_body_entered(body):
	$PunchSound.play()
	if(body.name == "Dummy"):
		print("-----")
		print("Ouch !!")
		print("-----")

func _Handle_All_Collider_Disabling(isDisabled):
	for colliders in get_tree().get_nodes_in_group("P1 Fist Foot Coll"):
		var h = 0

		p1FightColl.insert(h, colliders)
		p1FightColl[h].set_disabled(isDisabled)

		print(p1FightColl[h].name)

#		if(p1FightColl[h].is_disabled()):
#			print(p1FightColl[h].name + " is disabled")
#		elif(!p1FightColl[h].is_disabled()):
#			print(p1FightColl[h].name + " is NOT disabled")

		print("")
		h += 1

func _Handle_Specific_Collider_Disabling(isDisabled, pickedColl):
	p1FightColl[pickedColl].set_disabled(isDisabled)

#	if(!p1FightColl[pickedColl].is_disabled()):
#		print(p1FightColl[pickedColl].name + " has been enabled")
#	elif(p1FightColl[pickedColl].is_disabled()):
#		print(p1FightColl[pickedColl].name + " has been DIS-abled")
