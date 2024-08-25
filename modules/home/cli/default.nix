{
  lib,
  pkgs,
  ...
}: {
  home = {
    homeDirectory = "/home/pras";
    stateVersion = "24.05";
    username = "pras";

  #   file."./.config/nap/config.yaml" = {
  #     source = ./nap/config.yaml;
  #   };
  #
  #   file."./.gitconfig" = {
  #     recursive = true;
  #     source = ./git/gitconfig;
  #   };
  #
  #   packages = with pkgs; [
  #     acme-sh
  #     argocd
  #     asciinema
  #     awscli
  #     azure-cli
  #     bashInteractive
  #     bottom
  #     buildpack
  #     bun
  #     # checkov
  #     cilium-cli
  #     conftest
  #     cowsay
  #     crystal
  #     cue
  #     dasel
  #     diffoscopeMinimal
  #     difftastic
  #     dive
  #     doctl
  #     driftctl
  #     duckdb
  #     fd
  #     flyctl
  #     fx
  #     gh
  #     go-task
  #     (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
  #     gomplate
  #     goreleaser
  #     gorilla-cli
  #     grpcurl
  #     helmfile
  #     hurl
  #     infracost
  #     istioctl
  #     ## jc
  #     ## jless
  #     ## jq
  #     ## jqp
  #     ## julia
  #     ## just
  #     ## k3d
  #     ## k6
  #     ## kind
  #     ## kpt
  #     ## krew
  #     ## kube-hunter
  #     ## kubectl
  #     ## kubectx
  #     ## kubelogin
  #     ## kubent
  #     ## kubernetes-helm
  #     ## kubernetes-helmPlugins.helm-diff
  #     # kustomize
  #     # litestream
  #     # minikube
  #     # mkcert
  #     # nomad
  #     # oci-cli
  #     # open-policy-agent
  #     ## osquery
  #     ## packer
  #     # pluto
  #     # powerline
  #     ## pre-commit
  #     ## ranger
  #     ## rclone
  #     # redis
  #     ## rustc
  #     # skaffold
  #     # sl
  #     # sqlite
  #     # ssh-audit
  #     ## steampipe
  #     ## stern
  #     # terraform
  #     ## terraform-docs
  #     # terragrunt
  #     ## tflint
  #     # tfsec
  #     # tfupdate
  #     # tilt
  #     # trivy
  #     # vault
  #     # yamlfix
  #     ## yamllint
  #     # yq-go
  #     # ytt
  #     # zellij
  #     # zig
  #   ];
  # };
  #
  # imports = lib.snowfall.fs.get-non-default-nix-files ./.;
  #
  # programs = {
  #   home-manager.enable = true;
  #
  #   # Custom packages
  #
  #   bat.enable = true;
  #   broot.enable = true;
  #   go.enable = true;
  #   # jq.enable = true;
  #   k9s.enable = true;
  #   lazygit.enable = true;
  #   lf.enable = true;
  #   ripgrep.enable = true;
  #
  #   atuin = {
  #     enable = true;
  #     enableBashIntegration = true;
  #     enableZshIntegration = true;
  #   };
  #
  #   bash = {
  #     enable = true;
  #     initExtra = builtins.readFile ./bash/bashrc;
  #     profileExtra = builtins.readFile ./bash/profile;
  #   };
  #
  #   direnv = {
  #     enable = true;
  #     enableBashIntegration = true;
  #     enableZshIntegration = true;
  #     nix-direnv.enable = true;
  #   };
  #
  #   fzf = {
  #     enable = true;
  #     defaultCommand = "rg --files --no-ignore --hidden --follow --glob \\\"!.git/*\\\"";
  #     defaultOptions = [
  #       "--height 50% -1 --layout=reverse-list --multi"
  #       "--preview=\\\"[[ \\\$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300\\\""
  #     ];
  #   };
  #
  #   git = {
  #     enable = true;
  #     includes = [{path = "~/.config/home-manager/gitconfig";}];
  #   };
  #
  #   # nixvim = {
  #   #   enable = true;
  #   #   vimAlias = true;
  #   #   # colorschemes.gruvbox.enable = true;
  #   #   # plugins = {
  #   #   # telescope.enable = true;
  #   #   # which-key.enable = true;
  #   #   # };
  #   # };
  #
  #   thefuck = {
  #     enable = true;
  #     enableZshIntegration = true;
  #   };
  #
  #   tmux = {
  #     enable = true;
  #     escapeTime = 10;
  #     extraConfig = builtins.readFile ./tmux/tmux.conf;
  #     historyLimit = 10000;
  #     keyMode = "vi";
  #     plugins = with pkgs; [
  #       {
  #         plugin = tmuxPlugins.continuum;
  #         extraConfig = "set -g @continuum-boot 'on'";
  #       }
  #       {
  #         plugin = tmuxPlugins.resurrect;
  #         extraConfig = "set -g @resurrect-strategy-nvim 'session'";
  #       }
  #       tmuxPlugins.sensible
  #     ];
  #     sensibleOnTop = true;
  #     terminal = "screen-256color";
  #     tmuxp.enable = true;
  #   };
  #
  #   zoxide = {
  #     enable = true;
  #     enableBashIntegration = true;
  #     enableZshIntegration = true;
  #     options = [
  #       "--cmd cd"
  #     ];
  #   };
  #
  #   zsh = {
  #     enable = true;
  #     envExtra = builtins.readFile ./zsh/zshenv;
  #     initExtra = builtins.readFile ./zsh/zshrc;
  #     initExtraBeforeCompInit = ''
  #       [[ ! -f ${./powerlevel10k/p10k.zsh} ]] || source ${./powerlevel10k/p10k.zsh}
  #     '';
  #     profileExtra = builtins.readFile ./zsh/zprofile;
  #     plugins = with pkgs; [
  #       {
  #         name = "powerlevel10k";
  #         src = zsh-powerlevel10k;
  #         file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  #       }
  #     ];
  #     # autosuggestion.enable = true;
  #     # syntaxHighlighting.enable = true;
  #   };
  };
}
