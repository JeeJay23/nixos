{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jader";
  home.homeDirectory = "/home/jader";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [

    thunderbird
    gh
    heroic

    # disabled packaged
    # hyprnome
    # microsoft-edge

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jader/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };

  # programs and configs
  programs.git = {
    enable = true;
    userName = "Jader";
    userEmail = "jvjader@gmail.com";
    aliases = {
      pu = "push";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };

  programs.kitty = {
    enable = true;
    environment = {
        "EDITOR" = "vim";
    };
    settings = {
        include = "current-theme.conf";
        window_padding_width = 10;
        draw_minimal_borders = "yes";
        tab_bar_style = "separator";
        focus_follows_mouse = "yes";
    };
    theme = "Gruvbox Dark Hard";
    font.name = "JetBrains Mono";
    font.package = pkgs.jetbrains-mono;
  };

    # also set in conf.nix, settings here don't work yet
    programs.fish = {
        enable = true;
        shellAbbrs = {
            g = "git";
        };
    };

    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            vscodevim.vim
            ms-python.python
            ms-python.vscode-pylance
            ms-python.debugpy
            ms-vscode.cpptools-extension-pack
            jdinhlife.gruvbox
            ms-vscode-remote.remote-ssh
            # GitHub.copilot
        ];
        userSettings = {
            "workbench.activityBar.location" = "top";
            "workbench.colorTheme" = "Gruvbox Dark Medium";
            "vim.easymotion" = true;
            "vim.leader" = " ";
            "editor.fontFamily" =  "'JetBrains Mono', 'Droid Sans Mono', 'monospace', monospace";
            "editor.fontLigatures" =  true;
        };
    };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
