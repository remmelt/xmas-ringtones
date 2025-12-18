#!/bin/bash

# Generate index.html from template and .m4r files in out/

items_file=$(mktemp)

find out -name "*.m4r" -type f | sort | while read -r file; do
    filename=$(basename "$file")
    artist="${filename% - *}"
    title="${filename#* - }"
    title="${title%.m4r}"

    # Capitalize each word
    artist=$(echo "$artist" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')
    title=$(echo "$title" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')

    cat <<EOF >> "$items_file"
            <div class="ringtone-item">
                <a href="out/$filename" download>
                    <div class="ringtone-info">
                        <span class="artist">$artist</span>
                        <span class="title">$title</span>
                    </div>
                    <span class="download-icon">⬇</span>
                </a>
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
