import numpy as np
import random
import matplotlib.pyplot as plt

# Function to get user input
def get_user_input():
    sequence = input("Enter the protein sequence (e.g., HHHPHPPHH): ").strip().upper()
    while not all(c in ['H', 'P'] for c in sequence) or len(sequence) < 2:
        print("The sequence must contain only H and P and have at least length 2.")
        sequence = input("Please enter the sequence again: ").strip().upper()
    
    pop_size = int(input("Enter Population Size: "))
    while pop_size <= 0:
        print("Population Size must be greater than 0.")
        pop_size = int(input("Enter Population Size again: "))
    
    num_generations = int(input("Enter Number of Generations: "))
    while num_generations <= 0:
        print("Number of Generations must be greater than 0.")
        num_generations = int(input("Enter Number of Generations again: "))
    
    return sequence, pop_size, num_generations

# Possible movement directions
directions = ['U', 'D', 'L', 'R']

# Function to convert direction to grid coordinates
def move(pos, direction):
    x, y = pos
    if direction == 'U': return (x, y+1)
    if direction == 'D': return (x, y-1)
    if direction == 'L': return (x-1, y)
    if direction == 'R': return (x+1, y)

# Check for self-avoiding walk
def self_avoiding_walk(fold):
    visited = set()
    pos = (0, 0)
    visited.add(pos)
    for direction in fold:
        pos = move(pos, direction)
        if pos in visited:
            return False
        visited.add(pos)
    return True 

# Calculate energy based on HP model
def calculate_energy(sequence, fold):
    if not self_avoiding_walk(fold):
        return float('inf')  # Invalid path

    positions = [(0, 0)]
    for direction in fold:
        positions.append(move(positions[-1], direction))
    
    energy = 0
    n = len(sequence)
    for i in range(n):
        if sequence[i] == 'H':
            for j in range(i+2, n):
                if sequence[j] == 'H':
                    distance = abs(positions[i][0] - positions[j][0]) + abs(positions[i][1] - positions[j][1])
                    if distance == 1:
                        energy += 1
    
    return energy

# Generate initial population
def generate_population(pop_size, sequence):
    population = []
    for _ in range(pop_size):
        fold = [random.choice(directions) for _ in range(len(sequence)-1)]
        population.append(fold)
    return population

# Select parents for crossover
def select_parents(population, sequence):
    fitness = [calculate_energy(sequence, fold) for fold in population]
    finite_fitness = [f if f != float('inf') else 1e10 for f in fitness]
    total_fitness = sum(finite_fitness) if sum(finite_fitness) > 0 else 1
    probabilities = [f/total_fitness for f in finite_fitness]
    parent1 = random.choices(population, probabilities)[0]
    parent2 = random.choices(population, probabilities)[0]
    return parent1, parent2

# Crossover function to create offspring
def crossover(parent1, parent2):
    crossover_point = random.randint(1, len(parent1) - 1)
    child = parent1[:crossover_point] + parent2[crossover_point:]
    return child

# Mutation function
def mutate(fold):
    mutated_fold = fold.copy()
    for i in range(len(mutated_fold)):
        if random.random() < 0.1:
            mutated_fold[i] = random.choice(directions)
    return mutated_fold 

# Genetic Algorithm for protein folding
def genetic_algorithm(sequence, pop_size, num_generations):
    population = generate_population(pop_size, sequence)
    
    for _ in range(num_generations):
        fitness = [calculate_energy(sequence, fold) for fold in population]
        new_population = []
        elite_idx = np.argmin(fitness)
        new_population.append(population[elite_idx])
        
        while len(new_population) < pop_size:
            parent1, parent2 = select_parents(population, sequence)
            child = crossover(parent1, parent2)
            child = mutate(child)
            new_population.append(child)
        
        population = new_population

    best_fold = population[np.argmin([calculate_energy(sequence, fold) for fold in population])]
    best_energy = calculate_energy(sequence, best_fold)
    
    return best_fold, best_energy

# Function to visualize protein folding
def visualize_fold(sequence, fold):
    positions = [(0, 0)]
    for direction in fold:
        positions.append(move(positions[-1], direction))
    
    x, y = zip(*positions)
    plt.plot(x, y, '-o')
    for i, (xi, yi) in enumerate(positions):
        plt.text(xi, yi, sequence[i], fontsize=12)
    plt.grid(True)
    plt.title(f"Energy: {calculate_energy(sequence, fold)}")
    plt.show()

# Run the Genetic Algorithm
if __name__ == "__main__":
    sequence, pop_size, num_generations = get_user_input()
    best_fold, best_energy = genetic_algorithm(sequence, pop_size, num_generations)
    
    if best_energy == float('inf'):
        print("No valid fold found!")
    else:
        print(f"Best Fold: {best_fold}")
        print(f"Best Energy: {best_energy}")
        visualize_fold(sequence, best_fold)
