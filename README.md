# Omarchy 3.x Backup & Dotfiles

Dieses Repository enthaelt das Backup deines Omarchy 3.x Setups.

## Restore Anleitung

1. Repo klonen:
git clone https://github.com/viknozs/awoken-vails-by-omarchy.git ~/omarchy3-dotfiles

2. Configs kopieren:
cp -r ~/omarchy3-dotfiles/.config/* ~/.config/

3. Dienste neu laden:
killall waybar && waybar &
hyprctl reload
