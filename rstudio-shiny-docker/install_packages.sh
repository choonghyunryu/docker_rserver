#!/bin/bash

set -e

## build ARGs
NCPUS=${NCPUS:--1}

## related reproducible research
install2.r --error --skipinstalled -n "$NCPUS" \
    markdown \
    pagedown \
    pkgdown \
    htmltools \
    reactable \
    flextable \
    formattable \
    sparkline \
    DT \
    xaringanExtra
    
## related shiny app
install2.r --error --skipinstalled -n "$NCPUS" \
    shinyjs \
    shinydashboard \
    shinydashboardPlus \
    shinyWidgets \
    shinybusy \
    shinythemes \
    shinycssloaders \
    colourpicker \
    flexdashboard \
    xaringanExtra
    
## related text analytics
apt-get install -y gsl-bin libgsl0-dev
install2.r --error --skipinstalled -n "$NCPUS" \
    tidytext \
    text2vec \
    wordcloud2 \
    tau \
    tm \
    arules \
    arulesViz \
    ggraph \
    igraph \
    tidygraph \
    quanteda \
    quanteda.textplots \
    NbClust \
    topicmodels
    
## related data analytics
install2.r --error --skipinstalled -n "$NCPUS" \
    dlookr \
    alookr \
    tidymodels \
    glmnet \
    caret \
    Boruta \
    GGally \
    rpart \
    rpart.plot \
    pROC \
    palmerpenguins \
    parallel \
    doParallel

## misc
install2.r --error --skipinstalled -n "$NCPUS" \
    glue \
    here \
    xlsx \
    openxlsx \
    XML \
    googleVis \
    plotly \
    waffle \
    ggthemes \
    treemapify \
    Cairo \
    ggridges \
    hash \
    renv \
    formatR \
    remotes \
    conflicted

## install from github repository
R -e "remotes::install_github('kassambara/factoextra',    lib = '/usr/local/lib/R/site-library')"
R -e "remotes::install_github('dreamRs/shinytreeview',    lib = '/usr/local/lib/R/site-library')"
R -e "remotes::install_github('choonghyunryu/koscrap',    lib = '/usr/local/lib/R/site-library')"
R -e "remotes::install_github('bit2r/bitNLP',             lib = '/usr/local/lib/R/site-library')"
R -e "remotes::install_github('bit2r/bitReport',          lib = '/usr/local/lib/R/site-library')"
R -e "remotes::install_github('bit2r/BitStat',            lib = '/usr/local/lib/R/site-library')"
R -e "remotes::install_github('hadley/emo',               lib = '/usr/local/lib/R/site-library')"