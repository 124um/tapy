extends Node2D

class_name Pipes

const OFF_SCREEN: float = -500.0
@onready var score_sound: AudioStreamPlayer = $ScoreSound


func _ready() -> void:
	SignalManager.on_plane_died.connect(on_plane_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -=delta * GameManager.SCROLL_SPEED
	check_off_screen()

func check_off_screen() -> void:
	if position.x < OFF_SCREEN:
		queue_free()

func on_plane_died() -> void:
	set_process(false)

func _on_screen_exited() -> void:
	queue_free()

func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Tapy:
		body.die()
		
	#if body.is_in_group(GameManager.GROUP_PLANE) == true:
		#if body.has_method("die") == true:
			#body.die()

func _on_laser_body_entered(body: Node2D) -> void:
	if body is Tapy:
		score_sound.play()
		ScoreManager.increment_score()