# Dotfiles

Minha configuração pessoal para **Arch Linux + Hyprland**, numa paleta escura e minimalista. A barra, o wallpaper, o lançador de apps, o menu de energia, as notificações, a tela de bloqueio e o indicador de volume e brilho são feitos no [Quickshell](https://quickshell.org); o terminal é o foot e o gerenciador de arquivos é o Thunar, os dois com a mesma paleta, assim como a tela de login (SDDM). Tudo segue o idioma do sistema, em 10 idiomas.

## Instalação

1 - Clone o repositório:

```bash
git clone <repository-url> ~/.dotfiles
```

2 - Acesse o diretório:

```bash
cd ~/.dotfiles
```

3 - Execute o instalador:

```bash
./install.sh
```

## Quickshell

O Quickshell fica no AUR, e o instalador usa o `yay` ou o `paru` para instalá-lo; sem um deles, instale o Quickshell à mão antes de rodar o instalador.

## Atalhos

`SUPER` é a tecla do Windows.

| Teclas | Ação |
| --- | --- |
| `SUPER + Enter` | Abrir o terminal (foot) |
| `SUPER + D` | Abrir o lançador de apps |
| `SUPER + E` | Abrir o gerenciador de arquivos (Thunar) |
| `SUPER + Q` | Fechar a janela (sem janela aberta: menu de energia) |
| `SUPER + L` | Bloquear a tela |
| `SUPER + V` | Alternar janela flutuante |
| `SUPER + P` | Alternar pseudo-tiling |
| `SUPER + J` | Alternar a direção da divisão |
| `SUPER + setas` | Mover o foco |
| `SUPER + 1…0` | Ir para o workspace 1–10 |
| `SUPER + SHIFT + 1…0` | Mover a janela para o workspace 1–10 |
| `SUPER + TAB` | Mostrar ou esconder o scratchpad |
| `SUPER + SHIFT + TAB` | Mover a janela para o scratchpad |
| `SUPER + roda do mouse` | Trocar de workspace |
| `SUPER + arrastar com o botão esquerdo` | Mover a janela |
| `SUPER + arrastar com o botão direito` | Redimensionar a janela |
| `SUPER + PRINT` | Captura da tela inteira |
| `SUPER + SHIFT + PRINT` | Captura de uma área |

As capturas vão para a pasta de imagens do idioma do sistema (`~/Imagens` em português). As teclas de volume, brilho e mídia do teclado também funcionam, inclusive com a tela bloqueada.

## Wallpaper

Os wallpapers ficam na pasta `wallpapers/` do repositório. O instalador os copia para a pasta `Wallpapers` dentro da sua pasta de imagens (`~/Imagens/Wallpapers` em português, `~/Pictures/Wallpapers` em inglês), sem apagar os que você já tiver lá.

Para usar outro wallpaper, coloque a imagem nessa pasta e troque o nome do arquivo em `~/.config/quickshell/Wallpaper.qml` (a linha `file`). Depois, reinicie o Quickshell.

## Idiomas

Os textos dos menus e da barra seguem o idioma do sistema. Os idiomas disponíveis são 10:

| Idioma | Nome nativo | Código |
| --- | --- | --- |
| Inglês | English | `en_US` |
| Mandarim (simplificado) | 中文（简体） | `zh_CN` |
| Hindi | हिन्दी | `hi_IN` |
| Espanhol | Español | `es_ES` |
| Árabe | العربية | `ar_SA` |
| Francês | Français | `fr_FR` |
| Bengali | বাংলা | `bn_BD` |
| Português | Português | `pt_BR` |
| Russo | Русский | `ru_RU` |
| Indonésio | Bahasa Indonesia | `id_ID` |

Outras variantes de um idioma usam a tradução dele (por exemplo, `es_MX` usa `es_ES`, e `pt_PT` usa `pt_BR`). Idiomas sem tradução usam o inglês.