lst = [2,4, 1,3]
result = dict()

def generate_seq(arr, start, stop):
    if start < stop:
        n = start
        m = stop 
    else:
        n = stop
        m = start 
        
    for j in range(n, m + 1):
            item = result.get(j, None)
            if item is None:
                result[j] = 1
            else:
                result[j] = item + 1
                
for i in range(len(lst)):
    if i < len(lst) - 1:
        generate_seq(lst, lst[i], lst[i + 1])
                    
nu = None
max_item = None 

for key, value in result.items():
    if max_item is None :
        nu = key
        max_item = value
    elif nu > key and max_item <= value:
        nu = key
        max_item = value
        
print(nu)
    
