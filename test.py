mydic = {}
  
for key in range(1, 30):
    mydic[key] = [0]
  
for key in mydic:
    if key % 3 == 1: mydic[key].append(3)

print(mydic)
