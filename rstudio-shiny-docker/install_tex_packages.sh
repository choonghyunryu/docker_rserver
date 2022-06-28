#!/bin/bash
set -e

# install tex packages with tinytex
R -e "tinytex::tlmgr_install(c('iftex', 'amsmath', 'cjk-ko', 'kotex-plain', 'kotex-utf', 'adjustbox', 'amscls', 'amsmath', 'beamer', 'biblatex'))"
R -e "tinytex::tlmgr_install(c('booktabs', 'caption', 'changepage', 'collectbox', 'dantelogo', 'dtk', 'dvips', 'ec', 'enumitem', 'environ'))"
R -e "tinytex::tlmgr_install(c('etoolbox', 'euenc', 'expex', 'fancyhdr', 'fancyvrb', 'float', 'fontspec', 'forloop', 'framed', 'fvextra', 'zapfding'))"
R -e "tinytex::tlmgr_install(c('geometry', 'gsftopk', 'helvetic', 'hyperref', 'ifluatex', 'ifmtarg', 'ifplatform', 'ifxetex', 'jknapltx', 'latexmk'))"
R -e "tinytex::tlmgr_install(c('lineno', 'logreq', 'lua-visual-debug', 'luainputenc', 'luatexko', 'mathspec', 'mathtools', 'ms', 'nanumtype1', 'natbib'))"
R -e "tinytex::tlmgr_install(c('oberdiek', 'pgf', 'pgfplots', 'relsize', 'rsfs', 'setspace', 'tcolorbox', 'tetex', 'tikz-cd', 'times', 'tipa'))"
R -e "tinytex::tlmgr_install(c('titlesec', 'titling', 'translator', 'trimspaces', 'ulem', 'upquote', 'wrapfig', 'xcolor', 'xifthen', 'xstring', 'xunicode'))"
R -e "tinytex::tlmgr_install(c('epstopdf-pkg', 'paralist', 'placeins', 'sauerj', 'tufte-latex', 'hardwrap', 'catchfile', 'metalogo', 'xltxtra', 'realscripts'))"
R -e "tinytex::tlmgr_install(c('ragged2e', 'textcase', 'units', 'mdwtools', 'morefloats', 'etex-pkg', 'multirow', 'sttools', 'dblfloatfix', 'soul', 'bookmark'))"
R -e "tinytex::tlmgr_install(c('subfig', 'footmisc', 'varwidth', 'stix', 'eso-pic', 'algorithms', 'algorithmicx')"
