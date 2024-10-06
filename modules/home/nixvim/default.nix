_: {
  programs.nixvim = {

    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    enableMan = false;


    opts = {
      number = true;         # Show line numbers
      shiftwidth = 2;        # Tab width should be 2
      clipboard = "unnamedplus";    #yank to clipboard
      termguicolors = true;
    };

    plugins = {
      nvim-colorizer.enable = true;
      harpoon.enable = true;
      nix.enable = true;
      # pretty ui
      noice.enable = true;
      # rainbow brackets
      rainbow-delimiters.enable = true;
      treesitter.enable = true;

      lualine = {
        enable = true;
        settings.options.icons_enabled = true;
      };

      alpha = {
        enable = true;
        #theme = null;
        layout = [
          {
	    opts = {
	      position = "center";
	      hl = "Type";
	    };
	    type = "text";
            val = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
	      " ███▄    █  ██▓▒██   ██▒ ██▒   █▓ ██▓ ███▄ ▄███▓"
	      " ██ ▀█   █ ▓██▒▒▒ █ █ ▒░▓██░   █▒▓██▒▓██▒▀█▀ ██▒"
	      "▓██  ▀█ ██▒▒██▒░░  █   ░ ▓██  █▒░▒██▒▓██    ▓██░"
	      "▓██▒  ▐▌██▒░██░ ░ █ █ ▒   ▒██ █░░░██░▒██    ▒██ "
	      "▒██░   ▓██░░██░▒██▒ ▒██▒   ▒▀█░  ░██░▒██▒   ░██▒"
	      "░ ▒░   ▒ ▒ ░▓  ▒▒ ░ ░▓ ░   ░ ▐░  ░▓  ░ ▒░   ░  ░"
	      "░ ░░   ░ ▒░ ▒ ░░░   ░▒ ░   ░ ░░   ▒ ░░  ░      ░"
	      "   ░   ░ ░  ▒ ░ ░    ░       ░░   ▒ ░░      ░   "
	      "         ░  ░   ░    ░        ░   ░         ░   "
	      "                             ░                  "
            ];
          }
        ];
      };
    };

    #extraPlugins = with pkgs.vimPlugins; [
    #  nvim-treesitter
    #  nvim-treesitter-parsers.yuck
    #  nvim-treesitter-parsers.scss
    #  nvim-treesitter-parsers.rust
    #  nvim-treesitter-parsers.c
    #  nvim-treesitter-parsers.haskell
    #  nvim-treesitter-parsers.css
    #  nvim-treesitter-parsers.lua
    #  nvim-treesitter-parsers.python
    #  nvim-treesitter-parsers.fish
    #  nvim-treesitter-parsers.bash
    #  nvim-treesitter-parsers.commonlisp
    #  nvim-treesitter-parsers.nix
    #  nvim-treesitter-parsers.hyprlang
    #];

    #extraConfigLua = ''
    #  local fn = vim.fn
    #  local cmd = vim.cmd
    #  require'nvim-treesitter.configs'.setup {	
    #    highlight = {
    #      enable = true,

    #      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    #      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    #      -- Using this option may slow down your editor, and you may see some duplicate highlights.
    #      -- Instead of true it can also be a list of languages
    #      additional_vim_regex_highlighting = false,
    #    },
    #  }
    #'';

  };
}
