{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  home.packages = with pkgs; [
    # Lua
    lua-language-server
    luarocks
    lua5_1

    # Nix
    nixd

    marksman

    # TypeScript/JavaScript
    typescript-language-server

    # Ruby
    # ruby-lsp

    # Java
    lombok
    jdt-language-server
    #
    # # Go
    # go
    #
    # # C# / .NET
    # netcoredbg
    # csharpier
    #
    # Additional useful servers
    rust-analyzer
    pyright
    gopls
    bash-language-server

    # Development tools
    tree-sitter

    # Formatters
    stylua
    nixfmt
    black
    isort
    prettier
    rustfmt
    google-java-format
    shfmt
    taplo
  ];
}
