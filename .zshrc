if [[ "$TERM" == "xterm-kitty" ]]; then
    neofetch
fi


alias open='xdg-open'
alias ..='cd ..'
alias ls='ls -a --color=auto'

function tree (){
  find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

# Git add and commit function
function gac() {
  git status
  git add .
  git status

  read -r "m?-m : "
  git commit -m "$m"
  git status

  read -r "push?push (y/n): "
  if [ "$push" == "y" ]; then
    git push
  else
    echo "Changes committed but not pushed."
  fi
}


# Theme toggle for Alacritty and Gnome background
function tt() {
  read -r "no?Enter the theme number: "
  echo "import = [  '~/.config/alacritty/themes/$no.toml']" > ~/.config/alacritty/import.toml
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/sugam/Pictures/wallpaper/$no.png
  clear
  neofetch
}
kk() {
  read -r "no?Enter the theme number: "
  # Update the Kitty terminal theme
  echo "include themes/$no.config" > ~/.config/kitty/import.config
  kitty @ set-colors --all ~/.config/kitty/themes/$no.config

  # Update the wallpaper
  gsettings set org.gnome.desktop.background picture-uri-dark file:///home/sugam/Pictures/wallpaper/$no.png

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

# Custom shortcuts to navigate to specific directories
function cdb() {
  cd ~/Desktop/files/bobby/
}
function cds() {
  cd ~/Desktop/files/sugam/
}
function cde() {
  cd ~/Desktop/files/etc/
}
# Custom cd command to open VSCode in the directory
function cdc() {
  if [ -z "$1" ]; then
    echo "No directory specified. Usage: cdc <directory>"
    return 1
  fi

  if [ ! -d "$1" ]; then
    echo "Directory '$1' does not exist."
    return 1
  fi

  cd "$1"
  code "."
}