#!/usr/bin/env bash

echo "Starting all anthill services..."
source /usr/local/venv/dev3/bin/activate
cd ../

start_service () {
    echo "Starting service $2"
    cd "../$1"
    PYTHONPATH="../common" python -m "$2" &
}

start_service "admin" "anthill.admin.server"
start_service "config" "anthill.config.server"
start_service "discovery" "anthill.discovery.server"
start_service "dlc" "anthill.dlc.server"
start_service "environment" "anthill.environment.server"
start_service "event" "anthill.event.server"
start_service "exec" "anthill.exec.server"
start_service "game-controller" "anthill.game.controller.server"
start_service "game-master" "anthill.game.master.server"
start_service "leaderboard" "anthill.leaderboard.server"
start_service "login" "anthill.login.server"
start_service "message" "anthill.message.server"
start_service "profile" "anthill.profile.server"
start_service "promo" "anthill.promo.server"
start_service "report" "anthill.report.server"
start_service "social" "anthill.social.server"
start_service "static" "anthill.static.server"
start_service "store" "anthill.store.server"

read -p "Press enter to stop."
pkill -P $$
