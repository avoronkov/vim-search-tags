search\_tags
===========

Plugin that provides small improvements into vim+ctags integration.

General info
------------

search\_tags plugin searches up to the root directory for files:
 'tags'    - tags files created by ctags,
 'vimpath' - list of relative pathes that woud be automatically
 	included into vim &path variable;
uses the following variables:
 'g:ltags\_cmd' - command to update tags file
 'g:ltags' - absolute path to tags file
 'g:auto\_ltags\_on\_write' - update tags after file saving
and provide the following command:
 :Ltags - update tags file

Install
-------

Install with [pathogen](https://github.com/tpope/vim-pathogen) plugin installed:
`cd ~/.vim/bundle && git clone https://github.com/avoronkov/vim-search-tags`

Usage
-----

Go to root of your project and perform tags indexing:
`ctags -R .`

Navigate to and open some file in the project using vim:
`cd path/to/some/file/in/project; vim file.txt`

Navigate project using "jumps-to-tags-declarations". Check `:help tags-and-searches`.
I mostly prefer using `g CTRL-]` (`:help g_CTRL-]`).

