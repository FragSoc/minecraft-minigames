#!/usr/bin/env bash
set -eo pipefail

source vars.sh

GAME_MODES=(
  "thewalls"
  "hungergames"
  "bedwars"
)

# Download plugins
curl -L "https://github.com/ShaneBeeStudios/HungerGames/releases/download/${HUNGER_GAMES_VERSION}/HungerGames-${HUNGER_GAMES_VERSION}.jar" -o "data/hungergames/plugins/HungerGames-${HUNGER_GAMES_VERSION}.jar"
# Should really download BedWars here too, but the plugin's proprietary and curse provides obfuscated download links

# Download maps

if [ "$1" == "--use-static-maps" || "$1" == "-s" ]; then
  # Decompress and copy static maps in
  for mode in "${GAME_MODES[@]}"; do
    rm -rv data/$mode/world* /tmp/$mode
    unzip static_maps/$mode/world.zip -d /tmp
    cp -vr /tmp/$mode/* data/$mode
  done
  # Map-specific configs
  mkdir -p data/hungergames/plugins/HungerGames data/bedwars/plugins/Bedwars/arenas
  cp -v static_maps/bedwars/Arena.yml data/bedwars/plugins/Bedwars/arenas/Arenas.yml
  cp -v static_maps/hungergames/arenas.yml data/hungergames/plugins/HungerGames/arenas.yml
fi

# Download ops file
if [ -n "${OPS_FILE_URL}" ]; then
  wget -O /tmp/minecraft-ops.json "${OPS_FILE_URL}"
  for mode in "${GAME_MODES[@]}"; do
    cp -v /tmp/minecraft-ops.json data/$mode/ops.json
  done
  rm -v /tmp/minecraft-ops.json
fi

# Restart servers
docker-compose restart "${GAME_MODES[@]}"
