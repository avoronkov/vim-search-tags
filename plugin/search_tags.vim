" ============================================================================
" File:        search_tags.vim
" Description: plugin that adds small improvements into vim+ctags integration
" Maintainer:  Alexander Voronkov <alxnd-r at yandex dot ru>
" Last Change: 11 March, 2013
" License:     BSD-license
"
" Usage:       search_tags plugin searches up to the root directory for files:
"				'tags'    - tags files created by ctags,
"				'vimpath' - list of relative pathes that woud be automatically
"					included into vim &path variable;
"              uses the following variables:
"				'g:ltags_cmd' - command to update tags file
"				'g:ltags' - absolute path to tags file
"				'g:auto_ltags_on_write' - update tags after file saving
"              and provide the following command:
"               :Ltags - update tags file
" ============================================================================

fu FindFileDir(name)
	let l:pat = "%:p"
	let l:path=expand(l:pat)
	while strlen(l:path) > 1
		let l:pat=l:pat . ":h"
		let l:path=expand(l:pat)
		if strlen(l:path) > 1 && filereadable(l:path . "/" . a:name)
			return l:path 
		endif
	endwhile
	return ""
endfu

fu FindFilePath(name)
	let l:dir = FindFileDir(a:name)
	if l:dir != ""
		return l:dir . "/" . a:name
	endif
	return ""
endfu

fu InitTagsPath()
	let l:tagsfile = FindFilePath("tags")
	if l:tagsfile != ""
		let &tags = &tags . "," . l:tagsfile
		let g:ltags = l:tagsfile
	endif
endfu

fu InitPath()
	let l:pathfile = FindFileDir("vimpath")
	if l:pathfile != ""
		for l:line in readfile(l:pathfile . "/vimpath")
			let &path = &path . "," . l:pathfile . "/" . l:line
		endfor
	endif
endfu

fu MyUpdateTags(silent)
	if exists("g:ltags")
		let l:ltagsdir = fnamemodify(g:ltags, ":h")
		let l:ltags_cmd = "ctags -R ."
		if exists("g:ltags_cmd")
			let l:ltags_cmd = g:ltags_cmd
		endif
		exec "!cd " . l:ltagsdir . " && " . l:ltags_cmd
	elseif !a:silent
		echom "g:ltags is not defined"
	endif
endfu

command Ltags call MyUpdateTags(0)

if exists("g:auto_ltags_on_write") && g:auto_ltags_on_write
	autocmd BufWritePost * call MyUpdateTags(1)
endif


call InitTagsPath()
call InitPath()

