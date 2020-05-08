extends Area2D

signal hit

signal attack

export var speed = 150

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func start(pos):
	position = pos
	dead = false
	show()
	$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		return
		
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("attack_1"):
		$Body/AnimatedSprite.play("Attack")
		emit_signal("attack")

	
	velocity = velocity.normalized() * speed
	position += velocity * delta

	# rotation += PI / 2
	
	var sprite = $Body/AnimatedSprite
	var dont_play_walking = sprite.animation == "Attack" and \
	sprite.frame < sprite.frames.get_frame_count("Attack") - 1

	if not dont_play_walking:
		if velocity.length() > 0:
			sprite.play("Running")
		else:
			sprite.play("Idle")

func _on_Player_area_entered(area):
	dead = true
	$Body/AnimatedSprite.play("Death")
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
