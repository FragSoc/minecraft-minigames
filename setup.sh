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

# Download maps

# Decompress and copy static maps in
for mode in "${GAME_MODES[@]}"; do
  rm -rv data/$mode/world* /tmp/$mode
  unzip static_maps/$mode.zip -d /tmp
  cp -vr /tmp/$mode/* data/$mode
done

# Download ops file
if [ -n "${OPS_GDRIVE_ID}" ]; then
  wget --no-check-certificate "https://docs.google.com/uc?export=download&id=${OPS_GDRIVE_ID}" -O data/bedwars/ops.json
  cp data/bedwars/ops.json data/hungergames/ops.json
  cp data/bedwars/ops.json data/thewalls/ops.json
fi

# Restart servers
docker-compose restart "${GAME_MODES[@]}"
