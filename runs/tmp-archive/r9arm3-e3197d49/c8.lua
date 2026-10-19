dry()
WORLD = world{horizon=HZ, sun={azimuth=-80, elevation=2}}
-- an old oak on the mound: a short massive bole, limbs breaking out low and wide, torn open on the left,
-- one long limb reaching right toward the cross
OAK = {{110,420,"c"},{118,360},{160,330,"c"},{150,280},{196,250,"c"},{224,206},{270,214,"c"},{290,170},{332,150,"c"},
       {352,196},{396,200,"c"},{430,236},{478,246,"c"},{524,282},{580,318,"c"},{556,350},{506,352,"c"},{478,392},
       {428,420,"c"},{388,410},{356,440,"c"},{300,436},{262,452,"c"},{220,430},{180,446,"c"},{140,440}}
oak = tree_in{crown=outline{pts=OAK, char="broken", seed=81}, trunk={{322,556},{316,520},{326,488}},
  species="oak", season="winter", sun=WORLD, seed=84, detail=0.65, girth=0.12, voids=1.6}
print(oak)
