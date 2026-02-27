#!/bin/bash
#
# 版本号更新脚本
# 使用方法: ./bump-version.sh <major|minor|patch>
#

set -e

# 获取当前版本
CURRENT_VERSION=$(grep '"version"' package.json | head -1 | sed 's/.*"version": *"\([^"]*\)".*/\1/')

# 解析版本号
MAJOR=$(echo $CURRENT_VERSION | cut -d. -f1)
MINOR=$(echo $CURRENT_VERSION | cut -d. -f2)
PATCH=$(echo $CURRENT_VERSION | cut -d. -f3)

# 根据参数更新版本号
case "$1" in
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    patch)
        PATCH=$((PATCH + 1))
        ;;
    *)
        echo "使用方法: ./bump-version.sh <major|minor|patch>"
        echo ""
        echo "  major - 主版本号 +1 (不兼容的 API 修改)"
        echo "  minor - 次版本号 +1 (向下兼容的功能新增)"
        echo "  patch - 修订号 +1 (向下兼容的问题修复)"
        echo ""
        echo "当前版本: v${CURRENT_VERSION}"
        exit 1
        ;;
esac

NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"

echo ""
echo "版本更新: v${CURRENT_VERSION} → v${NEW_VERSION}"
echo ""

# 1. 更新 package.json
sed -i.bak "s/\"version\": \"${CURRENT_VERSION}\"/\"version\": \"${NEW_VERSION}\"/" package.json
rm -f package.json.bak
echo "✅ 已更新 package.json"

# 2. 更新 ui.tsx 中的版本号
sed -i.bak "s/v${CURRENT_VERSION}/v${NEW_VERSION}/g" src/ui.tsx
rm -f src/ui.tsx.bak
echo "✅ 已更新 src/ui.tsx"

# 3. 提示更新 CHANGELOG.md
echo ""
echo "📝 请手动更新 CHANGELOG.md，添加 v${NEW_VERSION} 的变更记录"
echo ""
echo "   建议格式："
echo ""
echo "   ## [${NEW_VERSION}] - $(date +%Y-%m-%d)"
echo ""
echo "   ### 新增"
echo "   - ..."
echo ""
echo "   ### 修改"
echo "   - ..."
echo ""
echo "   ### 修复"
echo "   - ..."
echo ""
