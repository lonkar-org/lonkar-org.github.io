# lonkar-org.github.io

The org's own GitHub Pages site, at https://with-love.lonkar.org. Every
lonkar-org repository with Pages turned on is served under it at its name,
so tmux-companion's docs are at https://with-love.lonkar.org/tmux-companion/.

`docs/index.html` lists them; a repository that gets a Pages site gets an
item there. Pages publishes `docs/` only, so `infra/` stays off the site.

`infra/` holds the one DNS record this needs, `with-love.lonkar.org`, and
nothing else of the lonkar.org zone, which is lonkar-org/lonkar.org's. The
Infra workflow plans it on every change and applies it on main, with state in
R2 at `tfstates/lonkar-org.github.io/infra.tfstate`. Locally,
`scripts/terraform.sh` reads the secrets from `infra/.env.local`, which is
gitignored.
