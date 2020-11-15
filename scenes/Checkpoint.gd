extends Area2D

# Create scence variables, allowing us to change where the player is sent
# based on the current scene
export(String, FILE, "*.tscn") var next_scence

# If the player is touching the checkpoint, send them to the next scene
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(next_scence)
