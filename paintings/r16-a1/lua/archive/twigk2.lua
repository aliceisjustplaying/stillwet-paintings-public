local n = 0
for _,T in ipairs({OAK, OAKX, OAKT, OAKXT, OAK2, OAK2T}) do n = n + tree_restroke(T, twigK, 3.5) end
print(n)
