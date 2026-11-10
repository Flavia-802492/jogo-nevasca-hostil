## feat: implementa personagem inicial com máquina de estados

- Adiciona o personagem controlável com movimentação nas quatro direções (cima, baixo, esquerda e direita), incluindo estados de movimento e de repouso para cada direção, com suas respectivas animações.

**Dificuldade:** encontrar assets que combinassem com o personagem e o estilo visual do jogo.

**Como resolvi:** realizando novas pesquisas até encontrar sprites adequados para o projeto.

**Observação:** depois vou trocar o sprite do personagem para poder adicionar as movimentações de ataque e machucado.


## feat: adiciona terreno e decoração ao mapa

- Ajusta a largura do mapa e implementa o terreno e os elementos decorativos do cenário.

**Dificuldade:** encontrar decorações que combinassem com a temática de um planeta congelado.

**Como resolvi:** aproveitando alguns sprites de aulas anteriores e utilizando outros encontrados na internet.


## feat: implementa HUD, cronômetro e sistema de vida do jogador

### Sistema de vida e dano
- Implementa o sistema de vida do personagem, com 3 pontos de vida iniciais.
- Adiciona a hurtbox utilizando `Area2D` para detectar a entrada de corpos pertencentes ao grupo `inimigo`, através do sinal `body_entered`.
- Implementa a função `levar_dano()`, responsável por reduzir a vida do personagem e ativar temporariamente a invencibilidade por 1 segundo.
- Durante a invencibilidade, o personagem fica parcialmente transparente.

### HUD e cronômetro
- Adiciona um `CanvasLayer` à cena principal para manter a interface fixa na tela, independentemente da movimentação da câmera.
- Implementa as Labels `Vida` e `Tempo` para exibir as informações da partida.
- Configura o Timer `Relogio` com duração de 180 segundos e início automático.
- Realiza a personalização visual das Labels.

**Dificuldade:** descobrir por que as Labels não estavam apresentando o contorno corretamente. Como o texto era apenas branco, acabava ficando pouco visível no mapa.

**Como resolvi:** removendo a configuração de Label Settings e realizando a personalização diretamente no script de cada Label.


## feat: adiciona inimigo perseguidor

- Cria a cena do inimigo utilizando `CharacterBody2D`.
- Configura as animações de caminhada nas quatro direções.
- Implementa a perseguição ao jogador por meio do grupo `player`.
- Adiciona o inimigo ao grupo `inimigo`, utilizado para identificar os corpos que causam dano ao jogador.
- Ajusta as camadas e máscaras de colisão para impedir que o inimigo empurre ou arraste o jogador, mantendo a detecção de dano pela hurtbox.

**Dificuldade:** o inimigo estava colidindo fisicamente com o jogador e acabava arrastando o personagem.

**Como resolvi:** ajustando as Collision Layers e Collision Masks do jogador, do inimigo e da hurtbox, separando a colisão física da detecção de dano.

**Observação:** Esqueci de adicionar as dificuladades e como eu as resolvi, então estou adicionando agora. E o sprite do boneco de neve eu pedi para o ChatGPT fazer já que eu não encontrei um boneco de neve nas quatro direções e por enquanto é só ele andando.
