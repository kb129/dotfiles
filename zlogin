# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# 設定：監視ファイルと実行間隔（分）
: "${REPO_WATCH_LIST:=${XDG_CONFIG_HOME:-$HOME/.config}/repo-watch/repos.txt}"
: "${REPO_WATCH_INTERVAL_MIN:=180}"  # 既定: 3時間に1回

# 状態保存ディレクトリ
: "${REPO_WATCH_STATE_DIR:=${XDG_STATE_HOME:-$HOME/.local/state}/repo-watch}"
REPO_WATCH_LASTRUN="$REPO_WATCH_STATE_DIR/lastrun"

repo_watch_notify() {
  local msg="$1"
  # Linux (notify-send), macOS (osascript) に対応。なければ echo。
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "Git updates found" "$msg"
  elif [[ "$OSTYPE" == darwin* ]]; then
    /usr/bin/osascript -e "display notification $(printf %q "$msg") with title \"Git updates found\""
  else
    print -P "%F{yellow}[repo-watch]%f $msg"
  fi
}

repo_watch_run() {
  # 実行間隔チェック
  mkdir -p "$REPO_WATCH_STATE_DIR"
  if [[ -f "$REPO_WATCH_LASTRUN" ]]; then
    local last epoch_now diff
    last=$(<"$REPO_WATCH_LASTRUN")
    epoch_now=$(printf '%(%s)T' -1)
    diff=$(( (epoch_now - last) / 60 ))
    (( diff < REPO_WATCH_INTERVAL_MIN )) && return 0
  fi

  # 監視リスト存在チェック
  [[ -r "$REPO_WATCH_LIST" ]] || return 0

  local updates=() line repo ahead behind upstream
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" || "$line" == \#* ]] && continue
    repo=${~line}  # ~ 展開（~ をホームに）
    [[ -d "$repo/.git" ]] || continue

    (
      cd "$repo" || exit
      # upstream がないブランチはスキップ
      if ! upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null); then
        exit 0
      fi
      # 静かに fetch
      git fetch --quiet --prune 2>/dev/null

      # 進捗カウント（左が upstream、右が HEAD）
      # 例: "2 5" => upstreamが2進み（こちらが2 behind）、こちらが5進み（5 ahead）
      read -r ahead behind <<<$(
        git rev-list --left-right --count "HEAD...@{upstream}" \
        | awk '{print $3, $1}'
      )

      # behind が 1 以上ならリモートに新着あり
      if [[ -n "$behind" && "$behind" -gt 0 ]]; then
        local branch
        branch=$(git rev-parse --abbrev-ref HEAD)
        updates+=("${repo}  (${branch} ← ${upstream})  behind:${behind} ahead:${ahead:-0}")
      fi
    )
  done < "$REPO_WATCH_LIST"

  if (( ${#updates[@]} )); then
    local body="Updates in:\n- ${(j:\n- :)updates}"
    repo_watch_notify "$body"
  fi
  printf '%(%s)T' -1 >| "$REPO_WATCH_LASTRUN"
}

repo_watch_run
