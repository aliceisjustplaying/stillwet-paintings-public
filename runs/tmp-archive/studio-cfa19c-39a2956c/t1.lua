local cl = oakSil:grow(14):shrink(14)
print(oakSil:area(), cl:area(), (cl-oakSil):area())
for _,p in ipairs({{275,172},{229,313},{283,309},{154,305},{342,313},{337,247},{200,245},{250,250}}) do
  print(p[1],p[2], oakSil:at(p[1],p[2]), cl:at(p[1],p[2]))
end
