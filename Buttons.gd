extends Button

#Basic Buttons
func _on_PlayButton_pressed():
	get_tree().change_scene("res://DifficultyMenu.tscn")

func _on_SettingsButton_pressed():
	pass # Replace with function body.

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
	
func _on_BackButton_pressed():
	get_tree().change_scene("res://Main Menu.tscn")
	
	
#Difficulty Selectors
func _on_EasyButton_pressed():
	Global.difficulty = "Easy"
	get_tree().change_scene("res://LevelSelector.tscn")

func _on_MediumButton_pressed():
	Global.difficulty = "Medium"
	get_tree().change_scene("res://LevelSelector.tscn")

func _on_HardButton_pressed():
	Global.difficulty = "Hard"
	get_tree().change_scene("res://LevelSelector.tscn")


#Level Selectors
func _on_1_Button_pressed():
	Global.level = str(Global.difficulty) + "1"
	get_tree().change_scene("res://Levels/" + str(Global.difficulty) + "/" + str(Global.level) + ".tscn")
