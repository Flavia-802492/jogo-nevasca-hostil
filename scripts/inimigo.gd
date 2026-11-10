extends CharacterBody2D

@export var velocidade: float = 25.0
@export var vida: int = 1

@onready var animacao: AnimatedSprite2D = $AnimatedSprite2D
@onready var agente: NavigationAgent2D = $NavigationAgent2D

var jogador: Node2D

func _ready() -> void:
	jogador = get_tree().get_first_node_in_group("player") as Node2D


func _physics_process(_delta: float) -> void:
	if not is_instance_valid(jogador):
		velocity = Vector2.ZERO
		return

	agente.target_position = jogador.global_position

	if agente.is_navigation_finished():
		velocity = Vector2.ZERO
		return

	var proxima_posicao = agente.get_next_path_position()
	var direcao = global_position.direction_to(proxima_posicao)

	velocity = direcao * velocidade

	move_and_slide()

	if direcao == Vector2.ZERO:
		return

	atualizar_animacao(direcao)


func atualizar_animacao(direcao: Vector2) -> void:
	if abs(direcao.x) > abs(direcao.y):
		if direcao.x > 0:
			animacao.play("direita-andando")
		else:
			animacao.play("esquerda-andando")
	else:
		if direcao.y > 0:
			animacao.play("baixo-andando")
		else:
			animacao.play("cima-andando")


func levar_golpe() -> void:
	vida -= 1

	if vida <= 0:
		get_tree().current_scene.inimigo_morreu(self)
		queue_free()
