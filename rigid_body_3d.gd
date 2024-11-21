extends RigidBody3D

var initial_transform: Transform3D

func _ready() -> void:
	initial_transform = transform
	pass

func reset_state() -> void:
	var rid = get_rid()
	PhysicsServer3D.body_set_state(rid, PhysicsServer3D.BODY_STATE_LINEAR_VELOCITY, Vector3.ZERO)
	PhysicsServer3D.body_set_state(rid, PhysicsServer3D.BODY_STATE_ANGULAR_VELOCITY, Vector3.ZERO)
	PhysicsServer3D.body_set_state(rid, PhysicsServer3D.BODY_STATE_TRANSFORM, initial_transform)
	JoltPhysicsServer3D.space_flush_queries(JoltPhysicsServer3D.body_get_space(rid))
	pass
