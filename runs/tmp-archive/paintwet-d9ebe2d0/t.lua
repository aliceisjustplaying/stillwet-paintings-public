local fx, fy = 802, SHORE(802) + 1
FIG = body_of{spine={{fx, fy - 52}, {fx + 0.2, fy - 47.5}, {fx + 0.4, fy - 44}, {fx + 0.9, fy - 30}, {fx + 1.3, fy - 14}},
  widths={5.6, 3.6, 10.8, 9.0, 12.0},
  limbs={{{fx - 2.3, fy - 15}, {fx - 2.8, fy}, widths={2.7, 2.0}}, {{fx + 3.5, fy - 15}, {fx + 4.0, fy + 0.5}, widths={2.7, 2.0}},
         {{fx - 4.6, fy - 43}, {fx - 6.2, fy - 28}, widths={3.0, 2.3}}, {{fx + 5.4, fy - 43}, {fx + 6.9, fy - 29}, widths={3.0, 2.3}},
         {{fx - 4.2, fy - 55}, {fx + 4.6, fy - 55.3}, widths={2.6, 2.2}}},
  blend=0.35, char="firm", seed=91}
figM = FIG:mask()
print(fx, fy, figM:area())
show(figM, {label="fig"})
