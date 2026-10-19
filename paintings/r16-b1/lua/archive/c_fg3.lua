blend((bankM2 - oakM2:grow(6)) * rect(0, 615, 1000, 75), {angle=0.1, coverage=2.5})
local flare = poly({{258,600},{272,592},{284,578},{290,556},{312,556},{318,578},{330,592},{346,601},{330,603},{300,599},{275,603}}, true):roughen(1.5, 6, 41)
work(flare, {hand="detail", pile=barkD, coverage=3, fill=true, angle=-1.4, length={4,10}})
