extends Node


const CENA_CARROS = preload("res://Carro.tscn")
#const Spawn_Power_Up = preload("res://PowerUp.tscn")

var pistas_rapidas = [104,272,488]
var pistas_lentas = [160,216,324,384,438,544,600]
#var playerLife = 5
#var counter = 0
#var old = 0

var score = 0

func _ready():

	$AudioTema.play()
	$HUD/Mensagem.text = " "
	$HUD/Button.hide()
	#$HUD/Life.text = str(playerLife)
	randomize()



func _on_Player_pontua():
	score += 1
	
	if score == 10:
		$AudioTema.stop()
		$AudioVitoria.play()
		$TimerCarrosLentos.stop()
		$TimerCarrosRapidos.stop()
		$HUD/Placar.text = str(score)
		$HUD/Mensagem.text = "Ganhou!"
		$HUD/Button.show()
	else:
		$HUD/Placar.text = str(score)
		$AudioPonto.play()

func _on_HUD_reinicia():
	score = 0
	
	$Player.position = $Player.posicao_inicial
	$AudioTema.play()
	
	$TimerCarrosLentos.start()
	$TimerCarrosRapidos.start()
	
	$HUD/Mensagem.text = ""
	$HUD/Placar.text = "0"
	$HUD/Button.hide()


func _on_TimerCarrosLentos_timeout():
	var novo_carro = CENA_CARROS.instance()
	add_child(novo_carro)
	
	var pista = pistas_lentas[randi()% pistas_lentas.size()]
	
	novo_carro.position = Vector2(-10,pista)
	novo_carro.linear_velocity.x = rand_range(300,310)
	novo_carro.linear_damp = -1
	
	for i in range(score):
		novo_carro.linear_velocity.x = novo_carro.linear_velocity.x * 1.1
	


func _on_TimerCarrosRapidos_timeout():
	
	var novo_carro = CENA_CARROS.instance()
	add_child(novo_carro)
	
	var pista = pistas_rapidas[randi()%pistas_rapidas.size()]
	
	novo_carro.position = Vector2(-10,pista)
	novo_carro.linear_velocity.x = rand_range(700,710)
	novo_carro.linear_damp = -1
	
	for i in range(score):
		novo_carro.linear_velocity.x = novo_carro.linear_velocity.x * 1.1

#func _on_PowerUpTime_timeout():
#	var newPowerUp = Spawn_Power_Up.instance()
#	add_child(newPowerUp)
#	newPowerUp.name = "PowerUp"
#	old = newPowerUp
#	
#	if counter == 0:
#		newPowerUp.position = Vector2(640,360)
#		counter = 1
#	else:
#		old.position = Vector2(3000,3000)
#		counter = 0
#	print(newPowerUp.name)


#func _on_Player_PU():
	#playerLife += 1
	
	#$HUD/Life.text = str(playerLife)


func _on_PowerUpTimeAway_timeout():
	pass
