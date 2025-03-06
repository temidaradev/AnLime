extends CharacterBody3D

@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/Camera3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var bone_attachment_3d: BoneAttachment3D = $Skeleton3D/Face/BoneAttachment3D
@onready var bone_attachment_3d: BoneAttachment3D = $BoneAttachment3D

const SPEED = 5
const JUMP_VELOCITY = 4.5
const CAMERA_OFFSET = Vector3(0, 0.1, 0)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera.current = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.005)
		camera.rotate_x(-event.relative.y * 0.005)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90),deg_to_rad(90))
			
func _process(delta: float) -> void:
	camera.global_transform.origin = bone_attachment_3d.global_transform.origin 
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#animation_player.play("jump")

	var input_dir := Input.get_vector("a", "d", "w", "s") 
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		animation_player.play("mixamo_com")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		animation_player.play("idle")
	
	move_and_slide()
