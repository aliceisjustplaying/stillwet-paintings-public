HZ = 452
-- the foreground bank: its crest from the left edge down to the right
BANK = {{-5,398},{60,404},{140,428},{230,466},{320,500},{420,530},{520,552},{640,566},{780,574},{900,580},{1005,584}}
-- the pond: far shore just below the horizon, near shore curving
POND_FAR = {{300,468},{420,462},{560,460},{700,461},{840,465},{960,470}}
POND_NEAR = {{330,500},{450,512},{600,520},{760,522},{900,512},{990,500}}
-- far fir wood skyline on the right, over the far shore
WOODTOP = {{520,452},{560,440},{600,432},{650,418},{700,414},{760,408},{820,404},{880,410},{940,400},{1005,396}}
SPIRE = {430, 372}
OAK_FOOT = {176, 424}
FIG = {588, 604}
h = pencil("2H")
h:rule({0, HZ}, {1000, HZ}, {pressure=0.25})
h:sketch(BANK, {pressure=0.3})
h:sketch(POND_FAR, {pressure=0.25})
h:sketch(POND_NEAR, {pressure=0.25})
h:sketch(WOODTOP, {pressure=0.25})
h:rule({SPIRE[1], SPIRE[2]}, {SPIRE[1], HZ-8}, {pressure=0.3})
h:sketch({{OAK_FOOT[1],OAK_FOOT[2]},{172,360},{160,300},{150,250}}, {pressure=0.3})
h:sketch({{FIG[1]-3,FIG[2]},{FIG[1]-2,FIG[2]-26},{FIG[1]+3,FIG[2]-30},{FIG[1]+4,FIG[2]}}, {pressure=0.3})
-- the trodden path to the pond
h:sketch({{700,714},{650,660},{600,612},{560,570},{540,540},{520,520}}, {pressure=0.3})
