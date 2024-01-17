extends Control

@onready var timer = $Timer

func _ready():
	timer.start()

#func time_left_ingame():
#	var time_left = timer.time_left()
#	var minute = floor(time_left/60)
#	var seconds = int(time_left)%60
#	return [minute,seconds]

func _process(delta):
#	label.text = "%02d:%02d" % time_left_ingame()
	if $Timer.time_left != 0:
		$Seconds.text = "%02d" %int($Timer.time_left)

func _on_timer_timeout():
	$Seconds.text = "DUMMY WINS"
	await get_tree().create_timer(3.0).timeout
	get_tree().quit()
