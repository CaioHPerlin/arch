# Passo a Passo

## Instalação do Arch Linux com `archinstall`

1. **Baixar ISO**

2. Podemos usar o `Installation_guide` para ver a wiki e seguirmos com a instalação manualmente. Contudo, por razões de agilidade, vamos utilizar um script que já vem nas ISOs do Arch Linux chamado **archinstall**.  
   Ele faz a configuração básica de acordo com nossas opções, deixando o processo de instalação parecido com o de outros sistemas operacionais.

   > Para aumentar a fonte no TTY e facilitar a leitura:

   ```bash
   ls /usr/share/kbd/consolefonts/
   setfont ter-118b
   ```

Antes de executar o `archinstall`, vamos configurar o gerenciador de pacotes do Arch, o **pacman**.

Abra o arquivo de configuração:

```bash
nano /etc/pacman.conf
```

Aqui, vamos permitir **10 downloads paralelos** (o padrão é 5) e, opcionalmente, habilitar `Color` e `ILoveCandy` por estética.

Atualize e instale o script:

```bash
pacman -Sy archinstall
```

Agora podemos rodar o script:

```bash
archinstall
```

### Etapas de configuração no archinstall

- **Archinstall language:** linguagem do instalador (usarei inglês).
- **Locales:** deixarei `en_US` e `us` pois meu teclado é americano.
- **Mirrors and repositories:** adicionar o mirror do **Brazil** e habilitar o repositório **multilib** (para suporte a apps 32 bits).
- **Disk:** selecionar o disco para instalação (no meu caso, um disco virtual).
- **Partitioning:** `automatic`.
- **Filesystem:** `ext4`.
- **Swap:** `enable`.
- **Bootloader:** `GRUB`, por ser mais comum.
- **Hostname:** `archvm`.
- **Authentication:** criar um usuário normal e senha de root.
- **Profile:** `minimal` (não selecionarei desktop automático para aprendermos o processo completo).
- **Applications:** usar **Pipewire** como servidor de áudio.
  - Bluetooth: deixarei desabilitado, mas pode ser ativado se necessário.
- **Kernels:** `linux` (poderíamos escolher `linux-lts` por estabilidade).
- **Network Configuration:** `NetworkManager`.
- **Timezone:** `America/Campo_Grande`.
- **NTP:** habilitado.

Após configurar tudo, salve (opcionalmente) o JSON de configuração e confirme a instalação.  
O script instalará os pacotes, configurará o sistema, o bootloader e criará os usuários. Quando terminar, reinicie o sistema.

> Em máquinas reais, remova o pendrive/DVD antes de reiniciar para evitar bootar pela ISO novamente. Na VM que eu criei, basta reiniciar normalmente.

---

## Configurações pós-instalação

O sistema abrirá no GRUB. Faça login com o usuário criado e siga os passos abaixo:

1. **Atualizar o sistema**

   ```bash
   sudo pacman -Syu
   ```

2. **Instalar drivers de vídeo**  
   Em VMs normalmente não é necessário, mas em hardware real instale os drivers adequados (Intel, AMD, Nvidia).

3. **Instalar ambiente gráfico e fontes básicas**
   ```bash
   sudo pacman -S noto-fonts
   ```

### Instalando o Hyprland

Pacotes essenciais:

```bash
sudo pacman -S hyprland kitty firefox nano
```

Inicie o Hyprland:

```bash
hyprland
```

Se a resolução estiver incorreta, saia do hyprland com `Super + M` e edite o arquivo de configuração:

```bash
nano ~/.config/hypr/hyprland.conf
```

Modifique a seção de monitor para a resolução correta, por exemplo:

```ini
monitor=,1920x1080,0x0,1
```

Salve com `CTRL + O`, confirme com `ENTER` e saia com `CTRL + X`.

Reinicie o Hyprland:

```bash
hyprland
```

Use `Super + Q` para abrir novos terminais **kitty**.  
Agora já temos um ambiente funcional com navegador, terminal e editor de texto, leve e eficiente.

---

## Shell, Git e Gerenciador de Pacotes AUR

### Instalando Git

O Git é essencial para controle de versão e também necessário para instalar o `yay` (gerenciador de pacotes AUR).

```bash
sudo pacman -S git
```

Configure seu Git com seus dados:

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@example.com"
```

### Instalando Zsh + Oh My Zsh

O **Zsh** é um shell mais poderoso que o bash, com melhor completion e plugins. O **Oh My Zsh** é um framework que facilita a configuração.

```bash
sudo pacman -S zsh
```

Instale o Oh My Zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Durante a instalação, ele perguntará se deseja fazer do Zsh o shell padrão. Responda `Y` (sim).

#### Plugins Úteis para Oh My Zsh

Edite o arquivo `~/.zshrc`:

```bash
nano ~/.zshrc
```

Encontre a linha `plugins=(git)` e substitua por:

```bash
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  docker
  npm
  python
  colored-man-pages
)
```

Instale os plugins:

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Recarregue a configuração:

```bash
source ~/.zshrc
```

### Instalando Yay (Gerenciador de Pacotes AUR)

O **Yay** permite instalar pacotes do **AUR (Arch User Repository)**, um repositório comunitário com muitos programas extras.

Primeiro, clone o repositório do Yay onde desejar:

```bash
git clone https://aur.archlinux.org/yay.git
cd yay

# makepkg irá compilar e instalar o pacote
makepkg -si

# após executar o makepkg, podemos remover o diretório
cd ..
rm -rf yay
```

Agora você pode usar `yay` para instalar pacotes do AUR:

```bash
yay -S nome-do-pacote
```

> **Dica:** `yay` funciona igual a `pacman`, mas busca também no AUR. Você pode usar `yay -Syu` para atualizar o sistema inteiro (pacman + AUR). Efetivamente, o yay substitui o pacman para usuários que desejam usar o AUR.

---

## Personalização do Ambiente

### Clonando configurações básicas

Esse é um passo totalmente opcional, apenas para acelerar nosso progresso!

```bash
# clonando esse repositório
git clone https://github.com/caiohperlin/arch
```

### Instalando o VSCode

```bash
sudo pacman -S code
code ~/.config/hypr/hyprland.conf
```

Recomendo instalar o tema **Catppuccin Mocha**, um dos mais populares na comunidade Linux.

### Wallpapers

Remova os wallpapers padrão e copie os seus preferidos para o diretório de wallpapers do Hyprland.

---

## Ajustes Importantes no `hyprland.conf`

1. **Configurar tema escuro do sistema:**

   Instale os pacotes necessários:

   ```bash
   sudo pacman -S xdg-desktop-portal-gtk xdg-desktop-portal-hyprland qt6ct
   ```

   Adicione ao `hyprland.conf`:

   ```ini
   ### SYSTEM = DARK MODE
   exec = gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"
   exec = gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
   env = QT_QPA_PLATFORMTHEME,qt6ct
   ```

2. **Ajustar gaps (espaços entre janelas e bordas)**  
   Altere os valores conforme sua preferência — as mudanças refletem em tempo real.

3. **Configurar layout e idioma do teclado**  
   Ajuste para `pt-br` se necessário.

4. **Personalizar atalhos de teclado**  
   O Hyprland brilha nessa área — configure atalhos como preferir.  
   O padrão é `Super + número` para trocar entre workspaces.

5. **Animações (opcional)**  
   Também podem ser personalizadas no mesmo arquivo.
