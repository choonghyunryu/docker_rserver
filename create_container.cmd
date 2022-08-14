$env:pwd = Get-Location
$env:app_dir = join-path $env:pwd 'shiny-server/app'
$env:log_dir = join-path $env:pwd 'shiny-server/log'
$env:web_dir = join-path $env:pwd 'web-server/html'

docker run -d -p 3838:3838 -p 8787:8787 -p 80:80 -e PASSWORD=rstudio -e ROOT=TRUE --name rstudio-shiny-server -v $env:app_dir:/srv/shiny-server/ -v $env:web_dir:/var/www/html/ -v $env:log_dir:/var/log/shiny-server/ rserver:first 
