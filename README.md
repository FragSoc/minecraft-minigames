# Minecraft Minigames Plug and Play

Game Mode | Service Name | IP-based Address | Host-based Address
---|---|---|---
Hunger Games | `hungergames` | `<your ip>:25568` | `hungergames.<your domain>`
The Walls | `thewalls` | `<your ip>:25567` | `thewalls.<your domain>`
Bed Wars | `bedwars` | `<your ip>:25566` | `bedwars.<your domain>`

## Setup

1. Ensure you have [Git LFS](https://git-lfs.github.com/) set up
1. Copy `vars.sh.example` to `vars.sh` and change variable values as necessary
1. Run `./setup.sh`, adding the `-s` flag if you want to install our static maps
1. Bring servers online with `docker-compose up -d`

## Connecting

If you have a domain name pointing at the server you're running on, specify it in the `vars.sh` file, make sure the `router` service is up (`docker-compose up -d router`), and you can connect to them with the address in the table below.

If you don't have a domain name, use the IP-based address in the table below.
