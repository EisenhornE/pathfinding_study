extends CharacterBody2D

var move_speed = 150.0
@export var target : Node2D = null
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var ap = $AnimationPlayer
@onready var sprite_2d = $Sprite2D


func _ready():
	call_deferred("seeker")

func seeker():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position

func _physics_process(delta):
	if target:
		navigation_agent_2d.target_position = target.global_position
	if navigation_agent_2d.is_navigation_finished():
		return

	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * move_speed
	
	sprite_2d.flip_h = false if velocity.x > 0 else true
	if velocity.x && velocity.y != 0:
		ap.current_animation = "walk"

	move_and_slide()
