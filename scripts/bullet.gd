extends Node2D

var moving = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(_on_area_2d_area_entered)
	$BulletSprite.animation_finished.connect(_on_animation_finished)
	
	var blaster_sprite_path = "/root/UltraMain/Player/PlayerSprite/BlasterSprite"
	var blaster_sprite = get_node_or_null(blaster_sprite_path)
	rotation = blaster_sprite.rotation - (PI/2)
	position = blaster_sprite.global_position
	apply_scale(Vector2(2,2))
	$BulletSprite.play("shot")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		position += Vector2.RIGHT.rotated(rotation) * delta * 400
	
func _on_area_2d_area_entered(area):
	moving = false
	$BulletSprite.play("hit")
	
func _on_animation_finished():
	if $BulletSprite.animation == "hit":
		queue_free()
