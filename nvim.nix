{ pkgs, ... }:
let
  claudecode-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "claudecode.nvim";
    version = "unstable-2026-04-15";
    src = pkgs.fetchFromGitHub {
      owner = "coder";
      repo = "claudecode.nvim";
      rev = "main";
      hash = "sha256-h8wYaWBKjKrb7hYYKYs5yUS5RI0JVFo8Emcy99YK6Qw=";
    };
  };
in
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      autoindent = true;
      clipboard = "unnamedplus";
      hlsearch = false;
      incsearch = true;
      ignorecase = true;
      smartcase = true;
      wrap = true;
      linebreak = true;
      colorcolumn = "80,120";
      scrolloff = 8;
      sidescrolloff = 8;
      signcolumn = "yes";
      termguicolors = true;
      mouse = "a";
      cursorline = true;
      cursorlineopt = "line"; # highlight full text row, leave line number alone
      splitright = true;
      splitbelow = true;
      updatetime = 250;
      timeoutlen = 400;
      undofile = true;
      swapfile = false;
      backup = false;
      completeopt = [ "menu" "menuone" "noselect" ];
      showmode = false;
      pumheight = 12;
    };

    autoCmd = [
      {
        event = [ "FileType" ];
        pattern = [ "python" "typescript" "typescriptreact" "c" ];
        command = "setlocal tabstop=4 softtabstop=4 shiftwidth=4";
      }
      {
        event = [ "TextYankPost" ];
        pattern = [ "*" ];
        callback.__raw = "function() vim.highlight.on_yank({ timeout = 150 }) end";
      }
    ];

    keymaps = [
      # ===== clear search highlights =====
      { mode = "n"; key = "<C-n>"; action = "<cmd>nohlsearch<CR>"; options.silent = true; }

      # ===== leader bindings =====
      { mode = "n"; key = "<leader>w"; action = "<cmd>w<CR>"; options.desc = "Save file"; }
      { mode = "n"; key = "<leader>n"; action = "<cmd>Neotree toggle<CR>"; options.desc = "Toggle file tree"; }
      { mode = "n"; key = "<leader>b"; action = "<C-w>="; options.desc = "Balance splits"; }

      # ===== window navigation (Ctrl-hjkl — handled by vim-tmux-navigator below, crosses into tmux panes) =====

      # ===== indent stays in normal mode =====
      { mode = "n"; key = ">"; action = ">>"; }
      { mode = "n"; key = "<"; action = "<<"; }
      { mode = "v"; key = ">"; action = ">gv"; }
      { mode = "v"; key = "<"; action = "<gv"; }

      # ===== move by display lines (word wrap) =====
      { mode = [ "n" "v" ]; key = "j"; action = "gj"; }
      { mode = [ "n" "v" ]; key = "k"; action = "gk"; }

      # ===== black-hole register for destructive ops (preserves yank) =====
      { mode = "n"; key = "x"; action = "\"_x"; }
      { mode = "n"; key = "d"; action = "\"_d"; }
      { mode = "n"; key = "D"; action = "\"_D"; }
      { mode = "n"; key = "dd"; action = "\"_dd"; }
      { mode = "n"; key = "c"; action = "\"_c"; }
      { mode = "n"; key = "C"; action = "\"_C"; }
      { mode = "n"; key = "cc"; action = "\"_cc"; }
      # mm → actual yank+delete (non-recursive so it uses built-in dd)
      { mode = "n"; key = "mm"; action = "dd"; }

      # visual mode
      { mode = "v"; key = "x"; action = "\"_d"; }
      { mode = "v"; key = "d"; action = "\"_d"; }
      { mode = "v"; key = "c"; action = "\"_c"; }
      # m → actual yank+delete in visual
      { mode = "v"; key = "m"; action = "d"; }

      # ===== move lines (alt-j/k, matches VSCode) =====
      { mode = "n"; key = "<M-j>"; action = "<cmd>m .+1<CR>=="; }
      { mode = "n"; key = "<M-k>"; action = "<cmd>m .-2<CR>=="; }
      { mode = "v"; key = "<M-j>"; action = ":m '>+1<CR>gv=gv"; }
      { mode = "v"; key = "<M-k>"; action = ":m '<-2<CR>gv=gv"; }
      # copy lines (shift-alt-j/k)
      { mode = "n"; key = "<S-M-j>"; action = "<cmd>t .<CR>"; }
      { mode = "n"; key = "<S-M-k>"; action = "<cmd>t .-1<CR>"; }
      { mode = "v"; key = "<S-M-j>"; action = ":t '><CR>"; }
      { mode = "v"; key = "<S-M-k>"; action = ":t '<-1<CR>"; }

      # ========================================================
      # ===== SEARCH — VSCode bindings + leader fallbacks  =====
      # ========================================================

      # cmd+o → find files by name (VSCode's quick open)
      { mode = "n"; key = "<D-o>"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Find file"; }
      # cmd+shift+f → live grep (global content search)
      { mode = "n"; key = "<D-F>"; action = "<cmd>Telescope live_grep<CR>"; options.desc = "Search in files"; }
      # cmd+f → fuzzy find in current buffer
      { mode = "n"; key = "<D-f>"; action = "<cmd>Telescope current_buffer_fuzzy_find<CR>"; options.desc = "Search in file"; }
      # cmd+p → buffer picker (VSCode's ctrl+tab)
      { mode = "n"; key = "<D-p>"; action = "<cmd>Telescope buffers<CR>"; options.desc = "Buffers"; }

      # Leader fallbacks (work in any terminal without cmd-key forwarding)
      { mode = "n"; key = "<leader>f"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Find file"; }
      { mode = "n"; key = "<leader>g"; action = "<cmd>Telescope live_grep<CR>"; options.desc = "Live grep"; }
      { mode = "n"; key = "<leader>/"; action = "<cmd>Telescope current_buffer_fuzzy_find<CR>"; options.desc = "Search in buffer"; }
      { mode = "n"; key = "<leader>p"; action = "<cmd>Telescope buffers<CR>"; options.desc = "Buffers"; }
      { mode = "n"; key = "<leader>sh"; action = "<cmd>Telescope help_tags<CR>"; options.desc = "Help"; }
      { mode = "n"; key = "<leader>sr"; action = "<cmd>Telescope resume<CR>"; options.desc = "Resume last picker"; }
      { mode = "n"; key = "<leader>ss"; action = "<cmd>Telescope lsp_document_symbols<CR>"; options.desc = "Document symbols"; }
      { mode = "n"; key = "<leader>sS"; action = "<cmd>Telescope lsp_workspace_symbols<CR>"; options.desc = "Workspace symbols"; }
      { mode = "n"; key = "<leader>sd"; action = "<cmd>Telescope diagnostics<CR>"; options.desc = "Diagnostics"; }

      # ===== LSP =====
      { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; options.desc = "Hover"; }
      { mode = "n"; key = "gd"; action = "<cmd>Telescope lsp_definitions<CR>"; options.desc = "Definition"; }
      { mode = "n"; key = "gi"; action = "<cmd>Telescope lsp_implementations<CR>"; options.desc = "Implementation"; }
      { mode = "n"; key = "gr"; action = "<cmd>Telescope lsp_references<CR>"; options.desc = "References"; }
      { mode = "n"; key = "gt"; action = "<cmd>Telescope lsp_type_definitions<CR>"; options.desc = "Type definition"; }
      { mode = "n"; key = "<leader>rn"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; options.desc = "Rename symbol"; }
      { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; options.desc = "Code action"; }
      { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<CR>"; options.desc = "Prev diagnostic"; }
      { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<CR>"; options.desc = "Next diagnostic"; }
      { mode = "n"; key = "<leader>e"; action = "<cmd>lua vim.diagnostic.open_float()<CR>"; options.desc = "Show diagnostic"; }

      # ===== Harpoon (bookmarks — matches VSCode cmd+8) =====
      { mode = "n"; key = "<leader>8"; action = "<cmd>lua require('harpoon'):list():add()<CR>"; options.desc = "Add to harpoon"; }
      { mode = "n"; key = "<leader>H"; action = "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>"; options.desc = "Harpoon menu"; }

      # ===== Git =====
      { mode = "n"; key = "<leader>gg"; action = "<cmd>LazyGit<CR>"; options.desc = "LazyGit"; }
      { mode = "n"; key = "<leader>gb"; action = "<cmd>Gitsigns blame_line<CR>"; options.desc = "Git blame line"; }

      # ===== Terminal =====
      { mode = "n"; key = "<leader>t"; action = "<cmd>ToggleTerm direction=float<CR>"; options.desc = "Float terminal"; }
      { mode = "t"; key = "<Esc>"; action = "<C-\\><C-n>"; options.desc = "Terminal normal mode"; }

      # ===== Theme toggle (Brodiac dark <-> Brodiac light) =====
      { mode = "n"; key = "<leader>th"; action = "<cmd>lua vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'; vim.cmd.colorscheme('brodiac')<CR>"; options.desc = "Toggle theme"; }

      # ===== Claude Code =====
      { mode = "n"; key = "<leader>cc"; action = "<cmd>ClaudeCode<CR>"; options.desc = "Toggle Claude Code"; }
      { mode = "n"; key = "<leader>cf"; action = "<cmd>ClaudeCodeFocus<CR>"; options.desc = "Focus Claude Code"; }
      { mode = "v"; key = "<leader>cs"; action = "<cmd>ClaudeCodeSend<CR>"; options.desc = "Send selection to Claude"; }
    ];

    colorschemes = { };

    plugins = {
      # ===== UI =====
      lualine = {
        enable = true;
        settings.options = {
          theme = "auto";
          component_separators = { left = ""; right = ""; };
          section_separators = { left = ""; right = ""; };
          globalstatus = true;
        };
      };
      web-devicons.enable = false;

      # ===== File explorer (icons off) =====
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        filesystem = {
          followCurrentFile.enabled = true;
          useLibuvFileWatcher = true;
        };
        settings.default_component_configs = {
          icon = {
            folder_closed = "+";
            folder_open = "-";
            folder_empty = "+";
            default = " ";
          };
          modified = {
            symbol = "*";
          };
          git_status.symbols = {
            added = "+";
            modified = "~";
            deleted = "-";
            renamed = ">";
            untracked = "?";
            ignored = "i";
            unstaged = " ";
            staged = "=";
            conflict = "!";
          };
          name = {
            trailing_slash = false;
            use_git_status_colors = true;
          };
        };
        settings.window.mappings = {
          "<space>" = "none"; # free up leader
          "o" = "open";
          "<cr>" = "open";
          "u" = "navigate_up";
        };
      };

      # ===== Fuzzy finder =====
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };
        settings.defaults = {
          layout_strategy = "horizontal";
          sorting_strategy = "ascending";
          layout_config.prompt_position = "top";
          path_display = [ "truncate" ];
          disable_devicons = true;
          selection_caret = "> ";
          prompt_prefix = "> ";
          entry_prefix = "  ";
          multi_icon = "*";
          borderchars = [ "-" "|" "-" "|" "+" "+" "+" "+" ];
          file_ignore_patterns = [
            "node_modules/"
            "%.git/"
            "dist/"
            "%.firebase/"
            "public/"
            "package-lock.json"
            "_test%.go$"
            "mock_.*%.go$"
            "frontend/pbts/"
          ];
        };
      };

      # ===== Syntax =====
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          ensure_installed = [
            "bash"
            "c"
            "css"
            "go"
            "gomod"
            "gosum"
            "html"
            "javascript"
            "json"
            "lua"
            "markdown"
            "markdown_inline"
            "mermaid"
            "python"
            "regex"
            "rust"
            "scss"
            "sql"
            "tsx"
            "typescript"
            "vim"
            "vimdoc"
            "yaml"
            "prisma"
            "dockerfile"
            "nix"
          ];
        };
      };
      treesitter-context.enable = false;

      # ===== Git =====
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = false; # no inline blame — use <leader>gb on demand
          signs = {
            add.text = "+";
            change.text = "~";
            delete.text = "-";
            topdelete.text = "-";
            changedelete.text = "~";
            untracked.text = "?";
          };
        };
      };
      lazygit.enable = true;

      # ===== LSP =====
      lsp = {
        enable = true;
        servers = {
          gopls.enable = true;
          ts_ls.enable = true;
          biome.enable = true;
          eslint.enable = true;
          tailwindcss.enable = true;
          pyright.enable = true;
          lua_ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          nixd.enable = true;
        };
      };

      # ===== Completion =====
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
          };
        };
      };

      # ===== Formatter =====
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
          formatters_by_ft = {
            typescript = [ "biome" ];
            typescriptreact = [ "biome" ];
            javascript = [ "biome" ];
            javascriptreact = [ "biome" ];
            json = [ "biome" ];
            python = [ "black" ];
            go = [ "gofumpt" "goimports" ];
            lua = [ "stylua" ];
            nix = [ "nixpkgs_fmt" ];
          };
        };
      };

      # ===== Linter =====
      lint = {
        enable = true;
        lintersByFt = {
          typescript = [ "eslint" ];
          typescriptreact = [ "eslint" ];
          javascript = [ "eslint" ];
          javascriptreact = [ "eslint" ];
        };
      };

      # ===== Editing helpers =====
      nvim-surround.enable = true;
      comment.enable = true;

      # ===== Navigation =====
      harpoon = {
        enable = true;
        enableTelescope = true;
      };

      # ===== Terminal =====
      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
          open_mapping = "[[<c-\\>]]";
          float_opts.border = "single";
        };
      };

      # ===== Which-key =====
      which-key = {
        enable = true;
        settings = {
          icons = {
            mappings = false;
            separator = "->";
            group = "+";
          };
          preset = "classic";
        };
      };
    };

    extraPlugins = [
      # plenary is a dep of telescope + claudecode; nixvim pulls it but safe to list
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.vim-tmux-navigator
      claudecode-nvim
    ];

    extraConfigLua = ''
      -- Brodiac colorscheme
      vim.cmd.colorscheme("brodiac")

      -- claudecode.nvim
      require("claudecode").setup({})

      -- Diagnostics: NO inline rendering. Signs in gutter + underline only.
      -- Hover a diagnostic with `<leader>e` or `K` to read the message.
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN]  = "W",
            [vim.diagnostic.severity.INFO]  = "I",
            [vim.diagnostic.severity.HINT]  = "H",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "single", source = true },
      })

      -- Disable LSP inlay hints globally (no inline type annotations).
      vim.lsp.inlay_hint.enable(false)

      -- Disable LSP semantic token highlights that may paint backgrounds.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })
    '';

    extraFiles = {
      "colors/brodiac.lua".source = ./colors/brodiac.lua;
    };

    # Binaries nvim needs in PATH (LSPs, formatters, linters)
    extraPackages = with pkgs; [
      # LSPs
      gopls
      typescript-language-server
      biome
      vscode-langservers-extracted # eslint, html, css, json
      tailwindcss-language-server
      pyright
      lua-language-server
      nixd

      # Formatters
      black
      gofumpt
      stylua
      nixpkgs-fmt
      prettier

      # Linters
      (pkgs.writeShellScriptBin "eslint" ''
        exec ${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server "$@"
      '')

      # Go tools
      gopls
      delve
      gotools
    ];
  };
}
