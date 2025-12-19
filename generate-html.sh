#!/bin/bash

# Generate index.html from template and .m4r files in out/

items_file=$(mktemp)

find out -name "*.m4r" -type f | sort | while read -r file; do
    filename=$(basename "$file")
    artist="${filename% - *}"
    title="${filename#* - }"
    title="${title%.m4r}"

    # Find matching file in in/ (any extension)
    base_pattern="$artist - $title"
    in_file=$(find in -type f \( -name "$base_pattern.m4a" -o -name "$base_pattern.wav" -o -name "$base_pattern.mp3" \) 2>/dev/null | head -1)
    in_filename=$(basename "$in_file" 2>/dev/null)

    # Capitalize each word
    artist_display=$(echo "$artist" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')
    title_display=$(echo "$title" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')

    artist_lower=$(echo "$artist" | tr '[:upper:]' '[:lower:]')
    cat <<EOF >> "$items_file"
            <div class="ringtone-item" data-artist="$artist_lower">
                <a href="in/$in_filename" class="play-btn">▶</a>
                <div class="ringtone-info">
                    <span class="artist">$artist_display</span>
                    <span class="title">$title_display</span>
                </div>
                <a href="out/$filename" download class="download-btn">⬇</a>
            </div>
EOF
done

# Replace placeholder with items
awk -v items_file="$items_file" '
    /\{\{RINGTONES\}\}/ {
        while ((getline line < items_file) > 0) print line
        close(items_file)
        next
    }
    { print }
' index.template.html > index.html

rm "$items_file"

count=$(find out -name "*.m4r" -type f 2>/dev/null | wc -l | tr -d ' ')
echo "Generated index.html with $count ringtones"
