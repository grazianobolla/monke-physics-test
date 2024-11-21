extends CharacterBody3D

var initial_state: PackedByteArray
var initial_transform: Transform3D
var space: RID 

func _ready() -> void:
	space = get_viewport().world_3d.space
	initial_transform = transform
	initial_state = JoltPhysicsServer3D.save_body_state(space, get_rid())
	pass
	
func advance_physics(delta: float) -> void:
	if process_mode == PROCESS_MODE_DISABLED:
		return
	
	velocity = Vector3(1, -4, 0) * delta
	velocity /= get_process_delta_time()
	move_and_slide()
	velocity *= get_process_delta_time()	

func reset_state() -> void:
	#JoltPhysicsServer3D.restore_body_state(space, get_rid(), initial_state)
	JoltPhysicsServer3D.body_set_state(get_rid(),PhysicsServer3D.BODY_STATE_LINEAR_VELOCITY, Vector3.ZERO)
	JoltPhysicsServer3D.body_set_state(get_rid(),PhysicsServer3D.BODY_STATE_ANGULAR_VELOCITY, Vector3.ZERO)
	JoltPhysicsServer3D.body_set_state(get_rid(),PhysicsServer3D.BODY_STATE_TRANSFORM, initial_transform)
	velocity = Vector3.ZERO
	transform = initial_transform
	pass
