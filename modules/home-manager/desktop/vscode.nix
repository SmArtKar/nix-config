# vscode.nix

{ pkgs, inputs, config, lib, ... }:

# VSCode text editor

{
  options = {
    desktop.vscode.codium = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    home.packages = with pkgs; [
      biome
    ];

    programs.vscode = {
      enable = true;
      package = (if config.desktop.vscode.codium then pkgs.vscodium else pkgs.vscode);

      extensions = with pkgs.vscode-extensions; [
        biomejs.biome
        editorconfig.editorconfig
        file-icons.file-icons
        github.vscode-pull-request-github
        github.vscode-github-actions
        github.codespaces
        github.copilot
        github.copilot-chat
        vscodevim.vim
        esbenp.prettier-vscode
        leonardssh.vscord
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-wsl
        redhat.vscode-xml
        redhat.vscode-yaml
        shd101wyy.markdown-preview-enhanced
        tamasfe.even-better-toml
        visualstudioexptteam.vscodeintellicode
        vscode-icons-team.vscode-icons
      ] ++ 
        pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "dmi-editor";
          publisher = "anturk";
          version = "1.0.6";
          sha256 = "SX1716QhosY/CYQUpDrkoytRlnjL+hEJhPUGerczLXQ=";
        }
        {
          name = "vscode-zipfs";
          publisher = "arcanis";
          version = "3.0.0";
          sha256 = "yNRC03kV0UvpEp1gF+NK0N3iCoqZMQ+PAqtrHLXFeXM=";
        }
        {
          name = "vscode-styled-jsx";
          publisher = "blanu";
          version = "2.1.1";
          sha256 = "rvRLui9ivE5+I4VZJbSsdbcqFnssYV3gkmMk2Yrn9MU=";
        }
        {
          name = "byond-dm-language-support";
          publisher = "gbasood";
          version = "1.0.1";
          sha256 = "gmkqBFxben8ubh9p1Q4AqpZhJKXw0nqZf12sbupbEVw=";
        }
        {
          name = "gitless";
          publisher = "maattdd";
          version = "11.7.2";
          sha256 = "rYeZNBz6HeZ059ksChGsXbuOao9H5m5lHGXJ4ELs6xc=";
        }
        {
          name = "regexsnippets";
          publisher = "monish";
          version = "1.0.2";
          sha256 = "AbZ0BAbRodkcOIrOX8z00gL8fS8qKYp5YT+6XbcEZgI=";
        }
        {
          name = "dm-langclient";
          publisher = "platymuus";
          version = "0.2.5";
          sha256 = "D/+SVzUEia9cAgImE2GFdM6fV6Jls7rCJ13P06ML/04=";
        }
        {
          name = "js-jsx-snippets";
          publisher = "skyran";
          version = "11.1.3";
          sha256 = "sTloMfD9Nf3S9OrN14Ner5JyZKJFimGSklcbdVBkdWQ=";
        }
        {
          name = "byond";
          publisher = "ss13";
          version = "2.0.0";
          sha256 = "BMsV34W8CZ9YnIxCRMBJqTJysen2iY7kDB+qUdqEteE=";
        }
        {
          name = "opendream";
          publisher = "ss13";
          version = "0.2.3";
          sha256 = "SuoP8WWmC++eIhtWPpc9CwbwEIfQZJrNoc5xtgksFtg=";
        }
        {
          name = "grepc";
          publisher = "stneveadomi";
          version = "1.3.0";
          sha256 = "Duicl3AUvuDpE5uIZDfLUZ+LBrpnm6DpmW95BMnu/1s=";
        }
        {
          name = "auto-comment-blocks";
          publisher = "kevinkyang";
          version = "1.0.1";
          sha256 = "KwS69LhhmT/6J35JOsxvScUMGkYptAt1VofPem3qwA0=";
        }
      ];

      userSettings = lib.mkForce {
        "workbench.colorTheme" = "Stylix";
        "workbench.iconTheme" = "file-icons";
        "security.workspace.trust.untrustedFiles" = "open";
        "vsicons.dontShowNewVersionMessage" = true;
        "workbench.editor.empty.hint" = "hidden";
        "explorer.confirmDelete" = false;
        "redhat.telemetry.enabled" = false;
        "dreammaker.autoUpdate" = true;
        "git.autofetch" = true;
        "dreammaker.tickOnCreate" = true;
        "git.confirmSync" = false;
        "debug.onTaskErrors" = "abort";
        "git.enableSmartCommit" = true;
        "editor.minimap.enabled" = false;
        "window.customTitleBarVisibility" = "windowed";
        "gitlens.hovers.currentLine.over" = "line";
        "gitlens.codeLens.enabled" = false;
        "gitlens.hovers.enabled" = false;
        "gitlens.advanced.messages" = {
          "suppressLineUncommittedWarning" = true;
        };
        "githubPullRequests.pullBranch" = "never";
        "vscord.status.state.text.editing" = "Working on {file_name}{file_extension}";
        "vscord.app.name" = "Visual Studio Code";
        "gitlens.currentLine.enabled" = false;
        "gitlens.advanced.blame.delayAfterEdit" = 1000;
        "[json]" = {
          "editor.defaultFormatter" = "biomejs.biome";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "biomejs.biome";
        };
        "editor.formatOnPaste" = true;
        "editor.fontLigatures" = true;
        "editor.fontFamily" = "Consolas, 'Courier New', Menlo, Monaco, Fira Code, monospace";
        "github.copilot.advanced" = {};
        "gitlens.statusBar.dateFormat" = "";
        "gitlens.remotes" = [
          {
            "domain" = "github.com";
            "type" = "GitHub";
            "protocol" = "https";
            "name" = "GitHub";
            "urls" = {
              "repository" = "https://github.com/tgstation/{repo}";
              "branches" = "https://github.com/tgstation/{repo}/branches";
              "branch" = "https://github.com/tgstation/{repo}/tree/{branch}";
              "commit" = "https://github.com/tgstation/{repo}/commit/{id}";
              "file" = "https://github.com/tgstation/{repo}/blob/{branch}/{file}";
              "fileInBranch" = "https://github.com/tgstation/{repo}/blob/{branch}/{file}";
              "fileInCommit" = "https://github.com/tgstation/{repo}/blob/{sha}/{file}";
              "fileLine" = "https://github.com/tgstation/{repo}/blob/{branch}/{file}#L{line}";
              "fileRange" = "https://github.com/tgstation/{repo}/blob/{branch}/{file}#L{start}-L{end}";
            };
          }
        ];
        "terminal.integrated.fontLigatures" = true;
      };

      keybindings = [
        {
          "key" = "alt+f";
          "command" = "search.action.openNewEditor";
        }
        {
          "key" = "ctrl+tab ]";
          "command" = "workbench.action.quickOpenNavigateNextInEditorPicker";
          "when" = "inEditorsPicker && inQuickOpen";
        }
        {
          "key" = "ctrl+tab";
          "command" = "-workbench.action.quickOpenNavigateNextInEditorPicker";
          "when" = "inEditorsPicker && inQuickOpen";
        }
        {
          "key" = "ctrl+tab ]";
          "command" = "workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup";
          "when" = "!activeEditorGroupEmpty";
        }
        {
          "key" = "ctrl+tab";
          "command" = "-workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup";
          "when" = "!activeEditorGroupEmpty";
        }
        {
          "key" = "ctrl+tab";
          "command" = "editor.action.indentLines";
          "when" = "editorTextFocus && !editorReadonly";
        }
        {
          "key" = "ctrl+]";
          "command" = "-editor.action.indentLines";
          "when" = "editorTextFocus && !editorReadonly";
        }
        {
          "key" = "ctrl+alt+d";
          "command" = "workbench.view.debug";
          "when" = "viewContainer.workbench.view.debug.enabled";
        }
        {
          "key" = "ctrl+shift+d";
          "command" = "-workbench.view.debug";
          "when" = "viewContainer.workbench.view.debug.enabled";
        }
        {
          "key" = "ctrl+shift+d";
          "command" = "workbench.action.closeAuxiliaryBar";
        }
      ];
    };
  };
}
