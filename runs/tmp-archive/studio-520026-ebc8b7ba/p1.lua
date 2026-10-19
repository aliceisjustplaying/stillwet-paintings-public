-- the palette for the repaint. 16 piles, mixed once, kept.
g_dk = pile{{"bone black", 4}, {"raw umber", 3}}                              -- 1 near black
g_wl = pile{{"raw umber", 4}, {"bone black", 2.4}, {"red earth", 2}}         -- 2 wall dark
g_wm = pile{{"raw umber", 3}, {"red earth", 1.6}, {"lead white", 0.5}}     -- 3 wall mid
g_wt = pile{{"raw umber", 2}, {"yellow ochre", 1.6}, {"lead white", 1.1}}   -- 4 wall light
g_tb = pile{{"raw umber", 3}, {"bone black", 3}, {"red earth", 1.2}}       -- 5 table dark
g_cl = pile{{"lead white", 5}, {"raw umber", 0.8}, {"yellow ochre", 0.4}}   -- 6 cloth light
g_cm = pile{{"lead white", 3}, {"raw umber", 1.2}, {"pale smalt", 0.45}}   -- 7 cloth mid
g_cd = pile{{"lead white", 1.6}, {"raw umber", 1.3}, {"pale smalt", 1.1}}  -- 8 cloth shadow
g_rb = pile{{"vermilion", 3}, {"raw umber", 1.6}, {"red earth", 1.6}}      -- 9  red lay-in
g_rm = pile{{"vermilion", 2.4}, {"red earth", 1.6}, {"yellow ochre", 1.1}} -- 10 red mid
g_rl = pile{{"vermilion", 1.5}, {"red earth", 1.3}, {"yellow ochre", 1.3}, {"lead white", 0.9}} -- 11 red lit
g_gb = pile{{"green earth", 2.6}, {"Prussian blue", 0.55}, {"raw umber", 1.2}}                -- 12 green lay-in
g_gm = pile{{"yellow ochre", 3}, {"green earth", 2}, {"raw umber", 0.7}}                       -- 13 green mid
g_gl = pile{{"yellow ochre", 2}, {"green earth", 1.2}, {"lead white", 1.2}}                   -- 14 green lit
g_bw = pile{{"raw umber", 3}, {"red earth", 2}, {"lead white", 0.8}}                           -- 15 bowl lit
g_bd = pile{{"raw umber", 2}, {"bone black", 1.3}, {"red earth", 1.6}}                        -- 16 bowl dark
for _, n in ipairs{"g_dk","g_wl","g_wm","g_wt","g_tb","g_cl","g_cm","g_cd","g_rb","g_rm","g_rl","g_gb","g_gm","g_gl","g_bw","g_bd"} do print(n, _G[n]) end
