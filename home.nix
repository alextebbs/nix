{ pkgs, lib, username, homeDirectory, ... }: {
  imports = [ ./nvim.nix ];

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  # Remove pre-existing dotfiles that home-manager wants to manage,
  # so activation doesn't fail with "would be clobbered".
  home.activation.removeConflicting = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    for f in .zshrc .zshenv .bashrc .bash_profile .profile; do
      [ -f "${homeDirectory}/$f" ] && [ ! -L "${homeDirectory}/$f" ] && rm -f "${homeDirectory}/$f"
    done
  '';

  # On Linux containers where bash is the login shell, exec into zsh.
  programs.bash = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    initExtra = ''
      if [[ -x "$HOME/.nix-profile/bin/zsh" && -z "$_HM_ZSH_EXEC" ]]; then
        export _HM_ZSH_EXEC=1
        exec "$HOME/.nix-profile/bin/zsh" -l
      fi
    '';
  };

  home.packages = with pkgs; [
    claude-code
    codex
  ];

  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.eza.enable = true;
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.btop.enable = true;

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Unbind default prefix and set it to Ctrl+a cause easier
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      # tmux display things in 256 colors
      set -g default-terminal "screen-256color"
      set -g history-limit 20000

      # Automatically renumber tmux windows
      set -g renumber-windows on

      # For nested tmux sessions
      bind-key a send-prefix

      # Activity Monitoring
      setw -g monitor-activity off
      set -g visual-activity off

      # Rather than constraining window size to the maximum size of any client
      # connected to the *session*, constrain window size to the maximum size of any
      # client connected to *that window*. Much more reasonable.
      setw -g aggressive-resize on

      # make delay shorter
      set -sg escape-time 0

      # tile all windows
      unbind =
      bind = select-layout tiled

      # make window/pane index start with 1
      set -g base-index 1
      setw -g pane-base-index 1

      # Don't rename my windows
      set-option -g allow-rename off

      # 12-hour clock mode
      set-window-option -g clock-mode-style 12

      ##############################
      # => KEY BINDINGS
      ##############################

      # reload config file
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config Reloaded!"

      # quickly open a new window
      bind N new-window -c "#{pane_current_path}"

      # set default path for new windows
      bind c new-window -c "~/Projects/c1/"

      # split window and fix path for tmux 1.9
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # synchronize all panes in a window
      bind y setw synchronize-panes

      # toggle status bar
      bind b set-option -g status

      # pane movement shortcuts
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind -r C-[ select-window -t :-
      bind -r C-] select-window -t :+

      # enable mouse support for switching panes/windows
      # NOTE: This breaks selecting/copying text on OSX
      # To select text as expected, hold Option to disable it (iTerm2)
      set -g mouse on

      set -g status-bg '#000000'
      set -g status-fg '#444444'

      set -g pane-border-style fg=#222222
      set -g pane-active-border-style fg=#222222
      set-window-option -g window-status-current-style fg=colour117
      set -g window-status-format " #W "
      set -g window-status-current-format " #W "
      set -g status-left ""

      # fix ssh agent when tmux is detached
      setenv -g SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock

      # ===== vim-tmux-navigator: seamless ctrl-hjkl across nvim/tmux panes =====
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      bind-key -n 'C-\' if-shell "$is_vim" 'send-keys C-\\'  'select-pane -l'
      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "alextebbs";
        email = "alex@alextebbs.com";
      };
    } // pkgs.lib.optionalAttrs pkgs.stdenv.isDarwin {
      "url \"git@github.com:\"" = {
        insteadOf = "https://github.com/";
      };
    };
  };

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "";
      plugins = [ "git" "gulp" "vi-mode" "colorize" "web-search" "z" ]
      ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ "macos" ];
    };

    shellAliases = {
      p = "cd ~/Projects";
      ls = "ls -laG";
      vim = "nvim";
      tmux = "tmux attach || tmux new";
    };

    sessionVariables = {
      CLICOLOR = "1";
      TERM = "xterm-256color";
      NVM_DIR = "$HOME/.nvm";
    };

    initExtra = ''
      # start typing + [Up-Arrow] - fuzzy find history forward
      if [[ "''${terminfo[kcuu1]}" != "" ]]; then
        autoload -U up-line-or-beginning-search
        zle -N up-line-or-beginning-search
        bindkey "''${terminfo[kcuu1]}" up-line-or-beginning-search
      fi
      # start typing + [Down-Arrow] - fuzzy find history backward
      if [[ "''${terminfo[kcud1]}" != "" ]]; then
        autoload -U down-line-or-beginning-search
        zle -N down-line-or-beginning-search
        bindkey "''${terminfo[kcud1]}" down-line-or-beginning-search
      fi
    '' + pkgs.lib.optionalString pkgs.stdenv.isDarwin ''
      # NVM (from Homebrew)
      [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
      [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];
}
