extends Area2D


export var min_speed = 150
export var max_speed = 250

var speed

var player

var velocity

var dead = false


func init(_player, _position, direction):
	# Dependency injection
	player = _player
	position = _position

	speed = rand_range(min_speed, max_speed)
	direction += rand_range(-PI / 4, PI / 4)

	velocity = Vector2(speed, 0).rotated(direction)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func hit():
	# TODO: do states and set state to dead
	velocity = Vector2()
	$AnimatedSprite.play("Death")
	$CollisionShape2D.set_deferred("disabled", true)
	dead = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		return
	# look_at(position + linear_velocity)
	var dplayer = player.position - position
	if dplayer.length() < 800:
		velocity = dplayer.normalized() * speed
	position += velocity * delta
	if velocity.length() > 0:
		look_at(velocity)s

func _on_Visibility_screen_exited():
	# delete itself when exiting the screen
	queue_free()

func _on_start_game():
	queue_free()
