return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {},
      -- nixd instead of the nix extra's nil, because it understands NixOS
      -- options: K shows their docs and gd jumps into nixpkgs.
      -- Installed via nix rather than Mason.
      nil_ls = { enabled = false },
      nixd = {
        mason = false,
        settings = {
          nixd = {
            options = {
              nixos = {
                -- First nixosConfiguration of the flake in the directory nvim
                -- was opened in. "path:" reads it as it is on disk, so
                -- untracked files (e.g. private.nix) are included.
                expr = 'let flake = builtins.getFlake ("path:" + toString ./.); in (builtins.head (builtins.attrValues flake.nixosConfigurations)).options',
              },
            },
          },
        },
      },
    },
  },
}
