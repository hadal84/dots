return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      vim.opt.termguicolors = true

      require('kanagawa').setup {
        theme = 'wave',
        transparent = false,
        terminal_colors = true,
        overrides = function(colors)
          return {
            -- Main editor background
            Normal = { bg = '#000000', fg = colors.fg },

            -- Floating windows, pop‑ups, Telescope, etc.
            NormalFloat = { bg = '#000000' },
            FloatBorder = { bg = '#000000' },

            -- Sidebars (NvimTree, NeoTree, etc.)
            SignColumn = { bg = '#000000' },
            VertSplit = { bg = '#000000' },

            -- Status line / winbar (if you use one)
            StatusLine = { bg = '#000000' },
            StatusLineNC = { bg = '#000000' },

            -- Slightly visible cursor line – useful on AMOLED screens
            CursorLine = { bg = '#0a0a0a' },

            -- Optional: make the popup‑menu black as well
            Pmenu = { bg = '#000000', fg = colors.fg },
            PmenuSel = { bg = '#1a1a1a', fg = colors.fg },
          }
        end,
      }

      vim.cmd 'colorscheme kanagawa'
    end,
  },
}
