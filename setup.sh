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

# Decompress and copy static maps in
for mode in "${GAME_MODES[@]}"; do
  rm -rv data/$mode/world* /tmp/$mode
  unzip static_maps/$mode/world.zip -d /tmp
  cp -vr /tmp/$mode/* data/$mode
done
# Map-specific configs
cp -v static_maps/bedwars/Arena.yml data/bedwars/plugins/BedWars/arenas/Arenas.yml
cp -v static_maps/hungergames/arenas.yml data/hungergames/plugins/HungerGames/arenas.yml

# Download ops file
if [ -n "${OPS_FILE_URL}" ]; then
  wget --no-check-certificate "${OPS_FILE_URL}" -O tmp/minecraft-ops.json
  for mod in "${GAME_MODES[@]}"; do
    cp -v /tmp/minecraft-ops.json data/$mode/ops.json
  done
  rm -v /tmp/minecraft-ops.json
fi

# Restart servers
docker-compose restart "${GAME_MODES[@]}"
