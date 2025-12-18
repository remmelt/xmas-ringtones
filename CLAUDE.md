# Xmas Ringtones Site

Static site for hosting iPhone ringtones on Cloudflare Pages.

## Adding Ringtones

1. Add `.m4r` files with naming pattern: `artist - title.m4r`
2. Update `index.html` - add a new entry in the `.ringtone-list` div:
   ```html
   <div class="ringtone-item">
       <span class="artist">Artist</span>
       <span class="separator">:</span>
       <span class="title"><a href="artist - title.m4r" download>title</a></span>
   </div>
   ```
3. Commit and push

## Setup on New Computer

```bash
git clone git@github.com:remmelt/xmas-ringtones.git
```

## Cloudflare Pages

Connected to GitHub repo, auto-deploys on push to main.
Custom domain: `xmas-ringtones.remmelt.com`

## URLs

- Repo: https://github.com/remmelt/xmas-ringtones
- Site: https://xmas-ringtones.remmelt.com
