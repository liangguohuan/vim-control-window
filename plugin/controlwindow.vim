"=============================================================================
" File:        controlwindow.vim
" Author:      Hanson Leung
" Email:       liangguohuan@gmail.com
" Description: A simple plugin to control window geometry
"=============================================================================
" See documentation in accompanying help file

" autocmd! bufwritepost * source ~/.vim/bundle/vim-control-window/plugin/controlwindow.vim

function! controlwindow#wininfo() abort

python << EOF

import vim
import subprocess


def getoutput(cmd, oneline=1):
    p = subprocess.Popen(cmd, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    output = p.communicate()[0]
    if oneline:
        output = output.replace('\n', '')
    return output

cmd = "xrandr | grep -w connected | sed 's/+.*//g' | grep -o '[0-9]\{3,\}x[0-9]\+'"
output = getoutput(cmd)
SW, SH = output.split('x')

cmd = 'xdotool getactivewindow'
output = getoutput(cmd)
WINID = output

cmd = 'xdotool getwindowgeometry --shell "%s"' % WINID
output = getoutput(cmd, 0)
exec(output)

str = 'return { "WID":%s, "SW":%s, "SH":%s, "X":%s, "Y":%s, "W":%s, "H":%s }' % (WINID, SW, SH, X, Y, WIDTH, HEIGHT)
vim.command(str)

EOF

endfunction

function! controlwindow#sh(cmd) abort

python << EOF

import os
import vim


cmd = vim.eval('a:cmd')
# print cmd
os.system(cmd)

EOF

endfunction

function! controlwindow#action(...) abort
    let I = controlwindow#wininfo()
    let I['SH'] -= g:controlwindow#top#margin*2
    if a:0 == 0
        let w = I['W']
        let h = I['H']
        let x = (I['SW'] - w)/2
        let y = (I['SH'] - h)/2
    elseif a:0 == 1
        let w = (I['SW'] - a:1*2)
        let h = (I['SH'] - a:1*2)
        let x = a:1
        let y = a:1
    elseif a:0 == 2
        let w = (I['SW'] - a:2*2)
        let h = (I['SH'] - a:1*2)
        let x = a:2
        let y = a:1
    elseif a:0 == 3
        let w = (I['SW'] - a:2*2)
        let h = (I['SH'] - a:1 - a:3)
        let x = a:2
        let y = a:1
    else
        let w = (I['SW'] - a:2 - a:4)
        let h = (I['SH'] - a:1 - a:3)
        let x = a:4
        let y = a:1
    endif
    let h += 2
    let w += 2
    let y += g:controlwindow#top#margin
    let cmdstr = printf('xdotool windowsize "%s" %s %s', I['WID'], w, h)
    let cmdstr2 = printf('xdotool windowmove "%s" %s %s', I['WID'], x, y)
    call system(cmdstr)
    call system(cmdstr2)
    if &verbose
        echo printf('sw:%s sh:%s w:%s h:%s x:%s, y:%s', I['SW'], I['SH'], w, h, x, y)
    endif
endfunction

let g:controlwindow#top#margin = '30'

command! -nargs=* ControlWindow execute 'call controlwindow#action(<f-args>)'
