# Instalação e Configuração de um Ambiente de Desenvolvimento Moderno com Arch Linux e Hyprland

> Oficina apresentada na **SECOMP 2025 – IFMS Campus Nova Andradina**

- Introdução
  - [Por que Linux?](#por-que-linux)
  - [Por que Arch Linux?](#por-que-arch-linux)
  - [Arch Wiki](#arch-wiki)
  - [Arch User Repository (AUR)](#arch-user-repository-aur)
  - [Pacman vs Apt](#pacman-vs-apt)
- Instalação
  - [Instalação do Arch Linux com archinstall](#instalação-do-arch-linux-com-archinstall)
  - [Etapas do archinstall](#etapas-do-archinstall)
- Configuração
  - [Configurações Pós-Instalação](#configurações-pós-instalação)
  - [Instalando o Hyprland](#instalando-o-hyprland)
  - [Shell, Git e AUR](#shell-git-e-aur)
  - [Git](#git)
  - [Zsh + Oh My Zsh](#zsh--oh-my-zsh)
  - [Yay (AUR)](#yay-aur)
  - [Personalização do Ambiente](#personalização-do-ambiente)
  - [Clonando Configurações](#clonando-configurações)
  - [VSCode](#vscode)
  - [Ajustes Importantes no hyprland.conf](#ajustes-importantes-no-hyprlandconf)
  - [Modo Escuro do Sistema](#modo-escuro-do-sistema)
  - [Gaps, teclado, atalhos e animações](#gaps-teclado-atalhos-e-animações)

---

## **Por que Linux?**

Linux é a base de grande parte da infraestrutura tecnológica moderna: servidores, nuvem, containers, dispositivos embarcados, supercomputadores e até o Android. Para desenvolvimento, trabalhar em Linux significa usar o mesmo ecossistema dominante no mercado — com ferramentas nativas poderosas, automação simples e um ambiente altamente estável e seguro.

Outro ponto fundamental é a filosofia **open source**. O usuário pode auditar, modificar e adaptar praticamente tudo, reduzindo limitações e permitindo um entendimento muito mais profundo do funcionamento do sistema operacional.

## **Por que Arch Linux?**

O Arch Linux segue a filosofia **KISS ("Keep It Simple, Stupid")**, oferecendo um sistema minimalista, transparente, configurável e altamente modular. Ele não impõe decisões ao usuário.

Além disso, seu modelo **rolling release** garante acesso contínuo a kernels, drivers e ferramentas de desenvolvimento sempre atualizados, na minha opinião pessoal, ideal para programadores.

## **Arch Wiki**

A **Arch Wiki** é uma das documentações mais completas e respeitadas do mundo Linux. Ela não apenas ensina conceitos relevantes ao ecossistema do Arch Linux, mas sim a todas as distribuições Linux e sistemas baseados em Unix.

É um incentivo à autonomia, aprendizado profundo e compreensão real do sistema.

## **Pacman vs Apt**

O **pacman** (Arch) e o **apt** (Debian/Ubuntu) são gerenciadores de pacotes eficientes, porém com filosofias distintas. O pacman é **rápido, direto e previsível**, refletindo o minimalismo do Arch.

A diferença prática aparece no fluxo de instalação. Em sistemas baseados em **apt**, muitos softwares exigem várias etapas extras — como adicionar repositórios externos, importar chaves GPG e atualizar índices.

Um exemplo clássico é o **Docker**, cuja instalação oficial no Ubuntu segue diversos passos adicionais ([guia oficial](https://docs.docker.com/engine/install/ubuntu/)). Já no Arch, raramente a instalação irá muito além de um único comando:

```bash
sudo pacman -S docker
```

Essa simplicidade torna o Arch mais prático e previsível para desenvolvimento.

## **Arch User Repository (AUR)**

O **AUR** é um repositório comunitário com milhares de pacotes extras, incluindo ferramentas de nicho e versões alternativas de programas populares. Em vez de distribuir binários, o AUR utiliza **PKGBUILDs**, que funcionam como receitas para construir pacotes localmente.

Isso mantém o sistema transparente, auditável e extremamente flexível. A combinação **Arch + AUR** é um dos maiores diferenciais da distribuição, ampliando significativamente a disponibilidade de software.

## **Instalação do Arch Linux com `archinstall`**

1. **Baixar ISO**

2. Embora seja possível seguir o `Installation_guide` e realizar a instalação manual, vamos utilizar o instalador interativo **archinstall**, que acelera o processo e garante uma base consistente.

> Para aumentar o tamanho da fonte no TTY:

```bash
ls /usr/share/kbd/consolefonts/
setfont ter-118b
```

Antes de rodar o `archinstall`, configure o **pacman**:

```bash
nano /etc/pacman.conf
```

Ative **10 downloads paralelos**, `Color` e, opcionalmente, `ILoveCandy`.

Atualize e instale:

```bash
pacman -Sy archinstall
archinstall
```

### **Etapas do `archinstall`**

- **Language:** inglês
- **Locales:** `en_US` + layout `us` (utilizo teclado no padrão US, então escolho essa opção)
- **Mirrors:** Brasil + habilitar **multilib**
- **Disk:** selecionar o disco
- **Partitioning:** automático
- **Filesystem:** `ext4` ou `btrfs`
- **Swap:** habilitado
- **Bootloader:** `GRUB`
- **Hostname:** `archvm`
- **Authentication:** criar usuário + senha root
- **Profile:** `minimal`
- **Applications:** `Pipewire`
- **Kernel:** `linux`
- **Network:** `NetworkManager`
- **Timezone:** `America/Campo_Grande`
- **NTP:** habilitado

Após concluir a configuração, confirme e aguarde a instalação. Reinicie o sistema.

## **Configurações Pós-Instalação**

Faça login e execute:

```bash
sudo pacman -Syyuu
```

Instale fontes e drivers conforme o hardware:

```bash
sudo pacman -S noto-fonts
```

## **Instalando o Hyprland e o Ambiente Visual**

Pacotes essenciais:

```bash
sudo pacman -S hyprland kitty firefox nano
```

Utilize o comando `hyprland` para iniciar o hyprland e verificar se há algum problema na instalação:

```bash
hyprland
```

Se tudo der certo, use o atalho de teclas **Super + Q** para sair e ajuste sua resolução:

> **Super** é a tecla Windows!

```bash
nano ~/.config/hypr/hyprland.conf
```

```ini
monitor=,1920x1080,0x0,1
```

Recarregar:

```bash
hyprland
```

Use **Super + Q** para abrir terminais.

## **Shell, Git e AUR**

### **Git**

```bash
sudo pacman -S git
```

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@example.com"
```

### **Zsh + Oh My Zsh**

```bash
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Plugins:

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

Instalação dos plugins:

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### **Yay (AUR)**

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

## **Personalização do Ambiente**

### **Clonando Configurações**

```bash
git clone https://github.com/caiohperlin/arch
```

### **VSCode**

```bash
sudo pacman -S code
code ~/.config/hypr/hyprland.conf
```

Recomendo **Catppuccin Mocha** como tema.

## **Ajustes Importantes no `hyprland.conf`**

### **Modo Escuro do Sistema**

```bash
sudo pacman -S xdg-desktop-portal-gtk xdg-desktop-portal-hyprland qt6ct
```

```ini
exec = gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"
exec = gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
env = QT_QPA_PLATFORMTHEME,qt6ct
```

### **Gaps, teclado, atalhos e animações**

Ajuste livremente no mesmo arquivo.
