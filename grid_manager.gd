extends Node

class Grid:
	var grid = []
	var rows = [[],[],[],[],[],[],[],[],[]]
	var columns = [[],[],[],[],[],[],[],[],[]]
	var sub_grids = [[],[],[],[],[],[],[],[],[]]
	var grid_checker = [0, 0, 0, 0, 0, 0, 0, 0, 0]

class Block:
	var value: int
	var pos: Vector2
	var gameObject
	
onready var g = Grid.new()
onready var c = 0
onready var board = []
onready var grid_is_valid = false

export var grid_blank: PackedScene
export var grid_filled: PackedScene
export var GameWinScreen: PackedScene

var grid_file = str(Global.level)

var grid_contents = []

func _ready():
	grid_contents = read_grid_file(grid_file)
	generate_grid()
	organize_grid()
	
func _process(_delta):
	#check_grid()
	if(grid_is_valid == true):
		var game_over = GameWinScreen.instance()
		add_child(game_over)
		get_tree().paused = true

func read_grid_file(level):
	var f = File.new()
	var content = []
	
	f.open("res://Levels/" + str(Global.difficulty) + "/" + str(level) + ".xml", File.READ)
	
	for i in range(81):
		f.seek(i*3)
		content.append(f.get_line())
		
	board = content
	
	print(content)
	return content

func generate_grid():
	var n = 0
	for x in range(9):
		for y in range(9):
			var block_inst = Block.new()
			var inst
			
			if(str(board[n]) == "0"):
				inst = grid_blank.instance()
			else:
				inst = grid_filled.instance()
				inst.get_node("./Label").text = str(board[n])

			block_inst.gameObject = inst
			g.grid.append(block_inst)
			
			call_deferred("add_child", inst)
			
			block_inst.pos = Vector2(x*64, y*64)
			inst.position = Vector2(x*64, y*64)
			
			n += 1

func organize_grid():
	for i in g.grid:
		
		g.columns[i.pos.x/64].insert(int(abs(i.pos.y/64)), i)
		g.rows[abs(i.pos.y/64)].insert(int(i.pos.x/64), i)
		
		#Sub Grid X - 0
		if(i.pos.x/64 >= 0 and i.pos.x/64 <= 2):
			if(i.pos.y/64 >= 0 and i.pos.y/64 <= 2):
				g.sub_grids[0].append(i)
			elif(i.pos.y/64 >= 3 and i.pos.y/64 <= 5):
				g.sub_grids[3].append(i)
			elif(i.pos.y/64 >= 6 and i.pos.y/64 <= 8):
				g.sub_grids[6].append(i)
		
		#Sub Grid X - 1
		elif(i.pos.x/64 >= 3 and i.pos.x/64 <= 5):
			if(i.pos.y/64 >= 0 and i.pos.y/64 <= 2):
				g.sub_grids[1].append(i)
			elif(i.pos.y/64 >= 3 and i.pos.y/64 <= 5):
				g.sub_grids[4].append(i)
			elif(i.pos.y/64 >= 6 and i.pos.y/64 <= 8):
				g.sub_grids[7].append(i)
		
		#Sub Grid X - 3
		elif(i.pos.x/64 >= 6 and i.pos.x/64 <= 8):
			if(i.pos.y/64 >= 0 and i.pos.y/64 <= 2):
				g.sub_grids[2].append(i)
			elif(i.pos.y/64 >= 3 and i.pos.y/64 <= 5):
				g.sub_grids[5].append(i)
			elif(i.pos.y/64 >= 6 and i.pos.y/64 <= 8):
				g.sub_grids[8].append(i)

func check_grid():
	for c in g.grid_checker:
		if(sum_array(g.rows[c]) == 45 and sum_array(g.columns[c]) == 45 and sum_array(g.sub_grids[c]) == 45):
			g.grid_checker[c] = 1
			c += 1
			if(sum_array(g.grid_checker) == 9):
				grid_is_valid = true
		else:
			c = 0
			g.grid_checker = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	
func sum_array(array):
	var sum = 0
	for i in array:
		sum += i
	return sum

func randomize_grid():
	pass
