extends CharacterBody2D

@onready var ataque: Area2D = $Ataque
@onready var efeito_gelo: AnimatedSprite2D = $Ataque/EfeitoGelo

var pode_atacar := true

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
@export var vida: int = 3

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $hurtbox

var status: PlayerState
var direcao: Vector2 = Vector2.ZERO
var invencivel := false


func _ready() -> void:
	go_to_baixo_parado_state()
	hurtbox.body_entered.connect(_on_hurtbox_body_entered)
	efeito_gelo.visible = false


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if invencivel:
		return

	if body.is_in_group("inimigo"):
		levar_dano()

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
	
	if Input.is_action_just_pressed("attack") and pode_atacar:
		atacar()

func atacar() -> void:
	pode_atacar = false

	efeito_gelo.visible = true
	efeito_gelo.play("onda_gelo")

	while efeito_gelo.is_playing():
		for inimigo in ataque.get_overlapping_bodies():
			if inimigo.is_in_group("inimigo"):
				if inimigo.has_method("levar_golpe"):
					inimigo.levar_golpe()

		await get_tree().physics_frame

	efeito_gelo.visible = false

	await get_tree().create_timer(0.4).timeout
	pode_atacar = true


func levar_dano() -> void:
	vida -= 1
	
	if vida <= 0:
		get_tree().current_scene.perder()
		return

	invencivel = true
	anim.modulate = Color(1.0, 0.35, 0.35, 0.4)

	await get_tree().create_timer(1.0).timeout

	anim.modulate = Color.WHITE
	invencivel = false

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
