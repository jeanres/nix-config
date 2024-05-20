return   {
    "vimwiki/vimwiki", 
    dependencies = { "mattn/calendar-vim" },
    init = function() 
        vim.g.vimwiki_list = {
            {
                path = '~/Documents/vimwiki',
                syntax = 'default',
                ext = '.wiki',
            },
        }
    end,
}
