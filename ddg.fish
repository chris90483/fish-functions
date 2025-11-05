# zoek op duckduckgo naar een zoekterm (spaties toegestaan)
function ddg
    open 'https://duckduckgo.com/?q='(echo $argv | string replace --all ' ' '%20')
end
