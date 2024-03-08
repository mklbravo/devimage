#!/bin/sh

# ##############################################################################
#  Functions
# ##############################################################################

get_os_id() {
  echo $(sed -n 's/^ID=\(.*\)$/\1/p' /etc/os-release)
}

install_packages() {
  OS_ID=$(get_os_id)

  case $OS_ID in
    "ubuntu" | "debian")
      echo "apt-get install --no-install-recommends --yes $@"
      ;;
    *)
      echo "Unsupported OS: '{$OS_ID}'"
      exit 1
      ;;
  esac
}

update_repositories_info() {
  OS_ID=$(get_os_id)

  case $OS_ID in
    "ubuntu" | "debian")
      echo "apt-get update -y"
      ;;
    *)
      echo "Unsupported OS: '{$OS_ID}'"
      exit 1
      ;;
  esac
}

# ##############################################################################
#  Entry Point
# ##############################################################################
ACTION=$1

case $ACTION in
  "install")
    shift # Removes the first argument from the list of command-line arguments
    eval $(install_packages $@)
    ;;
  "update")
    eval $(update_repositories_info)
    ;;
  *)
    echo "Usage: $0 {install|remove}"
    exit 1
    ;;
esac



