{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "workspace-deps";
      paths = [
        zsh
        neovim
        go
        nodejs_22
        ripgrep
        fzf
      ];
    };
  };
}
