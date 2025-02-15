extends Node3D

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
