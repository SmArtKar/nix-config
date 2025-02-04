# NuShell config file
# Colors are assigned automatically by Stylix, so 
# that's something that we don't have to worry about

# Common ls aliases and sort them by type and then name
# Inspired by https://github.com/nushell/nushell/issues/7190
def lla [...args] { ls -la ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
def la  [...args] { ls -a  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
def ll  [...args] { ls -l  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
def l   [...args] { ls     ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }

let carapace_completer = {|spans: list<string>|
  carapace $spans.0 nushell ...$spans
  | from json
  | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
}
# Some only work through bridges, i.e. tailscale
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

# zoxide completions https://www.nushell.sh/cookbook/external_completers.html#zoxide-completer
let zoxide_completer = {|spans|
  $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

# https://www.nushell.sh/cookbook/external_completers.html#alias-completions
let multiple_completers = {|spans|
  ## alias fixer start https://www.nushell.sh/cookbook/external_completers.html#alias-completions
  let expanded_alias = scope aliases
  | where name == $spans.0
  | get -i 0.expansion

  let spans = if $expanded_alias != null {
    $spans
    | skip 1
    | prepend ($expanded_alias | split row ' ' | take 1)
  } else {
    $spans
  }
  ## alias fixer end
  match $spans.0 {
    __zoxide_z | __zoxide_zi => $zoxide_completer
    _ => $carapace_completer
  } | do $in $spans
}

$env.config = {
  show_banner: false
  table: {
    mode: rounded
    index_mode: always
    show_empty: true
    trim: {
      methodology: wrapping
      wrapping_try_keep_words: true
      truncating_suffix: "..."
    }
  }

  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "prefix" # Fuzzy completion is cursed as hell
    external: {
      enable: true
      max_results: 100
      #completer: $multiple_completers # See nushell.nix
    }
  }

  filesize: {
    metric: false # why is this on by default...
    format: "auto"
  }

  cursor_shape: {
    vi_insert: line
    vi_normal: underscore
  }

  footer_mode: "auto"
  float_precision: 2
  bracketed_paste: true
  edit_mode: vi
  shell_integration: {
    osc2: true
    osc7: true
    osc8: true
    osc9_9: false
    osc133: true
    osc633: true
    reset_application_mode: true
  }
  render_right_prompt_on_last_line: false
}

$env.PATH = ($env.PATH |
  split row (char esep) |
  append /usr/bin/env
)

