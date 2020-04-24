require('vis')

require('vis-commentary')

vis.events.subscribe(vis.events.INIT, function()
  vis:command('set theme gruvbox')
  vis:command('set tabwidth 2')
  vis:command('set expandtab')
  vis:command('set autoindent')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
  vis:command('set number')
  vis:command('set cursorline')
end)

