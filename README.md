# Dotfiles

Minha configuração pessoal para **Arch Linux + Hyprland**.

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

Nesta branch, a barra, o lançador de apps, o menu de energia e as notificações são feitos no [Quickshell](https://quickshell.org), no lugar da waybar, do wofi e do mako. Ele fica no AUR, e o instalador usa o `yay` ou o `paru` para instalá-lo; sem um deles, instale o Quickshell à mão antes de rodar o instalador.

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
