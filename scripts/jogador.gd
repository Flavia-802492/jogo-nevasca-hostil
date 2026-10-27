extends CharacterBody2D

enum PlayerState {
	cima_andando,
	cima_parado,
	baixo_andando,
	baixo_parado,
	esquerda_andando,
	esquerda_parado,
	direita_andando,
	direita_parado
}

@export var velocidade: float = 70.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var status: PlayerState
var direcao: Vector2 = Vector2.ZERO


func _ready() -> void:
	go_to_baixo_parado_state()


func _physics_process(_delta: float) -> void:
	match status:
		PlayerState.cima_parado:
			cima_parado_state()

		PlayerState.cima_andando:
			cima_andando_state()

		PlayerState.baixo_parado:
			baixo_parado_state()

		PlayerState.baixo_andando:
			baixo_andando_state()

		PlayerState.esquerda_parado:
			esquerda_parado_state()

		PlayerState.esquerda_andando:
			esquerda_andando_state()

		PlayerState.direita_parado:
			direita_parado_state()

		PlayerState.direita_andando:
			direita_andando_state()

	move_and_slide()


func go_to_cima_parado_state() -> void:
	status = PlayerState.cima_parado
	anim.play("cima-parado")


func go_to_cima_andando_state() -> void:
	status = PlayerState.cima_andando
	anim.play("cima-andando")


func go_to_baixo_parado_state() -> void:
	status = PlayerState.baixo_parado
	anim.play("baixo-parado")


func go_to_baixo_andando_state() -> void:
	status = PlayerState.baixo_andando
	anim.play("baixo-andando")


func go_to_esquerda_parado_state() -> void:
	status = PlayerState.esquerda_parado
	anim.play("esquerda-parado")


func go_to_esquerda_andando_state() -> void:
	status = PlayerState.esquerda_andando
	anim.play("esquerda-andando")


func go_to_direita_parado_state() -> void:
	status = PlayerState.direita_parado
	anim.play("direita-parado")


func go_to_direita_andando_state() -> void:
	status = PlayerState.direita_andando
	anim.play("direita-andando")


func cima_parado_state() -> void:
	move()
	if direcao != Vector2.ZERO:
		atualizar_estado_movimento()


func baixo_parado_state() -> void:
	move()
	if direcao != Vector2.ZERO:
		atualizar_estado_movimento()


func esquerda_parado_state() -> void:
	move()
	if direcao != Vector2.ZERO:
		atualizar_estado_movimento()


func direita_parado_state() -> void:
	move()
	if direcao != Vector2.ZERO:
		atualizar_estado_movimento()


func cima_andando_state() -> void:
	move()
	if direcao == Vector2.ZERO:
		go_to_cima_parado_state()
	elif direcao != Vector2.ZERO:
		atualizar_estado_movimento()


func baixo_andando_state() -> void:
	move()
	if direcao == Vector2.ZERO:
		go_to_baixo_parado_state()
	elif direcao != Vector2.ZERO:
		atualizar_estado_movimento()


func esquerda_andando_state() -> void:
	move()
	if direcao == Vector2.ZERO:
		go_to_esquerda_parado_state()
	elif direcao != Vector2.ZERO:
		atualizar_estado_movimento()


func direita_andando_state() -> void:
	move()
	if direcao == Vector2.ZERO:
		go_to_direita_parado_state()
	elif direcao != Vector2.ZERO:
		atualizar_estado_movimento()


func move() -> void:
	direcao = Input.get_vector("left", "right", "up", "down")
	velocity = direcao * velocidade


func atualizar_estado_movimento() -> void:
	if abs(direcao.x) > abs(direcao.y):
		if direcao.x > 0:
			go_to_direita_andando_state()
		else:
			go_to_esquerda_andando_state()
	else:
		if direcao.y > 0:
			go_to_baixo_andando_state()
		else:
			go_to_cima_andando_state()
