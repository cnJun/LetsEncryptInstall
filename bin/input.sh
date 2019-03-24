
cfg="$1"

if [ ! -n "$cfg" ]; then
    read -p "please enter config filename:" cfg
fi

if [ ! -n "$cfg" ]; then
    echo "please input config filename!"
    exit
fi

if [ ! -f "./$cfg.sh" ]; then
    echo "this config filename not exist!"
    exit
fi

source "./$cfg.sh"
