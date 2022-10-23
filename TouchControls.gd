extends Camera2D

var shape # The currently held object #starting position of shape
var shape_container = []

var is_holding = false # Used when the player is actively holding a shape

class Tetro:
	var game_object
	var origin: Vector2
	var value: int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var m_pos = get_global_mouse_position() # Basically just shorter to type out
	
	if(Input.is_action_just_pressed("touch")):
		touch(m_pos)
		if(shape):
			shape.z_index = 3
	elif(Input.is_action_just_released("touch") && shape):
		is_holding = false
		shape.position = snap_to_nearest_cell(m_pos)
		shape.z_index = 2
		shape = null
	
	# Lock the position of the shape to the mouse position
	if(is_holding && shape):
		shape.position = Vector2(m_pos.x, m_pos.y)


func snap_to_nearest_cell(pos):
	var vec = Vector2(0, 0) # this is what we'll use to be the new position for the shape
	
	var space_state = get_world_2d().direct_space_state
	
	# Raycast a point and return an array of everything hit
	var result = space_state.intersect_point(pos)
	
	if("Block Piece" in result[0].collider.get_parent().name):
		print("It did it")
		
	if("Brick Piece" in result[0].collider.get_parent().name):
		print("It did it")
		
	if("Line Piece" in result[0].collider.get_parent().name):
		print("It did it")
		
	if("LJ Piece" in result[0].collider.get_parent().name):
		print("It did it")
		
	if("Plus Piece" in result[0].collider.get_parent().name):
		print("It did it")
		
	if("Square Piece" in result[0].collider.get_parent().name):
		print("It did it")
		
	if("SZ Piece" in result[0].collider.get_parent().name):
		print("It did it")
	
	if("T Piece" in result[0].collider.get_parent().name):
		print("It did it")
	
	if(len(result) > 1 && result[1].collider.is_in_group("Blank")):
		print(result)
		# Result is an array so we have to loop over it when we move shapes on the
		# grid itself otherwise it doesn't detect properly
		for coll in result:
			if(!coll.collider.is_in_group("Clickable")):
				if(!coll.collider.is_in_group("Filled")):
					# I am unsure why we have to subtract this large vector, but it works
					vec = coll.collider.get_parent().position - Vector2(-104, -96)
					print(vec)
					
	else:
		for s in shape_container:
			if(s.game_object == result[0].collider):
				return s.origin
	
	return vec


# When the player clicks / touches on a shape it picks it up and allows them to move it while held down
func touch(pos):
	var space_state = get_world_2d().direct_space_state
	
	# Raycast our mouse pos and see if we hit a draggable shape
	var result = space_state.intersect_point(pos)
	
	if(result):
		if(result[0].collider.is_in_group("Clickable")):
			if(len(shape_container) > 0):
				var result_index: int = 0
				
				# Count the number of times we find the shape in our array
				# If it's 0 then we create a new Tetro instance
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
	
	print("New Tetro: ", tetro_inst.origin, " ", tetro_inst.game_object.get_parent().name)
		
