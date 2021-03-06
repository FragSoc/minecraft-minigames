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
if [ -n "${BEDWARS_PLUGIN_URL}" ]; then
  curl -L "${BEDWARS_PLUGIN_URL}" -o "data/bedwars/plugins/BedWars.jar"
fi
curl -L "https://github.com/kernitus/BukkitOldCombatMechanics/releases/download/${OLD_COMBAT_MECHANICS_VERSION}/OldCombatMechanics.jar" -o "/tmp/OldCombatMechanics.jar"
for mode in "${GAME_MODES[@]}"; do
  cp -v /tmp/OldCombatMechanics.jar data/$mode/plugins
done
rm -fv /tmp/OldCombatMechanics.jar

# Download maps

if [[ "$1" == "--use-static-maps" || "$1" == "-s" ]]; then
  # Decompress and copy static maps in
  for mode in "${GAME_MODES[@]}"; do
    rm -rfv data/$mode/world* /tmp/$mode
    unzip static_maps/$mode/world.zip -d /tmp
    cp -vr /tmp/$mode/* data/$mode
  done
  # Map-specific configs
  mkdir -p data/hungergames/plugins/HungerGames data/bedwars/plugins/BedWars/arenas
  cp -v static_maps/bedwars/Arena.yml data/bedwars/plugins/BedWars/arenas/Arenas.yml
  cp -v static_maps/bedwars/sign.yml data/bedwars/plugins/BedWars/sign.yml
  cp -v static_maps/hungergames/arenas.yml data/hungergames/plugins/HungerGames/arenas.yml
fi

# Download ops file
if [ -n "${OPS_FILE_URL}" ]; then
  curl -L -o /tmp/minecraft-ops.json "${OPS_FILE_URL}"
  for mode in "${GAME_MODES[@]}"; do
    cp -v /tmp/minecraft-ops.json data/$mode/ops.json
  done
  rm -fv /tmp/minecraft-ops.json
fi

# Restart servers
docker-compose restart "${GAME_MODES[@]}" || docker-compose up -d "${GAME_MODES[@]}"
