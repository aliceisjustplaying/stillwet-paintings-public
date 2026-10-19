tableline = function(x) return 446 + 0.024 * x end
wallmask = above(tableline)
tablemask = below(tableline)
print("wall", wallmask:area(), "table", tablemask:area())
