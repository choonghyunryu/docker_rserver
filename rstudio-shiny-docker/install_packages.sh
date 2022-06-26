#!/bin/bash

set -e

R -e "install.packages('markdown',           lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('dlookr',             lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('shinyjs',            lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('shinydashboard',     lib = '/usr/local/lib/R/site-library', epos = 'http://cran.rstudio.com/')"
R -e "install.packages('shinydashboardPlus', lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('shinyWidgets',       lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('shinybusy',          lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('shinythemes',        lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('shinycssloaders',    lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('colourpicker',       lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('htmltools',          lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('reactable',          lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('glue',               lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('xlsx',               lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('flextable',          lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('googleVis',          lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('plotly',             lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('waffle',             lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('remotes',            lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('ggthemes',           lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('treemapify',         lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('sparkline',          lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('formattable',        lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('DT',                 lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"
R -e "install.packages('XML',                lib = '/usr/local/lib/R/site-library', repos = 'http://cran.rstudio.com/')"

R -e "install.packages('RMeCab',             lib = '/usr/local/lib/R/site-library', repos = 'https://rmecab.jp/R', type = 'source')"

R -e "remotes::install_github('dreamRs/shinytreeview', lib = '/usr/local/lib/R/site-library')"
R -e "remotes::install_github('choonghyunryu/koscrap', lib = '/usr/local/lib/R/site-library')"