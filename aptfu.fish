# sudo apt update, full-upgrade -y en autoremove -y
function aptu
  sudo apt update
  sudo apt full-upgrade -y
  sudo apt autoremove -y
end

