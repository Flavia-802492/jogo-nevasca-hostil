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

**Observação:** esta atualização também registra as dificuldades e soluções que não foram documentadas no momento do commit anterior. O sprite do boneco de neve foi criado com auxílio do ChatGPT, pois não encontrei um asset que apresentasse animações nas quatro direções. Por enquanto, o inimigo possui apenas animações de caminhada.


## feat: implementa sistema de horda de inimigos

- Adiciona o nó `Nascedouros` à cena principal, contendo quatro pontos de nascimento dos inimigos: Esquerda, Direita, Cima e Baixo.
- Implementa o Timer `Horda`, configurado inicialmente com intervalo de 2 segundos e início automático.
- Implementa a criação automática de inimigos por meio da instanciação da cena `inimigo.tscn`.
- Faz com que os inimigos apareçam aleatoriamente em um dos quatro pontos de nascimento.
- Implementa o aumento gradual da dificuldade, reduzindo o intervalo entre os nascimentos em 5% a cada novo inimigo, até atingir o limite mínimo de 0,5 segundo.
- Remove o inimigo colocado manualmente na cena principal, mantendo sua criação sob responsabilidade do sistema de horda.

**Dificuldade:** inicialmente, os inimigos estavam nascendo na origem da cena, em vez de aparecerem em pontos específicos do mapa.

**Como resolvi:** seguindo a estrutura proposta na Aula 09, criando o nó `Nascedouros` com quatro `Marker2D` posicionados em diferentes regiões do mapa e utilizando suas posições globais para determinar o local de nascimento dos inimigos.


## feat: implementa sistema de combate e balanceamento da horda

- Implementa o ataque do jogador utilizando a área `Ataque`.
- Adiciona o efeito visual da onda de gelo, exibido durante o ataque.
- Permite atingir inimigos durante a animação do ataque.
- Implementa o sistema de vida dos inimigos, que são derrotados ao receber um golpe.
- Adiciona o registro da quantidade de inimigos derrotados.
- Ajusta o balanceamento do combate: velocidade dos inimigos em 25, raio de ataque em 45 e intervalo inicial da horda em 4 segundos.
- Ajusta o crescimento da dificuldade da horda, reduzindo o intervalo entre nascimentos em 3%, até o limite mínimo de 1,5 segundo.

**Dificuldade:** inicialmente, a quantidade e a velocidade dos inimigos tornavam a sobrevivência muito difícil.

**Como resolvi:** realizei testes e ajustei a velocidade dos inimigos, o alcance do ataque e o intervalo de nascimento da horda até encontrar um equilíbrio entre desafio e possibilidade de sobrevivência.

**Observação:** a animação da onda de gelo foi criada com auxílio da ferramenta Manus AI, utilizando imagens PNG como quadros da animação.


## feat: implementa navegação dos inimigos pelo mapa

- Adiciona o nó `NavigationRegion2D` à cena principal.
- Organiza os `TileMapLayer` `terreno` e `decoracao` dentro da região de navegação.
- Adiciona colisões aos elementos sólidos da decoração, impedindo que os personagens atravessem esses objetos.
- Refaz a decoração do mapa, reorganizando os elementos e mantendo espaçamento adequado para a movimentação dos personagens.
- Configura o `NavigationPolygon` com a opção `Meshes and Static Colliders`.
- Gera a região navegável considerando os colisores estáticos, deixando os obstáculos fora dos caminhos dos inimigos.
- Adiciona `NavigationAgent2D` à cena do inimigo.
- Atualiza o script `inimigo.gd` para utilizar o agente de navegação e perseguir o jogador contornando obstáculos.

**Dificuldade:** fazer os inimigos reconhecerem os obstáculos e encontrarem caminhos alternativos até o jogador, sem precisar desenhar manualmente cada área livre do mapa.

**Como resolvi:** configurei o `NavigationPolygon` para considerar os colisores estáticos e desenhei o contorno da região navegável abrangendo o mapa. O Godot gerou os polígonos automaticamente, excluindo as áreas bloqueadas.

**Dificuldade:** organizar a decoração e garantir que os personagens tivessem espaço suficiente para se movimentar pelo cenário.

**Como resolvi:** refiz a decoração, ajustei o espaçamento entre os elementos e adicionei colisões aos objetos sólidos.


## feat: implementa telas de vitória e derrota e finaliza HUD

### Contador de inimigos derrotados
- Adiciona a Label `Abates` à HUD para exibir a quantidade de inimigos derrotados durante a partida.
- Atualiza o contador sempre que um inimigo é derrotado, permitindo acompanhar a pontuação durante o jogo.

### Telas de vitória e derrota
- Cria as cenas `vitoria.tscn` e `derrota.tscn`, utilizadas para apresentar o resultado da partida.
- Implementa a exibição de mensagens de vitória e derrota, acompanhadas da quantidade total de inimigos derrotados.
- Adiciona ilustrações pixelizadas de fundo às duas telas, criadas com auxílio da ferramenta Manus AI.
- Organiza os elementos visuais para manter os textos e botões sobre as ilustrações.
- Personaliza os botões de cada tela, utilizando verde para a vitória e vermelho para a derrota.
- Implementa a opção de reiniciar a partida por meio dos botões `Jogar novamente` e `Tentar novamente`.
- Configura a transição entre a cena principal e as telas de resultado, encerrando os Timers da partida.

### Ajustes e correções
- Ajusta o raio da `CollisionShape2D` da hurtbox para 9, melhorando a detecção de dano dos inimigos que se aproximam por diferentes direções.
- Corrige a conexão duplicada do sinal `body_entered` da hurtbox, mantendo a conexão realizada pelo script e removendo a conexão duplicada pelo editor.

**Dificuldade:** inicialmente, alguns inimigos que se aproximavam por baixo do personagem não conseguiam causar dano. Além disso, foi identificado um erro causado pela conexão duplicada do sinal `body_entered`.

**Como resolvi:** ajustei o raio da área de detecção da hurtbox para 9 e removi a conexão duplicada do sinal pelo editor, mantendo sua conexão por código no método `_ready()`.

**Observação:** as ilustrações das telas de vitória e derrota foram desenvolvidas com auxílio da Manus AI, seguindo a identidade visual pixelizada do jogo. Foram realizados testes de vitória, derrota, reinicialização consecutiva das partidas, atualização da HUD e detecção de dano em todas as direções. Também foram observadas pequenas variações na espessura de algumas linhas dos caminhos do terreno, sem impacto perceptível na jogabilidade.


## feat: atualiza documentação e adiciona capturas de tela do jogo

- Atualiza o README.md com as instruções de como jogar, incluindo os controles de movimentação e ataque.
- Documenta os assets utilizados no projeto, seus respectivos autores, origens e licenças de uso.
- Adiciona capturas de tela do gameplay, do ataque de gelo e das telas de vitória e derrota.
- Organiza as imagens na pasta `screenshots`, permitindo sua visualização diretamente pelo README.

**Dificuldade:** organizar as informações sobre os assets utilizados, identificando suas origens e condições de uso.

**Como resolvi:** reuni as informações dos pacotes de sprites utilizados durante o desenvolvimento, consultando suas licenças e registrando os créditos correspondentes.

**Observação:** as capturas de tela foram realizadas durante a execução do próprio jogo, mostrando seus principais elementos e funcionalidades.
