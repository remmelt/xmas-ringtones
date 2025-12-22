# Xmas Ringtones Site

Static site for hosting iPhone ringtones on Cloudflare Pages.

## Adding Ringtones

1. Add source audio to `in/` with naming pattern: `artist - title.m4a` (or `.wav`)
2. If wav files, run `make wav2m4a` to convert to m4a
3. Run `make build` to generate ringtones and HTML
4. Run `make deploy` to commit and push

## File Structure

- `in/` - source audio files (m4a, wav)
- `out/` - generated ringtones (m4r)
- `index.template.html` - HTML template with `{{RINGTONES}}` placeholder
- `generate-html.sh` - generates index.html from template and out/ files

## Makefile Targets

- `wav2m4a` - convert wav files in in/ to m4a
- `convert` - generate m4r files in out/ from in/
- `build` - convert + generate HTML
- `deploy` - git add, commit, push

## URL Filtering

Filter ringtones by artist using URL hash: `#artistname`

Example: `https://xmas-ringtones.remmelt.com/#ola`

## Cloudflare Pages

Connected to GitHub repo, auto-deploys on push to main.
Custom domain: `xmas-ringtones.remmelt.com`

## URLs

- Repo: https://github.com/remmelt/xmas-ringtones
- Site: https://xmas-ringtones.remmelt.com
