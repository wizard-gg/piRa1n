#!/bin/sh
while true; do
  read -r -p "Auto shutdown [Y/n]: " input
  case $input in
      [yY][eE][sS]|[yY])
      sudo systemctl stop piRa1n.service
      echo "#!/bin/sh
sudo /home/pi/piRa1n/piRa1n -c -E
sudo /sbin/shutdown now" > /home/pi/piRa1n.sh
      break ;;
      [nN][oO]|[nN])
      sudo systemctl stop piRa1n.service
      echo "#!/bin/sh
while true
do
  sudo /home/pi/piRa1n/piRa1n -c -E
done" > /home/pi/piRa1n.sh
      break ;;
      *)
      echo "Invalid input..." ;;
  esac
done
while true; do
  read -r -p "Safe mode [Y/n]: " input
  case $input in
      [yY][eE][sS]|[yY])
      sed -i 's/^\(.*sudo \/home\/pi\/piRa1n\/piRa1n -c -E\).*$/& -s/g' /home/pi/piRa1n/piRa1n.sh
      break ;;
      [nN][oO]|[nN])
      break ;;
      *)
      echo "Invalid input..." ;;
  esac
done
while true; do
  read -r -p "Verbose boot [Y/n]: " input
  case $input in
      [yY][eE][sS]|[yY])
      sed -i 's/^\(.*sudo \/home\/pi\/piRa1n\/piRa1n -c -E\).*$/& -v/g' /home/pi/piRa1n/piRa1n.sh
      break ;;
      [nN][oO]|[nN])
      break ;;
      *)
      echo "Invalid input..." ;;
  esac
done
sudo systemctl start piRa1n.service
echo 'The changes have been applied!'
