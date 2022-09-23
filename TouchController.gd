extends Camera2D

var is_holding = false
var shape

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("touch"):
		touch(get_global_mouse_position())
		
	elif Input.is_action_just_released("touch"):
		is_holding = false
		if shape:
			shape.z_index = 0
			release(get_global_mouse_position())
		
	if is_holding:
		shape.position = get_global_mouse_position()
		shape.z_index = 2

func touch(pos):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(pos,pos)
	
	if result:
		#print(result.position, result.collider.get_parent().get_groups())
		if result.collider.is_in_group("Clickable"):
			shape = result.collider.get_parent()
			is_holding = true
	
func release(pos):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(pos,pos)
	
	if result:
		#print(result.position, result.collider.get_parent().get_groups())
		if result.collider.is_in_group("Blank"):
			shape.position = result.collider.get_parent().position
			print (result.collider.position)
