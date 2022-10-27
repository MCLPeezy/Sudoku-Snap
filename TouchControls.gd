extends Camera2D

var shape
var shape_container = []
var space_state
var is_holding = false # Used when the player is actively holding a shape

class Tetro:
	var tetro_inst
	var game_object
	var origin: Vector2
	var value: int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var m_pos = get_global_mouse_position() # Basically just shorter to type out
	
	space_state = get_world_2d().direct_space_state
	
	if(Input.is_action_just_pressed("touch")):
		touch(m_pos)
		if(shape):
			shape.z_index = 3
	if(Input.is_action_just_released("touch") && shape):
		is_holding = false
		shape.position = snap_to_nearest_cell(m_pos)
		shape.z_index = 2
		shape = null
	
	# Lock the position of the shape to the mouse position
	if(is_holding && shape):
		shape.position = Vector2(m_pos.x, m_pos.y)

func snap_to_nearest_cell(pos):
	var vec = Vector2(0, 0) # this is what we'll use to be the new position for the shape
	var result = space_state.intersect_point(pos) # Raycast a point and return an array of everything hit
	
	if(len(result) == 2):
		if(result[0].collider.is_in_group("Blank")):
			vec = result[0].collider.get_parent().position - Vector2(-104, -96)
		elif(result[1].collider.is_in_group("Blank")):
			vec = result[1].collider.get_parent().position - Vector2(-104, -96)
		else:
			for s in shape_container:
				if(s.game_object == result[0].collider or s.game_object == result[1].collider):
					print(result)
					return s.origin
	elif(len(result) == 3):
		for s in shape_container:
			if(s.game_object == result[0].collider or s.game_object == result[1].collider or s.game_object == result[2].collider):
				return s.origin
	else:
		for s in shape_container:
			if(s.game_object == result[0].collider):
				return s.origin

	return vec

# When the player clicks / touches on a shape it picks it up and allows them to move it while held down
func touch(pos):
	
	# Raycast our mouse pos and see if we hit a draggable shape
	var result = space_state.intersect_point(pos)
	
	if(len(result) == 2):
		if(result[0].collider.is_in_group("Clickable")):
			if(len(shape_container) > 0):
				var result_index: int = 0
				for s in range(len(shape_container)):
					if(shape_container[s].game_object == result[0].collider):
						result_index += 1
				if(result_index == 0):
					create_tetro(result[0])
			else:
				create_tetro(result[0])
			shape = result[0].collider.get_parent()
			is_holding = true
			
		elif(result[1].collider.is_in_group("Clickable")):
			if(len(shape_container) > 0):
				var result_index: int = 0
				for s in range(len(shape_container)):
					if(shape_container[s].game_object == result[1].collider):
						result_index += 1
				if(result_index == 0):
					create_tetro(result[1])
			else:
				create_tetro(result[1])
			shape = result[1].collider.get_parent()
			is_holding = true
			
	elif(len(result) == 1):
		if(result[0].collider.is_in_group("Clickable")):
			if(len(shape_container) > 0):
				var result_index: int = 0
				
				for s in range(len(shape_container)):
					if(shape_container[s].game_object == result[0].collider):
						result_index += 1
				if(result_index == 0):
					create_tetro(result[0])
			else:
				create_tetro(result[0])
			shape = result[0].collider.get_parent()
			is_holding = true

func create_tetro(result):
	# Instance the class, assign it's variables of the clicked shape
	# then add it to the array so we can trace it
	var tetro_inst = Tetro.new()
	tetro_inst.origin = result.collider.get_parent().position
	tetro_inst.game_object = result.collider
	shape_container.append(tetro_inst)
	
