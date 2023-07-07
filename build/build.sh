#!/usr/bin/env bash
# DO NOT EDIT THIS FILE AS IT IS AUTOGENERATED!

# exit script when any command fails
set -e

# set output style only if terminal type is set and a tty
if [[ -z "$TERM" ]] || [[ ! -t 1 ]]; then
    normal=""
    bold=""
    blue=""
    green=""
else
    normal=$(tput -T "$TERM" sgr0)
    bold=$(tput -T "$TERM" bold)
    blue=$(tput -T "$TERM" setaf 4)
    green=$(tput -T "$TERM" setaf 2)
fi

enable_debugging () {
    if [[ $DEBUG = true ]]; then
        set -x
    fi
}

disable_debugging () {
    if [[ $DEBUG = true ]]; then
        set +x
    fi
}

now () {
    local timestamp
    timestamp="$(date +%s%N)"
    echo "${timestamp/N/000000000}"
}

ms_elapsed() {
    local timestamp_now
    timestamp_now=$(now)
    echo $(((10#$timestamp_now - 10#$1) / 1000000))ms
}

print_start_message() {
    echo "${bold}${blue}### $1 ###${normal}"
}

print_end_message() {
    echo "${bold}${green}=== $1: $(ms_elapsed "$2") [$(date +"%Y-%m-%d %H:%M:%S %Z")] ===${normal}"
}


# default values of variables set from params
_RUN_STEP_NODE=false
_RUN_STEP_YARN_SETUP=false
_RUN_STEP_YARN_SYMLINK=false
_RUN_STEP_VERSIONS=false
_RUN_STEP_YARN_INSTALL=false
_RUN_STEP_BROWSERSLIST=false
_RUN_STEP_ENV=false
_RUN_STEP_UPDATE_EMOJIS=false
_RUN_STEP_FORMAT=false
_RUN_STEP_ESLINT=false
_RUN_STEP_TSC=false
_RUN_STEP_USERSCRIPT=false
_RUN_STEP_BUILDSCRIPT=false
_RUN_STEP_PREBUILD=false
_RUN_STEP_WEBPACK=false
_RUN_STEP_DOCS=false
_RUN_STEP_GIT_DIFF=false
MODE="development"
DEBUG=false

while :; do
    case "${1-}" in
        --node) _RUN_STEP_NODE=true ;;
        --yarn_setup) _RUN_STEP_YARN_SETUP=true ;;
        --yarn_symlink) _RUN_STEP_YARN_SYMLINK=true ;;
        --versions) _RUN_STEP_VERSIONS=true ;;
        --yarn_install) _RUN_STEP_YARN_INSTALL=true ;;
        --browserslist) _RUN_STEP_BROWSERSLIST=true ;;
        --env) _RUN_STEP_ENV=true ;;
        --update_emojis) _RUN_STEP_UPDATE_EMOJIS=true ;;
        --format) _RUN_STEP_FORMAT=true ;;
        --eslint) _RUN_STEP_ESLINT=true ;;
        --tsc) _RUN_STEP_TSC=true ;;
        --userscript) _RUN_STEP_USERSCRIPT=true ;;
        --buildscript) _RUN_STEP_BUILDSCRIPT=true ;;
        --prebuild) _RUN_STEP_PREBUILD=true ;;
        --webpack) _RUN_STEP_WEBPACK=true ;;
        --docs) _RUN_STEP_DOCS=true ;;
        --git_diff) _RUN_STEP_GIT_DIFF=true ;;
        --dependencies)
          _RUN_STEP_YARN_SETUP=true
          _RUN_STEP_VERSIONS=true
          _RUN_STEP_YARN_INSTALL=true
          _RUN_STEP_BROWSERSLIST=true ;;
        --quick)
          _RUN_STEP_ENV=true
          _RUN_STEP_FORMAT=true
          _RUN_STEP_ESLINT=true
          _RUN_STEP_TSC=true
          _RUN_STEP_WEBPACK=true ;;
        --pre-commit)
          _RUN_STEP_FORMAT=true
          _RUN_STEP_ESLINT=true
          _RUN_STEP_TSC=true ;;
        --full)
          _RUN_STEP_NODE=true
          _RUN_STEP_YARN_SETUP=true
          _RUN_STEP_YARN_SYMLINK=true
          _RUN_STEP_VERSIONS=true
          _RUN_STEP_YARN_INSTALL=true
          _RUN_STEP_BROWSERSLIST=true
          _RUN_STEP_ENV=true
          _RUN_STEP_UPDATE_EMOJIS=true
          _RUN_STEP_FORMAT=true
          _RUN_STEP_ESLINT=true
          _RUN_STEP_TSC=true
          _RUN_STEP_USERSCRIPT=true
          _RUN_STEP_BUILDSCRIPT=true
          _RUN_STEP_PREBUILD=true
          _RUN_STEP_WEBPACK=true
          _RUN_STEP_DOCS=true
          _RUN_STEP_GIT_DIFF=true ;;
        -p | --production) MODE="production" ;;
        --debug) DEBUG=true ;;
        -?*)
          echo "Unknown option: $1"
          exit 1 ;;
        *) break ;;
    esac
    shift
done

total_start_time=$(now)

NODE_VERSION=$(grep '"node":' ./package.json | awk -F: '{ print $2 }' | sed 's/[",]//g' | sed 's/\^v//g' | tr -d '[:space:]')
YARN_VERSION=$(grep '"packageManager":' ./package.json | awk -F: '{ print $2 }' | sed 's/[",]//g' | sed 's/yarn@//g' | tr -d '[:space:]')
if [[ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
    GIT_REPO=true
fi
if [[ $GIT_REPO = true ]]; then
    GIT_BRANCH=$(git branch --show-current)
    # Set ref to latest commit hash if HEAD is detached otherwise use branch name
    if [[ -z "$GIT_BRANCH" ]]; then
        REF=$(git rev-parse --short HEAD)
    else
        # | xargs to remove leading and trailing whitespaces
        REF=$(git show-ref --heads --abbrev "$GIT_BRANCH" | grep -Eo " .*$" --color=never | xargs)
    fi
else
    REF="dev"
fi

# [⬆️] Setup Node.js
if [[ $_RUN_STEP_NODE = true ]]; then
    start_time=$(now)
    print_start_message "[⬆️] Setup Node.js"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    if [[ -n "${NVM_DIR-}" ]]; then
        NVM_DIR="$NVM_DIR"
    elif [[ -n "${XDG_CONFIG_HOME-}" ]]; then
        NVM_DIR="${XDG_CONFIG_HOME}/nvm"
    else
        NVM_DIR="$HOME/.nvm"
    fi
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install "$NODE_VERSION"
    print_end_message "[⬆️] Setup Node.js" "$start_time"
fi

# [⬆] setup yarn
if [[ $_RUN_STEP_YARN_SETUP = true ]]; then
    start_time=$(now)
    print_start_message "[⬆] setup yarn"
    enable_debugging
    corepack enable
    yarn set version "$YARN_VERSION"
    disable_debugging
    print_end_message "[⬆] setup yarn" "$start_time"
fi

# [🔗] symlink yarn executable
if [[ $_RUN_STEP_YARN_SYMLINK = true ]]; then
    start_time=$(now)
    print_start_message "[🔗] symlink yarn executable"
    enable_debugging
    ln -sf "$(find ./.yarn/releases/ -name 'yarn-*.cjs')" ./yarn
    disable_debugging
    print_end_message "[🔗] symlink yarn executable" "$start_time"
fi

# [ℹ] print versions (node, yarn, git)
if [[ $_RUN_STEP_VERSIONS = true ]]; then
    start_time=$(now)
    print_start_message "[ℹ] print versions (node, yarn, git)"
    enable_debugging
    echo "node: $(node -v) – yarn: $(yarn -v) – git: $(git --version)"
    disable_debugging
    print_end_message "[ℹ] print versions (node, yarn, git)" "$start_time"
fi

# [🍱] yarn install
if [[ $_RUN_STEP_YARN_INSTALL = true ]]; then
    start_time=$(now)
    print_start_message "[🍱] yarn install"
    enable_debugging
    yarn install --immutable
    disable_debugging
    print_end_message "[🍱] yarn install" "$start_time"
fi

# [⬆] update browserslist
if [[ $_RUN_STEP_BROWSERSLIST = true ]]; then
    start_time=$(now)
    print_start_message "[⬆] update browserslist"
    enable_debugging
    npx -y browserslist@latest --update-db
    disable_debugging
    print_end_message "[⬆] update browserslist" "$start_time"
fi

# [🌳] set env variables
if [[ $_RUN_STEP_ENV = true ]]; then
    start_time=$(now)
    print_start_message "[🌳] set env variables"
    enable_debugging
    ref="$REF"
    BRANCH="dummy"
    
    if [[ $ref == "refs/heads/master" ]]; then
      BRANCH="stable"
    elif [[ $ref == "refs/heads/dev" ]]; then
      BRANCH="beta";
    elif [[ $ref == "refs/heads/"* ]]; then
      BRANCH="${ref/"refs/heads/"/}";
      BRANCH="${BRANCH/"/"/"-"}"
    elif [[ $ref == "refs/pull/"* ]]; then
      BRANCH="${ref/"refs/pull/"/"pr"}";
      BRANCH="${BRANCH/"/merge"/}";
      BRANCH="${BRANCH//"/"/"-"}"
    fi
    disable_debugging
    print_end_message "[🌳] set env variables" "$start_time"
fi

# [⬆] update emojis
if [[ $_RUN_STEP_UPDATE_EMOJIS = true ]]; then
    start_time=$(now)
    print_start_message "[⬆] update emojis"
    enable_debugging
    yarn ts-node scripts/utils/fetchEmojis.ts
    disable_debugging
    print_end_message "[⬆] update emojis" "$start_time"
fi

# [🎨] format files not covered by ESLint
if [[ $_RUN_STEP_FORMAT = true ]]; then
    start_time=$(now)
    print_start_message "[🎨] format files not covered by ESLint"
    enable_debugging
    yarn ts-node scripts/format.ts || exit 1
    disable_debugging
    print_end_message "[🎨] format files not covered by ESLint" "$start_time"
fi

# [🚨] run ESLint
if [[ $_RUN_STEP_ESLINT = true ]]; then
    start_time=$(now)
    print_start_message "[🚨] run ESLint"
    enable_debugging
    yarn eslint \
    ./docs/.vuepress/ \
    ./static/         \
    ./prebuild/       \
    ./build/          \
    ./src/            \
    ./scripts/        \
    ./typings/        \
    --ext .js,.ts,.vue,.md \
    --no-error-on-unmatched-pattern \
    --exit-on-fatal-error \
    --report-unused-disable-directives \
    --cache --cache-strategy content \
    --fix \
    || exit 1
    disable_debugging
    print_end_message "[🚨] run ESLint" "$start_time"
fi

# [🚨] check TypeScript
if [[ $_RUN_STEP_TSC = true ]]; then
    start_time=$(now)
    print_start_message "[🚨] check TypeScript"
    enable_debugging
    yarn tsc -b --pretty "./" || exit 1
    disable_debugging
    print_end_message "[🚨] check TypeScript" "$start_time"
fi

# [📜] build userscript
if [[ $_RUN_STEP_USERSCRIPT = true ]]; then
    start_time=$(now)
    print_start_message "[📜] build userscript"
    enable_debugging
    yarn tsc --pretty --project "src/tsconfig.userscript.json" || exit 1
    disable_debugging
    print_end_message "[📜] build userscript" "$start_time"
fi

# [📜] build buildscript
if [[ $_RUN_STEP_BUILDSCRIPT = true ]]; then
    start_time=$(now)
    print_start_message "[📜] build buildscript"
    enable_debugging
    yarn ts-node scripts/createBuildScript.ts || exit 1
    disable_debugging
    print_end_message "[📜] build buildscript" "$start_time"
fi

# [🚧] run prebuild
if [[ $_RUN_STEP_PREBUILD = true ]]; then
    start_time=$(now)
    print_start_message "[🚧] run prebuild"
    enable_debugging
    yarn ts-node prebuild/index.ts "$MODE" "$BRANCH" "🦄 branch label" || exit 1
    disable_debugging
    print_end_message "[🚧] run prebuild" "$start_time"
fi

# [👷] webpack
if [[ $_RUN_STEP_WEBPACK = true ]]; then
    start_time=$(now)
    print_start_message "[👷] webpack"
    enable_debugging
    yarn ts-node build/index.ts --esModuleInterop "$MODE" "$BRANCH" "🦄 branch label" || exit 1
    disable_debugging
    print_end_message "[👷] webpack" "$start_time"
fi

# [📝] build docs
if [[ $_RUN_STEP_DOCS = true ]]; then
    start_time=$(now)
    print_start_message "[📝] build docs"
    enable_debugging
    "$(yarn workspace lss-manager-v4-docs bin vuepress)" build docs || exit 1
    mkdir -p ./dist/docs
    rm -rdf ./dist/docs/*
    cp -r ./docs/.vuepress/dist/* ./dist/docs
    disable_debugging
    print_end_message "[📝] build docs" "$start_time"
fi

# [ℹ️] git diff
if [[ $_RUN_STEP_GIT_DIFF = true ]] && [[ $GIT_REPO = true ]]; then
    start_time=$(now)
    print_start_message "[ℹ️] git diff"
    enable_debugging
    git --no-pager diff --color-words
    disable_debugging
    print_end_message "[ℹ️] git diff" "$start_time"
fi

print_end_message "Total" "$total_start_time"

exit 0