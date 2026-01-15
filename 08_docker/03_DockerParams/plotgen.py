 
import matplotlib.pyplot as plt
import random
import os
import sys

os.makedirs("output", exist_ok=True)

count = int(sys.argv[1]) if len(sys.argv) > 1 else 10

x = list(range(count))
y = [random.randint(10, 100) for _ in x]

plt.plot(x, y, marker="o")
plt.title(f"Graph with {count} points")

plt.savefig("output/graph.png")
print("Saved to output/graph.png")