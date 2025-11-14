# Instalação e Configuração de um Ambiente de Desenvolvimento Moderno com Arch Linux e Hyprland

> Oficina apresentada na **SECOMP 2025 – IFMS Campus Nova Andradina**

# Instalação e Configuração de um Ambiente de Desenvolvimento Moderno com Arch Linux e Hyprland

> Oficina apresentada na **SECOMP 2025 – IFMS Campus Nova Andradina**

- Introdução

  - [Por que Linux?](#por-que-linux)
  - [Por que Arch Linux?](#por-que-arch-linux)
  - [Arch Wiki](#arch-wiki)
  - [Pacman vs Apt](#pacman-vs-apt)
  - [Arch User Repository (AUR)](#arch-user-repository-aur)

- Instalação

  - [Instalação do Arch Linux com archinstall](#instalação-do-arch-linux-com-archinstall)
  - [Etapas do archinstall](#etapas-do-archinstall)

- Configuração
  - [Configurações Pós-Instalação](#configurações-pós-instalação)
  - [Instalando o Ambiente Visual: Hyprland](#instalando-o-ambiente-visual-hyprland)
  - [Editor de Código (VSCode)](#editor-de-código)
  - [Terminal: Zsh + Starship + Plugins](#terminal-zsh)
  - [Programas Essenciais](#programas-essenciais)
    - [Navegador](#navegador)
    - [Explorador de Arquivos + Visualizador de Imagens](#explorador-de-arquivos--visualizador-de-imagens)
    - [Launcher de Aplicativos](#launcher-de-aplicativos)
    - [Git](#git)
    - [Gerenciador de Versões (asdf)](#gerenciador-de-versões)
  - [Personalização do Ambiente](#personalização-do-ambiente)
    - [Clonando Configurações](#personalização-do-ambiente)
    - [Ajustes no hyprland.conf](#ajustes-importantes-no-hyprlandconf)
      - [Modo Escuro do Sistema](#modo-escuro-do-sistema)
      - [Gaps, Teclado, Atalhos e Animações](#gaps-teclado-atalhos-e-animações)
      - [Waybar](#waybar)

## **Por que Linux?**

Linux é a base da maior parte da infraestrutura moderna: servidores, nuvem, containers, dispositivos embarcados e etc. O que significa que desenvolver em Linux coloca você no mesmo ecossistema usado em produção pelo mercado inteiro. As ferramentas mais poderosas disponíveis são nativas, o ambiente favorece automação e escrita de scripts, e a estabilidade geral torna o sistema previsível para trabalho diário.

Além disso, a filosofia open source permite auditar, modificar e ajustar praticamente qualquer componente, dando ao usuário um entendimento real do que está acontecendo “por baixo do capô”. Isso reduz limitações, aumenta a transparência e cria um ambiente onde o desenvolvedor não fica preso a decisões externas, mas constrói exatamente o sistema que precisa.

Como muitos, também interagi com computadores primeiro a partir do sistema da Microsoft, mas a realidade é que o ambiente não foi projetado tendo o desenvolvedor como público principal, o que resulta em ferramentas menos integradas, pipelines mais complexos e uma experiência que frequentemente depende de camadas adicionais e curativos: WSL, gerenciadores de pacotes externos, emuladores ou adaptações; vários componentes necessários para alcançar o mesmo fluxo natural que sistemas Unix-like oferecem nativamente.

## **Por que Arch Linux?**

O **Arch Linux** é uma distribuição independente, minimalista e flexível, construída sobre o princípio de entregar apenas o essencial: um sistema base limpo, pacotes próximos do **upstream** (a versão original mantida pelos desenvolvedores do software) e ferramentas simples que não escondem o funcionamento interno. Nada vem pré-configurado além do básico, e tudo o que compõe o ambiente é escolhido e entendido pelo próprio usuário.

Para desenvolvimento, esse modelo oferece um equilíbrio entre simplicidade e controle. O sistema não força estruturas rígidas nem impõe camadas de abstração que atrapalham a manutenção. Você monta um ambiente exatamente com as versões, serviços e bibliotecas que precisa e com documentação clara. Isso reduz atrito no dia a dia e evita a sensação de estar trabalhando contra o próprio computador.

O modelo **rolling release** complementa isso: você recebe atualizações contínuas, com versões recentes e compatíveis entre si, evitando o acúmulo de pacotes antigos que costuma gerar o **dependency hell**. Em vez de grandes atualizações que quebram tudo de uma vez, o sistema evolui de forma incremental e síncrona. Para quem desenvolve e precisa de ferramentas atualizadas sem perder estabilidade, esse fluxo é extremamente vantajoso.

## **Arch Wiki**

A **Arch Wiki** é uma das documentações mais completas e respeitadas do mundo Linux. Ela não só cobre o ecossistema do Arch Linux, mas também explica conceitos gerais de sistemas Unix-like que se aplicam a praticamente qualquer distribuição. É um recurso que incentiva autonomia, entendimento profundo do sistema e uma abordagem mais consciente sobre como cada componente funciona.

## **Pacman vs Apt**

pacman (Arch) e o apt (Debian/Ubuntu) são gerenciadores de pacotes eficientes, mas seguem filosofias distintas. O pacman é rápido, direto e previsível, refletindo o minimalismo do Arch e entregando uma experiência uniforme para a maior parte do ecossistema.

A diferença prática aparece no fluxo de instalação. Em distribuições baseadas em apt, alguns softwares exigem vários passos adicionais: adicionar repositórios externos, importar chaves GPG, atualizar índices, instalar dependências auxiliares etc. Um exemplo clássico é o Docker, cuja instalação oficial no Ubuntu [envolve vários comandos e configurações extras](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

No Arch, quase sempre o processo se resume a um único passo, pois os pacotes oficiais já incluem tudo o que o software precisa. No caso do Docker, por exemplo, basta:

```bash
sudo pacman -S docker
```

E, se você quiser usar o Docker sem sudo:

```bash
sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER
```

Essa simplicidade torna o Arch mais prático e previsível para desenvolvimento.

## **Arch User Repository (AUR)**

O AUR é um repositório comunitário gigantesco que oferece milhares de pacotes extras. Ele não distribui binários: utiliza PKGBUILDs, que são receitas descrevendo exatamente como o pacote deve ser construído localmente. Esse modelo mantém tudo transparente, auditável e fácil de adaptar, além de permitir que qualquer usuário compreenda e modifique o processo de instalação. A combinação Arch + AUR é um dos maiores diferenciais da distro, pois expande de forma impressionante a disponibilidade de software sem comprometer a coesão do sistema.
Aqui está a seção reorganizada, mais fluida e coerente para uma oficina, **mantendo tudo em markdown e com extremo cuidado para não quebrar nenhum codeblock**.
Nada foi reindentado de forma perigosa; todos os blocos seguem o padrão `bash ou `ini e estão fechados corretamente.

## **Instalação do Arch Linux com `archinstall`**

A instalação pode ser feita manualmente seguindo o `Installation_guide`, mas para fins de oficina usaremos o instalador interativo **archinstall**, que acelera o processo e entrega uma base limpa e consistente.

### **1. Baixar a ISO**

Baixe a imagem oficial do Arch Linux no site e inicialize o sistema pela ISO.

### **2. Configurar a conexão de rede**

Não abordarei o que é necessário para conectar à uma rede WiFi, mas você pode usar o `iwctl` para isso, recomendo verificar o `Installation_guide` oficial do Arch Linux para detalhes.

No caso da VM e conexões cabeadas, a rede já estará ativa por padrão.

### **3. Ajustar a fonte do TTY (opcional)**

Se o texto estiver pequeno no ambiente de instalação:

```bash
ls /usr/share/kbd/consolefonts/
setfont ter-118b
```

### **4. Preparar o pacman**

Antes de iniciar o `archinstall`, abra o arquivo de configuração:

```bash
nano /etc/pacman.conf
```

Ative:

- **ParallelDownloads = 10** # aumenta o número de downloads simultâneos (padrão é 5)

E opcionalmente, por estética:

- **Color**
- **ILoveCandy**

Atualize e instale o instalador:

```bash
pacman -Sy archinstall
```

Inicie o script:

```bash
archinstall
```

## **Etapas do `archinstall`**

Selecione as seguintes opções:

- **Language:** English
- **Locales:** `en_US`
- **Keyboard layout:** `us` # ou outro conforme seu teclado
- **Mirrors:** Brasil + ativar **multilib**
- **Disk:** selecione o disco desejado
- **Partitioning:** automático
- **Filesystem:** `ext4` ou `btrfs`
- **Swap:** habilitado
- **Bootloader:** `GRUB`
- **Hostname:** `archvm`
- **Authentication:** criar usuário + root
- **Profile:** `minimal`
- **Kernel:** `linux`
- **Network:** `NetworkManager`
- **Timezone:** `America/Campo_Grande`
- **NTP:** habilitado
- **Audio:** `Pipewire`

Confirme tudo e aguarde a instalação. Em seguida, reinicie.

> Dica: para grandes listas de opções, pesquise por substrings com o atalho `/`.

## **Configurações Pós-Instalação**

Após login:

```bash
sudo pacman -Syyuu
```

Instalando nosso primeiro pacote com pacman manualmente:

```bash
sudo pacman -S noto-fonts
```

## **Instalando o Ambiente Visual: Hyprland**

Pacotes essenciais:

```bash
sudo pacman -S hyprland kitty nano
```

Teste o Hyprland:

```bash
hyprland
```

Se carregar corretamente, pressione **Super + M** para sair e configure a resolução:

```bash
nano ~/.config/hypr/hyprland.conf
```

```ini
monitor=,1920x1080,0x0,1
```

Recarregue:

```bash
hyprland
```

**Super + Q** abre terminais (emulador de terminal `kitty`) no ambiente.

Opcionalmente, é interessante configurar um tema para o terminal kitty, nessa oficina vou tentar configurar um tema popular para melhorar a experiência visual. Digite:

```bash
kitten themes
```

E selecione o tema de sua escolha. Usaremos o tema **Catppuccin Mocha**.

## **Editor de Código**

Há diversas opções competentes de editor de código, esta oficina pressupõe o uso do **VSCode**, pela sua popularidade na comunidade. Para facilidade, recomendo usar a versão proprietária oficial, que pode ser instalada diretamente via pacman:

> Importante: veja os [detalhes sobre as 3 diferentes versões do VSCode distribuídas no Arch Linux](https://wiki.archlinux.org/title/Visual_Studio_Code)

```bash
sudo pacman -S visual-studio-code-bin
```

Vamos instalar o mesmo tema, **Catppuccin Mocha**, para manter a consistência visual.

## **Terminal: Zsh**

A shell padrão do Arch é o **bash**, mas podemos melhorar a experiência do dia-a-dia explorando outras opções. Recomendo o `zsh`, que é moderno e facilmente expandível com plugins.

Instale o pacote:

```bash
sudo pacman -S zsh
```

Altere a shell padrão para zsh:

```bash
chsh -s /usr/bin/zsh
```

Instale o prompt customizável starship:

```bash
sudo pacman -S starship
```

Para utilizar com `zsh`, adicione ao final do arquivo `~/.zshrc`:

```bash
eval "$(starship init zsh)"
```

Para ver as mudanças, podemos reiniciar o terminal ou rodar:

```bash
source ~/.zshrc
```

Verificamos que ainda faltam alguns ícones no nosso prompt e, portanto, no nosso sistema. Vamos instalar uma família de fontes que já possui esses ícones embutidos, uma **Nerd Font**. Minha preferência é pela **JetBrains Mono Nerd Font**:

```bash
sudo pacman -S ttf-jetbrains-mono-nerd
```

Podemos agora configurar o nosso terminal `kitty` para usar essa fonte como padrão. Execute em seu terminal:

```bash
kitten choose-font
```

E selecione a fonte **JetBrains Mono Nerd Font**.

> Agora também é uma boa hora pra alterar a fonte do seu VSCode.

Voltando ao terminal, não entrarei no tópico de personalização do starship, mas você pode explorar o [site oficial](https://starship.rs/) para entender as extensas possibilidades de customização.

Podemos agora instalar os principais plugins de zsh para melhorar a experiência:

```bash
pacman -S zsh-syntax-highlighting zsh-autosuggestions
```

E, para instalar, vamos editar nosso arquivo `~/.zshrc`:

```bash
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
```

Isso marca o fim da nossa configuração inicial do terminal. Reinicie o terminal ou rode `source ~/.zshrc` para ver as mudanças.

## **Programas essenciais**

### Navegador

Recomendo instalar o firefox:

```bash
sudo pacman -S firefox
```

É útil escolher um padrão de abas na vertical, uma vez que facilita o gerenciamento com muitos projetos abertos simultaneamente, algo comum na rotina de desenvolvimento. Também recomendo utilizar o **Duck Duck Go**, um motor de busca focado em privacidade e que evita os resultados patrocinados do Google.

> Recomendo também adicionar um atalho em seu hyprland.conf para abrir o navegador, eu gosto de usar `Super + B`.

Vamos definir o firefox como navegador padrão do sistema:

```bash
sudo pacman -S xdg-utils
xdg-settings set default-web-browser firefox.desktop
```

### Explorador de Arquivos + Visualizador de Imagens

Utilizo o **Dolphin** como gerenciador de arquivos e o **Eye of GNOME (eog)** como visualizador de imagens:

```bash
sudo pacman -S dolphin eog
```

> Também recomendo utilizar um atalho pro gerenciador de arquivos. Normalmente, uso `Super + E`.

### Launcher de Aplicativos

Recomendo o **Wofi** como launcher de aplicativos:

```bash
sudo pacman -S wofi
```

### Git

Indispensável pra qualquer desenvolvedor, instale com:

```bash
sudo pacman -S git
```

É interessante também setar suas credenciais globais:

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@example.com"
```

### Gerenciador de Versões

É comum na rotina de desenvolvedor trabalhar com múltiplas versões de linguagens e ferramentas. Recomendo instalar o **asdf**, um gerenciador de versões universal que suporta diversas linguagens através de plugins.

> Também recomendo o NVM caso a intenção seja trabalhar exclusivamente com Node.js.

Contudo, para instalar o asdf, precisamos de um gerenciador de pacotes para a AUR, uma vez que o pacote não está disponível nos repositórios oficiais que podemos acessar com o `pacman`. Para instalar o `yay`:

```bash
# Instale as dependências
sudo pacman -S base-devel

# Clone o projeto
git clone https://aur.archlinux.org/yay.git
cd yay

# Construa e instale
makepkg -si
cd ..
rm -rf yay
```

Agora podemos instalar o asdf:

```bash
yay -S asdf-vm
```

Para ativá-lo, podemos incluir o seguinte no final do nosso `~/.zshrc`:

```bash
source /opt/asdf-vm/asdf.sh
```

Agora podemos começar a usar, como exemplo, para nodejs:

```bash
asdf install nodejs

asdf list
asdf plugin add nodejs
asdf list-all nodejs
asdf install nodejs latest
asdf global nodejs latest
```

O ideal com o asdf é configurar para cada projeto individualmente a versão desejada, criando um arquivo `.tool-versions` na raiz do projeto com o conteúdo:

```bash
mkdir projeto-exemplo
cd projeto-exemplo
asdf local nodejs 20.5.1
cat .tool-versions # deve mostrar a versão configurada
```

## **Personalização do Ambiente**

> Caso queira, você pode clonar esse repositório, que contém algumas configurações básicas para Hyprland, Waybar, Kitty, Zsh e outros programas:

```bash
git clone https://github.com/caiohperlin/arch
```

### **Ajustes Importantes no `hyprland.conf`**

#### **Modo Escuro do Sistema**

```bash
sudo pacman -S xdg-desktop-portal-gtk xdg-desktop-portal-hyprland qt6ct
```

```ini
exec = gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"
exec = gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
env = QT_QPA_PLATFORMTHEME,qt6ct
```

#### **Gaps, teclado, atalhos e animações**

Ajuste livremente no mesmo arquivo, conforme o estilo desejado. Veja o arquivo `hyprland.conf` clonado para exemplos.

#### Waybar

Waybar é uma barra de status altamente personalizável para ambientes Wayland, como o Hyprland. Ela pode exibir informações úteis, a mais útil delas sendo as diferentes workspaces do hyprland. Também pode ser usada pra uma infinidade de outras funções, como mostrar a hora, uso de CPU, memória, rede, bateria e muito mais.

> Verifique alguns exemplos de configuração [aqui](https://github.com/Alexays/Waybar/wiki/Examples)

```bash
sudo pacman -S waybar
```
