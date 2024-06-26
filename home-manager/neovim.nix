{ pkgs, neovim-helloworld, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins;
      let
        helloworld = pkgs.vimUtils.buildVimPlugin {
          name = "neovim-helloworld";
          src = neovim-helloworld;
        };
      in [
          copilot-vim
          helloworld
          bclose-vim
          coc-eslint
          coc-nvim
          coc-snippets
          coc-tsserver
          editorconfig-nvim
          elm-vim
          fzf-vim
          psc-ide-vim
          purescript-vim
          typescript-vim
          vim-abolish
          vim-airline
          vim-airline-themes
          vim-bracketed-paste
          vim-solarized8
          vim-commentary
          vim-gitgutter
          vim-javascript
          vim-json
          vim-nix
          vim-peekaboo
        ];
    extraConfig = ''
      set nocompatible
      set encoding=utf-8

      " Syntax highlighting
      colorscheme solarized8
      filetype plugin on
      syntax enable
      set t_Co=256
      set background=dark

      " Set relevant filetypes
      au BufRead,BufNewFile *.scss set filetype=css
      au BufRead,BufNewFile *.md set filetype=markdown
      autocmd BufNewFile,BufRead *.py set filetype=python

      " Tabs, indentation and lines
      filetype plugin indent on
      set expandtab
      set shiftwidth=2
      set tabstop=2
      set softtabstop=2
      set shiftround
      set nowrap
      set formatoptions+=t

      " Interactions
      " Start scrolling slightly before the cursor reaches an edge
      set scrolloff=3
      set sidescrolloff=5
      " Scroll sideways a character at a time, rather than a screen at a time
      set sidescroll=1
      " Allow motions and back-spacing over line-endings etc
      set backspace=indent,eol,start
      set whichwrap=h,l,b,<,>,~,[,]
      " Underscores denote words
      set iskeyword-=_
      set wildmenu
      set wildmode=longest,list

      " Automatically remove trailing whitespace
      autocmd BufWritePre * %s/\s\+$//e

      " Visual decorations
      " Show status line
      set laststatus=2
      " Show what mode you’re currently in
      set showmode
      " Show what commands you’re typing
      set showcmd
      " Allow modelines
      set modeline
      " Show current line and column position in file
      set ruler
      " Show file title in terminal tab
      set title
      " Set relative line numbers if we can
      if exists("+relativenumber")
          " Due to a problem with relative line numbers not persisting across new
          " tabs and splits, set no line numbers at all...
          set nonumber
          " ..then set relative ones.
          set relativenumber
      " ...otherwise let’s just have regular ones.
      else
          set number
      endif
      " Limit line-length to 80 columns by highlighting col 81 onward
      if exists("+colorcolumn")
          set colorcolumn=81
      endif
      " Highlight current line
      set cursorline
      " Don’t keep results highlighted after searching...
      set nohlsearch
      " ...just highlight as we type
      set incsearch
      " Ignore case when searching...
      set ignorecase
      " ...except if we input a capital letter
      set smartcase

      " Synchronize the unnamed register with the system clipboard.
      " Enables:
      " - Ctrl-c to clipboard, p in Vim
      " - y in Vim, Ctrl-p from clipboard
      set clipboard=unnamedplus

      " Key mappings
      " jj to throw you into normal mode from insert mode
      inoremap jj <esc>
      " jk to throw you into normal mode from insert mode
      inoremap jk <esc>
      " Disable arrow keys (hardcore)
      map  <up>    <nop>
      imap <up>    <nop>
      map  <down>  <nop>
      imap <down>  <nop>
      map  <left>  <nop>
      imap <left>  <nop>
      map  <right> <nop>
      imap <right> <nop>
      "Create blank line without entering insert mode
      " blank line below
      map <Enter> o<ESC>
      " blank line above
      map <S-Enter> O<ESC>
      :let mapleader = ";"
      " Easier buffer navigation
      map <Leader>l :ls<CR>:b
      map <Leader>j :bn<CR>
      map <Leader>k :bp<CR>
      " Easier .vimrc sourcing
      map <Leader>s :source $MYVIMRC<CR>
      " Easter file write
      map <Leader>w :w<CR>
      " Easier close buffer without closing window
      map <Leader>c :Bclose<CR>
      map <Leader>v :%s/\s\+$//e<CR>

      " Replace the word under the cursor with the last yanked text
      " https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Stamping
      nnoremap <Leader>S diw"0P
      nnoremap <Leader>p "0p
      nnoremap <Leader>P "0P

      " Plugin config
      let purescript_indent_if = 0
      let purescript_indent_case = 2
      let purescript_indent_let = 2
      let purescript_indent_where = 2
      let purescript_indent_do = 2
      let purescript_indent_in = 2
      filetype plugin indent on

      let g:airline_theme='solarized'

      " highlight jsx in .js files
      let g:jsx_ext_required = 0

      " fzf fuzzy search
      " https://github.com/junegunn/fzf#as-vim-plugin
      " set rtp+=~/.fzf
      set rtp+=/usr/local/opt/fzf

      " Toggle fzf
      map <Leader>n :Files<CR>
      map <Leader>r :Rg<CR>

      " https://vi.stackexchange.com/a/26775
      " https://stackoverflow.com/questions/64180454/how-to-change-coc-nvim-floating-window-colors/64293783#64293783
      " https://github.com/neoclide/coc.nvim/discussions/3351
      " :Help coc-completion
      highlight CocFloating ctermfg=Black ctermbg=White
      highlight CocMenuSel ctermfg=Black ctermbg=Blue

      " So that coc stuff takes effect faster.
      set updatetime=300

      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gr <Plug>(coc-references)
      nmap <silent> rn <Plug>(coc-rename)

      imap <C-l> <Plug>(coc-snippets-expand)
      " Use <C-j> for select text for visual placeholder of snippet.
      vmap <C-j> <Plug>(coc-snippets-select)

      nmap <leader>as  <Plug>(coc-codeaction-source)

      " Use K to show documentation in preview window
      nnoremap <silent> K :call ShowDocumentation()<CR>

      function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
          call CocActionAsync('doHover')
        else
          call feedkeys('K', 'in')
        endif
      endfunction

      autocmd BufNewFile,BufRead *.code-snippets set filetype=json

      set mouse=""

      set noswapfile
    '';
    coc = {
      enable = true;
      settings = {
        "eslint.autoFixOnSave" = true;
        # "languageserver" = {
        #   "haskell" = {
        #     "args" = ["--lsp" "-l" "hls.log"];
        #     "command" = "haskell-language-server-wrapper";
        #     "filetypes" = ["haskell" "lhaskell" "hs"];
        #     "rootPatterns" = ["*.cabal" "stack.yaml" "cabal.project" "package.yaml" "hie.yaml"];
        #     "trace.server" = "verbose";
        #     "initializationOptions" = {
        #       "languageServerHaskell.maxCompletions" = 10;
        #     };
        #     "codeLens.enable" = true;
        #     "diagnostic.checkCurrentLine" = true;
        #   };
        # };
        "snippets.textmateSnippetsRoots" = [
          "/Users/maxhallinan/snippets/"
        ];
      };
    };
  };
}
