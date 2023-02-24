extends Area2D

export var speed = 150

var screen_size
var posicao_inicial = Vector2(640,690)

signal pontua
#signal PU

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	
		var velocity = Vector2()
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y +=1
		if Input.is_action_pressed("ui_right"):
			velocity.x +=1
		if Input.is_action_pressed("ui_left"):
			velocity.x -=1
			
			
		velocity = velocity.normalized() * speed
		if velocity.length() > 0:
			 $Animacao.play()
		else:
			 $Animacao.stop()
				
		if velocity.y > 0:
			$Animacao.animation = "Baixo"
		else:
			$Animacao.animation = "Cima"
		
		if velocity.x > 0:
			$Animacao.animation = "Direita"
		elif velocity.x < 0:
			$Animacao.animation = "Esquerda"
			
		position += velocity*delta
		position.y = clamp(position.y,0,screen_size.y)
		position.x = clamp(position.x,0,screen_size.x)
			
func _on_Player_body_entered(body):
	
	if body.name == "LinhaChegada":
		emit_signal("pontua")
		
	else:
		$Audio.play()
	position = posicao_inicial
	
			


#func _on_TimerCarrosRapidos_timeout():
	#pass Replace with function body.


#func _on_TimerCarrosLentos_timeout():
#	pass # Replace with function body.


#func _on_Player_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
#	if area.name == "PowerUp":
#		emit_signal("PU")
