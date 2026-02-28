Paagos
======

Simple winter platformer built in GameMaker.

**Quick Start**
- **Open project:** open `Paagos.yyp` in GameMaker and run the IDE.
- **Run in Debug:** Use GameMaker's Debug Run to see Output/Errors.

**Player dash behavior**
- **How to test:** press `Space` to dash. While dashing the player sprite switches to the dashing variant; when dash ends it returns to normal.
- **Files changed:** `objects/oPlayer/Create_0.gml` and `objects/oPlayer/Step_0.gml` (sprite variables `spr_normal` / `spr_dashing` and `sprite_index` toggles). Two sprite resources were added: `sprites/sPlayer/sPlayer_normal.yy` and `sprites/sPlayer/sPlayer_dashing.yy`.

**Build / CLI notes**
- This repository was pushed to GitHub at https://github.com/Nyileve/Paagos.
- For headless or CI builds, use the official GameMaker command-line exporter from YoYoGames (may require an entitled license). As a quick local CLI you can symlink the in-app binary:

```bash
mkdir -p "$HOME/bin"
ln -sf "/Applications/GameMaker.app/Contents/MacOS/arm64/GameMaker" "$HOME/bin/gamemaker"
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Note: the bundled binary may launch GUI helpers and can error; prefer the official CLI for headless builds.

**Contributing**
- Open an issue or a PR on the GitHub repo. Keep changes small and focused.

**License**
- No license file included — add one if you want this repo to be public-source.
