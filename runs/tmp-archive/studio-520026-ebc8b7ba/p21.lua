zero = mask(function() return 0 end)
fsh, fli = zero, zero
for _, f in ipairs(FOLDS) do
  fsh = fsh + ribbon(off(f, 24, 15), {22, 30, 42}):soften(15)
  fli = fli + ribbon(off(f, -22, -13), {16, 22, 32}):soften(13)
end
print(string.format("fold shadow %.0f  fold light %.0f", fsh:area(), fli:area()))
work(CLOTH * fsh, {hand="glaze", tool="filbert 20", pile=g_cd, length={90, 220},
                   coverage=2.6, pressure={0.75, 0.5}, angle=1.35, edge="soft"})
work(CLOTH * fli, {hand="glaze", tool="filbert 18", pile=g_cl, length={80, 200},
                   coverage=2.0, pressure={0.7, 0.45}, angle=1.35, edge="soft"})
