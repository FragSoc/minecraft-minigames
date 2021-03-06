# Minecraft Minigames Plug and Play

A repo to help run [Minecraft](https://www.minecraft.net) multiplayer minigames quickly, with a few commands out of the box.

Uses itzg's [minecraft docker image](https://github.com/itzg/docker-minecraft-server) and [minecraft router](https://github.com/itzg/mc-router).

Game Mode | Service Name | IP-based Address | Host-based Address
---|---|---|---
[Hunger Games](https://github.com/ShaneBeeStudios/HungerGames) | `hungergames` | `<your ip>:25568` | `hungergames.<your domain>`
The Walls | `thewalls` | `<your ip>:25567` | `thewalls.<your domain>`
[Bed Wars](https://github.com/ScreamingSandals/BedWars) | `bedwars` | `<your ip>:25566` | `bedwars.<your domain>`

## Setup

1. Clone this repo: `git clone https://github.com/FragSoc/minecraft-minigames`
1. Copy `vars.sh.example` to `vars.sh` and change variable values as necessary (instructions in the file)
1. Run `./setup.sh`, adding the `-s` flag if you want to install our static maps (you will need [Git LFS](https://git-lfs.github.com/) for these)
1. Bring servers online with `docker-compose up -d`

### Dependencies

- A docker-compatible unix system; windows not supported (yet)
- [`git`](https://git-scm.com/)
- [`docker`](https://docs.docker.com/engine/install/)
- [`docker-compose`](https://docs.docker.com/compose/install/)
- [`git lfs`](https://git-lfs.github.com/) if you want to use the inbuilt static maps

### Custom Worlds

If you want to use your own worlds in the games, don't pass the `-s` flag to the setup script.
Instead, unpack your world files (`world`, `world_the_end`, `world_the_nether`), into the respective `data` folder for the gamemode.
Special configuration might be required:

- For hunger games, follow the setup guide [on the plugin wiki](https://github.com/ShaneBeeStudios/HungerGames/wiki/Arena-Setup)
- For bed wars, follow the setup guide [on the bukkit page](https://dev.bukkit.org/projects/bedwars/pages/setup)

## Usage

If you have a domain name pointing at the server you're running on, specify it in the `vars.sh` file, make sure the `router` service is up (`docker-compose up -d router`), and you can connect to them with the domain address in the table.

To connect without a domain name, use the IP-based address in the table.
