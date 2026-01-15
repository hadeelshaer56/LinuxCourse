import matplotlib.pyplot as plt
import random
import os

os.makedirs("output", exist_ok=True)

x = list(range(10))
y = [random.randint(10, 100) for _ in x]

plt.plot(x, y, marker="o")
plt.title("Graph Generated Inside Docker")

plt.savefig("output/graph.png")
print("Saved to output/graph.png")