#!/usr/bin/ruby
# encoding: utf-8

SEED_POPULATION_SIZE = 20
ALPHABET = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 1 2 3 4 5 6 7 8 9 ? , ; . : / ! § ù % * µ $ £ ^ ¨ = + ( ) ' & é ~ # " { } ° ç @ | `] << " "


def fitness(passphrase)
  # TODO
end

# Create the initial population
def seed(passphrase)
  length = passphrase.length
  seed_population = []

  SEED_POPULATION_SIZE.times do |i|
    seed_population[i] = ALPHABET.shuffle[0..length].join
  end
  seed_population
end

def main
  puts "Please enter a passphrase that the algorithm will crack (20 char max):"
  passphrase = gets.chomp[0..19]
  puts "\nPassphrase to find: \n[#{passphrase}]"

  puts "STEP 1: Create a seed population"
  population = seed(passphrase)
  puts "Population intiated:"
  puts population

  fitness(passphrase)
end

main
