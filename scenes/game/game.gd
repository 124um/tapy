extends Node2D

const PIPES: PackedScene = preload("res://scenes/pipes/pipes.tscn")

@onready var spawn_u: Marker2D = $SpawnU
@onready var spawn_l: Marker2D = $SpawnL
@onready var spawn_timer: Timer = $SpawnTimer
@onready var pipes_holder: Node2D = $PipesHolder


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.set_score(0)
	SignalManager.on_plane_died.connect(_on_plane_died)
	spawn_pipes()
	#var p = get_tree().get_first_node_in_group("Plane")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer.wait_time = randf_range(1.2, 3.2)

func spawn_pipes() -> void:
	var new_pipes: Pipes = PIPES.instantiate()
	var yp: float = randf_range(spawn_u.position.y, spawn_l.position.y)
	pipes_holder.add_child(new_pipes)
	new_pipes.global_position = Vector2(spawn_l.position.x, yp)

#func stop_pipes() -> void:
	#spawn_timer.stop()	
	#for pipe in pipes_holder.get_children():
		#pipe.set_process(false)
	
func _on_spawn_timer_timeout() -> void:
	spawn_pipes()

func _on_plane_died() -> void:
	spawn_timer.stop()	
	#stop_pipes() 
