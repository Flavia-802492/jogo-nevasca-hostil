extends Node2D

@onready var relogio: Timer = $relogio
@onready var jogador = $jogador

@onready var texto_vida: Label = $hud/vida
@onready var texto_tempo: Label = $hud/tempo

func _process(_delta: float) -> void:

	texto_vida.text = "Vida: %s" % str(jogador.get("vida"))

	var segundos: int = ceili(relogio.time_left)

	var minutos: int = int(segundos / 60)
	var restante: int = segundos % 60

	texto_tempo.text = "Tempo: %02d:%02d" % [
		minutos,
		restante
	]
