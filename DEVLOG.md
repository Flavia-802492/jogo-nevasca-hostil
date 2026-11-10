## feat: implementa personagem inicial com máquina de estados

Adiciona o personagem controlável com movimentação nas quatro direções (cima, baixo, esquerda e direita), incluindo estados de movimento e de repouso para cada direção, com suas respectivas animações.

**Observação:** depois vou trocar o sprite do personagem para poder adicionar as movimentações de ataque e machucado.


## feat: adiciona terreno e decoração ao mapa

Ajusta a largura do mapa e implementa o terreno e os elementos decorativos do cenário.


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
