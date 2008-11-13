
" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set history=300
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

set autoindent
set shiftwidth=2
set tabstop=2
set tabpagemax=60
set autoread
set foldmethod=indent
set foldlevel=20
set copyindent
set expandtab

noremap X :tabn<cr>
noremap Z :tabp<cr>

" lol... cant actually remember what this was for
":imap <C-j> <ESC>:exec "normal f" . leavechar<CR>a

:vnoremap _( <ESC>`>a)<ESC>`<i(<ESC>
:vnoremap _' <ESC>`>a'<ESC>`<i'<ESC>
:vnoremap _" <ESC>`>a"<ESC>`<i"<ESC>
:vnoremap _` <ESC>`>a`<ESC>`<i`<ESC>
:vnoremap _[ <ESC>`>a]<ESC>`<i[<ESC>

:map gf :tabe <cfile><CR>

" Toggle fold state between closed and opened. 
" "
" " If there is no fold at current line, just moves forward.
" " If it is present, reverse it's state.
fun! ToggleFold()
	if foldlevel('.') == 0
		normal! j
	else
		if foldclosed('.') < 0
			. foldclose
		else
			. foldopen
		endif
	endif
	" Clear status line
	echo
endfun

" Map this function to Space key.
noremap <space> :call ToggleFold()<CR>
noremap  "ayawj^/\ddw"aP^

" git conflict resolution macros
" These still have a problem if the conflict marker is on the first or last
" line of the file... but that usually doesent matter
" throw away my code
noremap tm /<<<<<<<V/=======dk/>>>>>>>dd
" throw away their code
noremap tt k/<<<<<<<ddk/=======V/>>>>>>>d
" get rid of the markers and keep the code
noremap tn k/<<<<<<<ddk/=======ddk/>>>>>>>ddk

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
