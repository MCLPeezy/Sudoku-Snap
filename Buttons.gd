extends Button

#Basic Buttons
func _on_PlayButton_pressed():
	get_tree().change_scene("res://DifficultyMenu.tscn")

func _on_SettingsButton_pressed():
	pass # Replace with function body.

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
	
func _on_BackButton_pressed():
	if(str(Global.back_button) == "res://DifficultyMenu.tscn"):
		get_tree().change_scene(str(Global.back_button))
		Global.back_button = "res://MainMenu.tscn"
	else:
		get_tree().change_scene("res://MainMenu.tscn")
	
	
#Difficulty Selectors
func _on_EasyButton_pressed():
	Global.difficulty = "Easy"
	Global.back_button = "res://DifficultyMenu.tscn"
	get_tree().change_scene("res://LevelSelector.tscn")

func _on_MediumButton_pressed():
	Global.difficulty = "Medium"
	Global.back_button = "res://DifficultyMenu.tscn"
	get_tree().change_scene("res://LevelSelector.tscn")

func _on_HardButton_pressed():
	Global.difficulty = "Hard"
	Global.back_button = "res://DifficultyMenu.tscn"
	get_tree().change_scene("res://LevelSelector.tscn")


#Level Selectors
func _on_1_Button_pressed():
	Global.level = str(Global.difficulty) + "1"
	get_tree().change_scene("res://Levels/" + str(Global.difficulty) + "/" + str(Global.level) + ".tscn")
