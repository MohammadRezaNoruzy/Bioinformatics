# Protein Folding Simulation Using Genetic Algorithm

This repository contains an implementation of a **Protein Folding Simulation** using a **Genetic Algorithm (GA)**. The algorithm simulates protein folding based on the **HP Model**, optimizing the fold to minimize energy while ensuring a **self-avoiding walk**.

## Features
- Implements the **HP Model** for protein folding
- Utilizes **Genetic Algorithm** with **selection, crossover, and mutation**
- Ensures **self-avoiding walk validation**
- Calculates **energy-based fitness evaluation**
- **Visualizes** the best fold using `matplotlib`

## Requirements
Ensure you have the following dependencies installed:

```bash
pip install numpy matplotlib
```

## How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/Bioinformatics.git
   cd Bioinformatics
   ```
2. Run the script:
   ```bash
   python protein_folding_ga.py
   ```
3. Enter a **protein sequence** using only 'H' and 'P' (e.g., `HHPPHHPH`)
4. Specify **population size** and **number of generations**
5. The algorithm will output the **best folding sequence** and its **energy**
6. A **visualization** of the best folding configuration will be displayed

## Example Output
```
Enter the protein sequence (e.g., HHHPHPPHH): HPHPPHHP
Enter Population Size: 100
Enter Number of Generations: 500
Best Fold: ['R', 'U', 'L', 'D', 'R', 'U', 'L']
Best Energy: -3
```

## Visualization
The program generates a graphical representation of the best fold:
![image](https://github.com/user-attachments/assets/27e382c3-67fa-42e9-b115-04ac737d1f7f)


![Protein Folding Visualization](example_visualization.png)

## Algorithm Explanation
The **Genetic Algorithm** follows these steps:
1. **Initialize** a random population of folds
2. **Evaluate** fitness using energy calculation
3. **Select** parents using a weighted probability
4. **Crossover** to generate offspring
5. **Mutate** some individuals randomly
6. **Repeat** for multiple generations
7. **Return** the best fold with the lowest energy

## License
This project is **open-source** under the MIT License.

## Contribution
Feel free to contribute by creating **pull requests** or **reporting issues**!

---

Let me know if you need any modifications! 🚀

