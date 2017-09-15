#!/usr/bin/ruby
# encoding: utf-8

SEED_POPULATION_SIZE = 20
N_CHILDREN_TO_KEEP = SEED_POPULATION_SIZE / 4
MUTATION_RATE = 0.25
GENE_SCORE_MAX = 10
ALPHABET = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 1 2 3 4 5 6 7 8 9 ? , ; . : / ! § ù % * µ $ £ ^ ¨ = + ( ) ' & é ~ # " { } ° ç @ | `] << ' '

# Gives a score to every indiv of the population
def evaluation(population_n)
  population_n.each do |indiv|
    indiv[:score] = 0
    indiv[:phrase].each_char.with_index do |indiv_char, i|
      indiv[:score] += GENE_SCORE_MAX if indiv_char == @passphrase[i] # Char is at the right place
      indiv[:score] += 5  if (indiv_char != @passphrase[i]) && @passphrase.include?(indiv_char) # Char is at the wrong place
    end
  end
end

# Keeps the N best parents
def selection(population_n)
  population_n.sort_by! { |indiv| -indiv[:score] } # descending
  population_n[0..N_CHILDREN_TO_KEEP]
end

# Create the initial population
def seed
  SEED_POPULATION_SIZE.times do |i|
    @seed_population[i] = {
      phrase: ALPHABET.sample(@passphrase_length).join, # IMPROVE
      score: 0
    }
  end
end

# Takes a char over 2 in every parent
def crossover(parents)
  child = {
    phrase: '',
    score: 0
  }
  @passphrase_length.times do |i|
    child[:phrase] << (i.even? ? parents[0][:phrase][i] : parents[1][:phrase][i])
  end
  child
end

# Mutates a gene following MUTATION_RATE
def mutation(child)
  nb_mutations = (MUTATION_RATE * @passphrase_length).round
  nb_mutations.times do
    index_to_mutate = rand(0..@passphrase_length - 1) # Pick a random index in passphrase
    child[:phrase][index_to_mutate] = ALPHABET.sample # Change the character at the given index
  end
  child
end

def evolution
  population_n = @seed_population
  evaluation(population_n) # evaluation phase
  cpt = 0

  until problem_solved?(population_n) # we decided to stop to the first solution
    children = []
    selected_population = selection(population_n) # selection phase
    # Create population N+1
    SEED_POPULATION_SIZE.times do
      # Pick 2 elements
      parents = selected_population.sample(2)
      # Make baby!
      child = crossover(parents) # Or permutation
      # Mutate!
      child = mutation(child)
      children << child
    end
    population_n = children # Children are now parents
    evaluation(population_n) # evaluation phase
    cpt += 1
  end

  puts "#{cpt} times to find the solution"
  population_n.select { |indiv| indiv[:score] == GENE_SCORE_MAX * @passphrase_length }
end

# Problem is solved when population contains the solution
def problem_solved?(population)
  population.any? { |indiv| indiv[:score] == GENE_SCORE_MAX * @passphrase_length }
end

def main
  @seed_population = []

  puts "Please enter a passphrase that the algorithm will crack (20 char max):"
  @passphrase = gets.chomp[0..19]
  @passphrase_length = @passphrase.length
  puts "\nPassphrase to find: \n[#{@passphrase}]"

  puts '------------------------------------------'
  puts 'STEP 1: Create a seed population'
  seed
  puts 'Population intiated!'

  puts '------------------------------------------'
  puts 'STEP 2: Start a loop to find the passphrase'
  solution = evolution
  puts "PROBLEM SOLVED!"
  puts solution
end

main
