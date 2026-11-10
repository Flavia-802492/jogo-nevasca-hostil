extends Node2D

@export var cena_inimigo: PackedScene
@export var cena_vitoria: PackedScene
@export var cena_derrota: PackedScene

@onready var relogio: Timer = $relogio
@onready var jogador = $jogador
@onready var horda: Timer = $Horda

@onready var texto_vida: Label = $hud/vida
@onready var texto_tempo: Label = $hud/tempo
@onready var texto_abates: Label = $hud/abates

var abates: int = 0
var partida_encerrada := false

func _process(_delta: float) -> void:

	texto_vida.text = "Vida: %s" % str(jogador.get("vida"))

	var segundos: int = ceili(relogio.time_left)

	var minutos: int = int(segundos / 60)
	var restante: int = segundos % 60

	texto_tempo.text = "Tempo: %02d:%02d" % [
		minutos,
		restante
	]
	
	texto_abates.text = "Abates: %d" % abates


func _on_horda_timeout() -> void:
	if partida_encerrada:
		return
	
	var inimigo = cena_inimigo.instantiate()

	inimigo.global_position = $Nascedouros.get_children().pick_random().global_position

	add_child(inimigo)

	horda.wait_time = max(1.5, horda.wait_time * 0.97)


func inimigo_morreu(_inimigo: Node2D) -> void:
	abates += 1
	print("Inimigos derrotados: ", abates)



func vencer() -> void:
	if partida_encerrada:
		return

	partida_encerrada = true
	relogio.stop()
	horda.stop()

	var cena_atual = get_tree().current_scene
	var tela = cena_vitoria.instantiate()

	get_tree().root.add_child(tela)
	tela.configurar("VOCÊ SOBREVIVEU!", abates)

	get_tree().current_scene = tela
	cena_atual.queue_free()


func perder() -> void:
	if partida_encerrada:
		return

	partida_encerrada = true
	relogio.stop()
	horda.stop()

	var cena_atual = get_tree().current_scene
	var tela = cena_derrota.instantiate()

	get_tree().root.add_child(tela)
	tela.configurar("VOCÊ FOI DERROTADO!", abates)

	get_tree().current_scene = tela
	cena_atual.queue_free()


func _on_relogio_timeout() -> void:
	vencer()
