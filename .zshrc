if [[ "$TERM" == "xterm-kitty" ]]; then
    clear
    neofetch
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="$HOME/.oh-my-zsh"


plugins=(git zsh-syntax-highlighting zsh-interactive-cd)

source $ZSH/oh-my-zsh.sh

alias open='xdg-open'
alias ..='cd ..'
alias ls='ls -a --color=auto'
alias n='nvim'
function c(){clear}
function tt() {
  read -r "no?Enter the theme number: "
  echo "import = [  '~/.config/alacritty/themes/$no.toml']" > ~/.config/alacritty/import.toml
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/sugam/.config/wallpaper/$no.png
  clear
  neofetch
}
kk() {
  read -r "no?Enter the theme number: "
  # Update the Kitty terminal theme
  echo "include themes/$no.config" > ~/.config/kitty/import.config
  kitty @ set-colors --all ~/.config/kitty/themes/$no.config

  # Update the wallpaper
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/sugam/.config/wallpaper/$no.png
  # Prepare the new image_source line
  new_image_source="image_source=~/.config/neofetch/theme/$no.png"

  # Check if the line already exists in the Neofetch config
  if grep -q '^image_source=' ~/.config/neofetch/config.conf; then
    # Update the existing line
    sed -i "s|^image_source=.*|$new_image_source|" ~/.config/neofetch/config.conf
  else
    # Append the new line if it doesn't exist
    echo "$new_image_source" >> ~/.config/neofetch/config.conf
  fi

  # Clear the terminal and run Neofetch to see the changes
  clear
  neofetch
}
function msh() {
  mongosh "your mongodb url" --apiVersion 1 --username yourname
}
function cdb() {
  cd ~/Desktop/files/bobby/
}
function cds() {
  cd ~/Desktop/files/sugam/
}
function cde() {
  cd ~/Desktop/files/etc/
}
# Function to toggle between starship and p10k themes
function swt() {
  local theme_file=~/.selected_theme
  local theme

  echo "Select theme:"
  echo "1. Starship"
  echo "2. Powerlevel10k"
  echo -n "Enter the number (1/2): "
  read -r theme

  case $theme in
    1)
      echo "starship" > "$theme_file"
      eval "$(starship init zsh)"
      echo "Switched to Starship theme."
      ;;
    2)
      echo "powerlevel10k" > "$theme_file"
      ZSH_THEME="powerlevel10k/powerlevel10k"
      echo "Switched to Powerlevel10k theme."
      ;;
    *)
      echo "Invalid option. Please choose 1 or 2."
      return
      ;;
  esac
  source ~/.zshrc
}

# Load the saved theme at shell startup
if [[ -f ~/.selected_theme ]]; then
  case $(cat ~/.selected_theme) in
    starship)
      eval "$(starship init zsh)"
      ;;
    powerlevel10k)
      ZSH_THEME="powerlevel10k/powerlevel10k"
      ;;
  esac
fi



[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$HOME/.local/bin:$PATH
