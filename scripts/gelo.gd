extends Node2D

@export var cena_inimigo: PackedScene

@onready var relogio: Timer = $relogio
@onready var jogador = $jogador
@onready var horda: Timer = $Horda

@onready var texto_vida: Label = $hud/vida
@onready var texto_tempo: Label = $hud/tempo

var abates: int = 0

func _process(_delta: float) -> void:

	texto_vida.text = "Vida: %s" % str(jogador.get("vida"))

	var segundos: int = ceili(relogio.time_left)

	var minutos: int = int(segundos / 60)
	var restante: int = segundos % 60

	texto_tempo.text = "Tempo: %02d:%02d" % [
		minutos,
		restante
	]


func _on_horda_timeout() -> void:
	var inimigo = cena_inimigo.instantiate()

	inimigo.global_position = $Nascedouros.get_children().pick_random().global_position

	add_child(inimigo)

	horda.wait_time = max(1.5, horda.wait_time * 0.97)


func inimigo_morreu(_inimigo: Node2D) -> void:
	abates += 1
	print("Inimigos derrotados: ", abates)
