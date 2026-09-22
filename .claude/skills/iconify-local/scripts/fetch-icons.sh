#!/bin/bash
# Iconify 图标下载脚本
# 用法: ./fetch-icons.sh "lucide:home,mdi:account,tabler:settings"

ICONS_DIR="assets/icons"
INDEX_FILE="$ICONS_DIR/index.json"

mkdir -p "$ICONS_DIR"

# 初始化索引
echo '{"icons": []}' > "$INDEX_FILE"

for icon_spec in "$@"; do
  IFS=',' read -ra ICONS <<< "$icon_spec"
  for icon in "${ICONS[@]}"; do
    collection=$(echo "$icon" | cut -d: -f1)
    name=$(echo "$icon" | cut -d: -f2)

    if [[ -z "$name" ]]; then
      name="$collection"
      collection="lucide"
    fi

    url="https://api.iconify.design/$collection/$name.svg"
    output_file="$ICONS_DIR/${collection}-${name}.svg"

    curl -s "$url" -o "$output_file"

    if [[ -f "$output_file" ]]; then
      echo "Downloaded: $collection:$name"
      # 更新索引（简化版）
    fi
  done
done

echo "Icons downloaded to $ICONS_DIR/"