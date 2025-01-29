{config, pkgs, inputs, ...}: {
  imports = [ inputs.nixvim.nixosModules.nixvim ];

  programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      enableMan = false;
      package = pkgs.neovim-unwrapped;
      #package = pkgs.neovim-unwrapped;

      opts = {
        number = true;
        shiftwidth = 2;
        clipboard = "unnamedplus";
        termguicolors = true;
      };

      plugins = {
        colorizer.enable = true;
        harpoon.enable = true;
        nix.enable = true;
        # pretty ui
        noice.enable = true;
        # rainbow brackets
        rainbow-delimiters.enable = true;
        treesitter.enable = true;

        lualine = {
          enable = true;
          #settings.options.icons_enabled = true;
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

      extraConfigLua = ''
        --automatic theming
        local theme_script_path = vim.fn.expand("~/.local/share/tinted-theming/tinty/base16-vim-colors-file.vim")

        local function file_exists(file_path)
          return vim.fn.filereadable(file_path) == 1 and true or false
        end

        local function handle_interrupt()
          if file_exists(theme_script_path) then
            vim.cmd("source " .. theme_script_path)
            vim.cmd("echo 'theme changed'")
            vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
            vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
            vim.cmd("highlight LineNr guibg=NONE")
          end
        end
      
        if file_exists(theme_script_path) then
          vim.o.termguicolors = true
          vim.g.tinted_colorspace = 256

          vim.cmd("source " .. theme_script_path)

          vim.api.nvim_create_autocmd({"Signal"}, {
            pattern = {"SIGUSR1"},
            callback = handle_interrupt,
          })
        end
        --set background transparent
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
        vim.cmd("highlight LineNr guibg=NONE")
      '';
    };
  };
}
