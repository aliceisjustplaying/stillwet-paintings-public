pS2 = pile{{"raw umber",2},{"bone black",1},{"smalt",1.2}, medium=0.35}
b = brush{kind="filbert", width=54, stiffness=0.3, splay=0.35}
b:load(pS2, 0.45)
b:stroke({{300,616},{420,632},{560,648}}, {pressure={0.55,0.12}, ramps={0.15,0.5}})
b:stroke({{636,646},{760,664},{880,676}}, {pressure={0.5,0.12}, ramps={0.15,0.5}})
b:stroke({{140,668},{240,680},{330,688}}, {pressure={0.45,0.15}, ramps={0.15,0.5}})
b:stroke({{848,658},{920,668},{990,674}}, {pressure={0.45,0.15}, ramps={0.15,0.5}})
tfree = tablemask - objall
smask = (sh_bot + sh_bowl + sh_lem + sh_pear2):soften(18) * tfree
blend(smask, {seed=501, coverage=1.6, pressure={0.3,0.3}})
