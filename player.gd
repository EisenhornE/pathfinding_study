extends CharacterBody2D


@export var move_speed : float = 250
var character_direction : Vector2
@onready var sprite_2d = $Sprite2D
@onready var ap = $AnimationPlayer

# Typical Movement input
func _physics_process(delta):
	character_direction.x = Input.get_axis("ui_left","ui_right")
	character_direction.y = Input.get_axis("ui_up","ui_down")
	character_direction = character_direction.normalized()
	
	if character_direction:
		velocity = character_direction * move_speed
		if ap.current_animation != "walk" : ap.current_animation = "walk"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, move_speed)
		if ap.current_animation != "idle" : ap.current_animation = "idle"

	if character_direction.x > 0 : sprite_2d.flip_h = false
	elif character_direction.x < 0 : sprite_2d.flip_h = true
	
	move_and_slide()
