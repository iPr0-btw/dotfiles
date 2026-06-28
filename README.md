# my dotfiles

This is my personal config for my arch + hyprland setup.

## features

started running a search engine locally with searXNG.

the 'autopush' script runs on a systemd timer to push updates every 30s, making sure local changes also reflect in this repo.

also started using dank-material-shell, on top of hyprland to have a clean looking bar

## my stack

- arch linux (OS)
- hyprland (WM)
- KDE Plasma (fallback DE)
- fish shell
- swaybg (for wallpaper)
- swaylock lockscreen
- kitty terminal
- rofi app launcher
- searXNG search engine
- nvim IDE with lazyvim config
- dank-material-shell bar
- no unnecessary bloat

## installing it
- install the apps with your package manager, for example with arch you would type 'yay -S hyprland kitty fish rofi plasma-desktop dms'
- clone this repo and copy the 'config' folder to ~/.config
- to install searXNG, install the binary with your package manager, and then see services/searXNG for config details.
- enable the 'autopush' user service and timer.

plain and simple, like it should be.
