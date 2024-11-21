extends Node3D

@onready var rigid_body: RigidBody3D = $RigidBody
@onready var rigid_body2: RigidBody3D = $RigidBody2
@onready var character_body: CharacterBody3D = $CharacterBody

@onready var delta_time: float = (1.0/Engine.physics_ticks_per_second)
@onready var space: RID

var current_tick: int = 0
var delta_accumulator: float = 0
var physics_enabled: bool = false

func _ready() -> void:
	space = get_viewport().world_3d.space
	PhysicsServer3D.space_set_active(space, false) #disable space, will be advanced manually

func _process(delta: float) -> void:
	delta_accumulator += delta
	if delta_accumulator > delta_time:
		_process_tick()
		delta_accumulator -= delta_time
		
func _process_tick() -> void:
	if !physics_enabled:
		return
		
	print("PROC ", current_tick, ":", rigid_body.position)
	_advance_tick()
	
func _on_advance_ticks() -> void:
	for i in 16:
		print("LOOP ", current_tick, ":", rigid_body.position)
		_advance_tick()
		
func _advance_tick() -> void:
	character_body.advance_physics(delta_time)
	JoltPhysicsServer3D.space_flush_queries(space)
	JoltPhysicsServer3D.space_step(space, delta_time)
	current_tick += 1
	
func _rollback_position() -> void:
	current_tick = 0
	rigid_body.reset_state()
	rigid_body2.reset_state()
	character_body.reset_state()
	print("Bodies state was reset!")

func _on_restart_pressed() -> void:
	_rollback_position()
	
func _on_area_3d_body_entered(b: Node3D) -> void:
	print("At tick ", current_tick, " body ", b.name, " entered area!")

func _on_enable_physics_pressed() -> void:
	physics_enabled = !physics_enabled
