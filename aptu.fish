# sudo apt update, upgrade -y en autoremove -y
function aptu
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove -y
end
