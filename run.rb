#!/usr/bin/ruby
# encoding: utf-8

SEED_POPULATION_SIZE = 2
ALPHABET = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 1 2 3 4 5 6 7 8 9 ? , ; . : / ! § ù % * µ $ £ ^ ¨ = + ( ) ' & é ~ # " { } ° ç @ | `] << ' '

# Gives a score to every member of the population
def fitness(member)
  member[:score] = 0
  member[:phrase].each_char.with_index do |member_char, i|
    member[:score] += 10 if member_char == @passphrase[i] # Char is at the right place
    member[:score] += 5  if (member_char != @passphrase[i]) && @passphrase.include?(member_char) # Char is at the wrong place
  end
end

# Create the initial population
def seed
  length = @passphrase.length

  SEED_POPULATION_SIZE.times do |i|
    @seed_population[i] = {
      phrase: ALPHABET.shuffle[0..length].join, # IMPROVE
      score: 0
    }
  end
end

def evolution(population_n)
  population_n.each do |member|
    fitness member
    puts member
  end
end

def main
  @problem_solved = false
  @seed_population = []

  puts "Please enter a passphrase that the algorithm will crack (20 char max):"
  @passphrase = gets.chomp[0..19]
  puts "\nPassphrase to find: \n[#{@passphrase}]"

  puts '------------------------------------------'
  puts 'STEP 1: Create a seed population'
  seed
  puts 'Population intiated:'
  puts @seed_population.map { |el| el[:phrase] }

  puts '------------------------------------------'
  puts 'STEP 2: Start a loop to find the passphrase'
  evolution(@seed_population)
end

main
