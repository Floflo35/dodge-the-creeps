extends Area2D
signal hit

@export var speed = 400 # Vitesse de déplacement du joueur (pixels/sec).
var screen_size # Taille de l'écran du jeu.

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	var velocity = Vector2.ZERO # Vecteur de mouvement du joueur.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # Empêcher la vélocité d'être plus importante en diagonale.
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta # Modifier la position du joueur.
	position = position.clamp(Vector2.ZERO, screen_size) # Restreindre la position du joueur à la taille de l'écran.
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

func _on_body_entered(body):
	hide() # Le player disparaît lorsqu'il est touché.
	hit.emit()
	#$CollisionShape2D.disabled = true
	# Must be deferred as we can't change physics properties on a physics callback.
	$COllisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
