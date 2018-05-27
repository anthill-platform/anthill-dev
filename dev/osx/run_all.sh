echo "Starting all anthill services..."
source /usr/local/venv/dev/bin/activate
cd ../

start_service () {
    echo "Starting service $1"
    cd ../$1
    PYTHONPATH="../common/src" python src/server.py &
}

start_service "admin"
start_service "config"
start_service "discovery"
start_service "dlc"
start_service "environment"
start_service "event"
start_service "exec"
start_service "game-controller"
start_service "game-master"
start_service "leaderboard"
start_service "login"
start_service "message"
start_service "profile"
start_service "promo"
start_service "report"
start_service "social"
start_service "static"
start_service "store"

read -p "Press enter to stop."
pkill -P $$
