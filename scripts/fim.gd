
extends Control

@onready var titulo: Label = $CenterContainer/VBoxContainer/Titulo
@onready var pontuacao: Label = $CenterContainer/VBoxContainer/Pontuacao
@onready var reiniciar: Button = $CenterContainer/VBoxContainer/Reiniciar

var cena_principal: String = "res://scenes/gelo.tscn"


func configurar(mensagem: String, total_abates: int) -> void:
	titulo.text = mensagem
	pontuacao.text = "Inimigos derrotados: %d" % total_abates


func _on_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file(cena_principal)
