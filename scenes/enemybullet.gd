extends Node2D

var moving = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(_on_area_2d_area_entered)
	$BulletSprite.animation_finished.connect(_on_animation_finished)
	
func _shoot(pos, playerpos):
	position = pos
	var direction = (playerpos - pos).normalized()
	rotation = direction.angle()
	$BulletSprite.play("shot")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		position += Vector2.RIGHT.rotated(rotation) * delta * 400

func _on_area_2d_area_entered():
	moving = false
	$BulletSprite.play("hit")
	
func _on_animation_finished():
	if $BulletSprite.animation == "shot":
		$BulletSprite.play("fly")
	if $BulletSprite.animation == "hit":
		queue_free()
