#!/bin/bash

#first remove vim config
rm -rf ~/.vimrc ~/.vim

#fetch vim-plug 
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#show line numbers
echo "set number" >> ~/.vimrc

#autowrite
echo "set autowrite" >> ~/.vimrc

#change leader char
echo "let mapleader = \",\"" >> ~/.vimrc

#vim-plug scope start
echo "call plug#begin()" >> ~/.vimrc

#add vim-go to .vimrc
echo "Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }" >> ~/.vimrc
#add nerdtree
echo "Plug 'preservim/nerdtree'" >> ~/.vimrc
#nerdtree git plugin
echo "Plug 'scrooloose/nerdtree'" >> ~/.vimrc
echo "Plug 'Xuyuanp/nerdtree-git-plugin'" >> ~/.vimrc 

#end of vim-plug scope
echo "call plug#end()" >> ~/.vimrc

#install plugins
vim +PlugInstall +qall

#vim starts up on opening a directory, vim starts up if no files were specified
cat <<EOF >> ~/.vimrc
" nerdtree settings
let NERDTreeShowHidden=1
autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
EOF

#nerd tree show ignored status
echo "let g:NERDTreeShowIgnoredStatus = 1" >> ~/.vimrc

#some shortcuts to make it easier to jump between golang build errors in quickfix list
cat <<EOF >> ~/.vimrc
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
EOF

#shortcuts to build and run a Go program
cat <<EOF >> ~/.vimrc
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
EOF

#If you add the following to your vimrc all lists will be of type quickfix
echo "let g:go_list_type = \"quickfix\" \"it can be also location list" >> ~/.vimrc

#change the timeout value with 
echo "let g:go_test_timeout = '10s'" >> ~/.vimrc





