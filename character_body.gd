extends CharacterBody3D

var initial_transform: Transform3D

func _ready() -> void:
	initial_transform = transform
	pass
	
func advance_physics(delta: float) -> void:
	if process_mode == PROCESS_MODE_DISABLED:
		return
		
	velocity = Vector3(0.6, -1, 0) * 16 * delta
	velocity *= delta / get_process_delta_time()
	move_and_slide()
	velocity /= delta / get_process_delta_time()
	
	move_and_collide(velocity * delta)
	
func reset_state() -> void:
	#PhysicsServer3D.body_set_state(get_rid(),PhysicsServer3D.BODY_STATE_LINEAR_VELOCITY, Vector3.ZERO)
	#PhysicsServer3D.body_set_state(get_rid(),PhysicsServer3D.BODY_STATE_ANGULAR_VELOCITY, Vector3.ZERO)
	#PhysicsServer3D.body_set_state(get_rid(),PhysicsServer3D.BODY_STATE_TRANSFORM, initial_transform)
	#JoltPhysicsServer3D.space_flush_queries(JoltPhysicsServer3D.body_get_space(get_rid()))
	transform = initial_transform
	velocity = Vector3.ZERO
	pass
