hull = outline{{214,441,"c"},{260,447},{340,448},{414,443,"c"},{407,462,"c"},{320,466},{232,462,"c"}, closed=true, char="firm", amount=0.3, seed=41}
work(hull:mask(), {hand="detail", pile=hullP, angle=0, coverage=3, fill=true})
-- the gap between sails and hull: deck clutter, dark
local deck = rect(226,438,188,8):roughen(2,8,3)
work(deck, {hand="detail", pile=hullP, angle=0, coverage=2, fill=true})
