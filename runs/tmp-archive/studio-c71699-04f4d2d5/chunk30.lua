-- Adding the Botanical Lemon Leaf and Stem, and Final Specular Accents

-- Piles
local p_stem = pile{{"raw umber", 6}, {"yellow ochre", 3}, {"bone black", 2}, medium = 0.1}
local p_leaf_dark = pile{{"green earth", 5}, {"yellow ochre", 3}, {"raw umber", 2}, {"Prussian blue", 1}, medium = 0.12}
local p_leaf_lit = pile{{"green earth", 4}, {"yellow ochre", 4}, {"lead white", 2}, medium = 0.12}
local p_leaf_vein = pile{{"yellow ochre", 5}, {"green earth", 3}, {"lead white", 3}, medium = 0.1}
local p_cast = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 1}, medium = 0.25}
local p_spec = pile{{"lead white", 9}, {"yellow ochre", 1}, medium = 0.05}

-- 1. Cast shadow of leaf on table
local leaf_shadow = poly({
  {275, 618}, {262, 610}, {238, 608}, {226, 614}, {238, 624}, {260, 626}, {275, 618}
}, true)
work(leaf_shadow, {hand = "glaze", pile = p_cast, angle = 0.1, coverage = 1.3, edge = 0.3})

-- 2. Leaf silhouette
local leaf_pts = {
  {276, 615}, {262, 602}, {240, 598}, {226, 604}, {236, 616}, {258, 620}, {276, 615}
}
local m_leaf = poly(leaf_pts, true)

-- Leaf body coat
work(m_leaf, {hand = "body", pile = p_leaf_dark, angle = -0.4, coverage = 1.8, fill = true, edge = 0.1})

-- Upper lit facet of the leaf
local m_leaf_lit = m_leaf * mask(function(x, y) return (y < 610) and 1 or 0 end)
work(m_leaf_lit, {hand = "body", pile = p_leaf_lit, angle = -0.4, coverage = 1.5, edge = 0.2})

-- Blend leaf softly
blend(m_leaf, {angle = -0.4, coverage = 1.2})

-- Woody stem connecting leaf to lemon tip
local b_stem = brush{kind = "round", width = 1.8, point = 1, stiffness = 0.7}
b_stem:load(p_stem, 0.8)
b_stem:stroke({{310, 626}, {295, 622}, {276, 615}}, {pressure = {0.6, 0.8, 0.5}, orient = "along"})

-- Central midrib vein of leaf
local b_vein = brush{kind = "round", width = 1.2, point = 1, stiffness = 0.8}
b_vein:load(p_leaf_vein, 0.8)
b_vein:stroke({{276, 615}, {252, 608}, {228, 604}}, {pressure = {0.5, 0.7, 0.3}, orient = "along"})

-- 3. Final specular jewel-like impasto accents on the earthenware jug
local b_jewel = brush{kind = "round", width = 2.2, point = 1, stiffness = 0.8}
b_jewel:load(p_spec, 0.95)
-- Lip sparkle
b_jewel:touch(554, 317, {pressure = 0.9})
-- Shoulder glaze specular highlight
b_jewel:stroke({{539, 436}, {542, 452}}, {pressure = {0.85, 0.95}, orient = "along"})

print("Lemon leaf and final touches completed.")
