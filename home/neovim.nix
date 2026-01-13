{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    package = pkgs.neovim-unwrapped;
  };

  # Environment variables for Neovim LSP
  home.sessionVariables = {
    LOMBOK_JAR = "${pkgs.lombok}/share/java/lombok.jar";
  };

  # Add language servers to environment
  home.packages = with pkgs; [
    # Lua
    lua-language-server
    luarocks
    lua5_1

    # Nix
    nixd

    # TypeScript/JavaScript
    typescript-language-server

    # Ruby
    ruby-lsp

    # Java
    lombok
    jdt-language-server

    # Markdown
    marksman

    # Go
    go

    # C# / .NET
    netcoredbg
    csharpier

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
  ];
}
