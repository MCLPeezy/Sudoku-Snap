extends Node


var start_time = OS.get_unix_time()

onready var label = get_node("Time")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_time()
	

func get_time():
	var time_now = OS.get_unix_time()
	var elapsed = time_now - start_time
	var seconds = elapsed % 60
	var hours = elapsed / 3600
	var minutes = (elapsed - (3600*hours)) / 60
	var elapsed_time = "%02d:%02d:%02d" % [hours, minutes, seconds]
	label.text = elapsed_time
