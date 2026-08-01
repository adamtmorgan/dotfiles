-- Launch apps via UWSM so they land in app-graphical.slice.

return function(cmdline)
  return "uwsm app -- " .. cmdline
end
