extends Area2D

@export var speed = 400 # Vitesse de déplacement du joueur (pixels/sec).
var screen_size # Taille de l'écran du jeu.

func _ready():
	screen_size = get_viewport_rect().size
	
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
