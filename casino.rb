require 'pry'

# put down a bet
# random number to bet around
# bet high/Low
# randomize numbers to compare

class HighLow
  def initialize(player)
    @player = player
  end

  def enter_stake
    puts "Please enter stake(i.e. 75): "
    @stake = gets.to_i
  end

  def randomize_number
    puts "Here is the dealer's number(1-13):"
    @rand_num = rand(1..13)
    puts @rand_num
  end

  def second_number
    puts "Here is your number:"
    @second_num = rand(1..13)
    puts @second_num
  end

  def bet
    puts "Guess if your number will be higher or lower than this(i.e. high/low): "
    bet = gets.strip.downcase
    second_number
    if @rand_num > @second_num
      case bet
      when "high"
        puts "You are incorrect. You lose your money."
        @player.bank_roll -= @stake
        puts "Your bank roll is now $#{@player.bank_roll}."
      when "low"
        puts "You are correct. You win some money"
        @player.bank_roll += @stake
        puts "Your bank roll is now $#{@player.bank_roll}."
      else
        puts "That is not a valid guess. Please try again."
        bet
      end
    elsif @rand_num < @second_num
      case bet
      when "high"
        puts "You are correct. You win some money."
        @player.bank_roll += @stake
        puts "Your bank roll is now $#{@player.bank_roll}."
      when "low"
        puts "You are incorrect. You lose your money."
        @player.bank_roll -= @stake
        puts "Your bank roll is now $#{@player.bank_roll}."
      else
        puts "That is not a valid guess. Please try again."
        bet
      end
    else
      puts "It's a tie!"
    end
  end

  def run
    # run the highlow program, call high_low.run underneath my HighLow instance later in the code.
    enter_stake
    randomize_number
    bet
  end
end

class Slots
  def initialize(player)
    @player = player
  end

  def enter_stake
    puts "Please enter stake(i.e. 75): "
    @stake = gets.to_i
  end

  def slots
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @slot_one, @slot_two, @slot_three = arr.sample, arr.sample, arr.sample
    puts "And the slots are rolling!"
    sleep(1)
    print @slot_one
    sleep(1)
    print " #{@slot_two}"
    sleep(1)
    puts " #{@slot_three}"
  end

  def compare_slots
    if (@slot_one == @slot_two) && (@slot_two == @slot_three)
      puts "You win!!! You win some money."
      @player.bank_roll += @stake * 2
      puts "Your bank roll is now $#{@player.bank_roll}."
    elsif (@slot_one == @slot_two) || (@slot_one == @slot_three) || (@slot_two == @slot_three)
      puts "You kind of win! You still win some money."
      @player.bank_roll += @stake
      puts "Your bank roll is now $#{@player.bank_roll}."
    else
      puts "You lose. :( You lose some money."
      @player.bank_roll -= @stake
      puts "Your bank roll is now $#{@player.bank_roll}."
    end
  end

  def run
    enter_stake
    slots
    compare_slots
  end
end

class Player
  attr_accessor :name, :bank_roll

  def initialize(name, bank_roll)
    @name = name
    @bank_roll = bank_roll
  end
end

class Casino
  def initialize
    puts "What is your name player?"
    name = gets.strip
    puts "What is your starting bank roll?(i.e. 500)"
    bank_roll = gets.to_i
    @player = Player.new(name, bank_roll)
    menu
  end

  def menu
    puts "CASINO MENU:"
    puts "1) High / Low"
    puts "2) Slots"
    puts "3) Quit"
    puts "Please make a selection(1-3): "
    menu_choice = gets.to_i
    case menu_choice
    when 1
      high_low = HighLow.new(@player)
      high_low.run
      random_events
      menu
    when 2
      slot_game = Slots.new(@player)
      slot_game.run
      random_events
      menu
    when 3
      puts "Thanks for playing at our casino. Goodbye."
      exit 0
    else
      puts "Invalid game choice"
      menu
    end
  end

  def random_events
    chance = rand(100)
    if chance < 5
      puts "The bartender spilled a drink on you! So sorry, here's some money."
      @player.bank_roll += 75
      puts "Your bank roll is now $#{@player.bank_roll}."
    elsif chance <= 10
      puts "Ocean's Eleven just happened and the casino is broke. Sorry, that means you are too."
      @player.bank_roll -= 100
      puts "Your bank roll is now $#{@player.bank_roll}."
    elsif chance <= 15
      puts "The person next to you at slots just won and shared their winnings with you. Congrats!"
      @player.bank_roll += 150
      puts "Your bank roll is now $#{@player.bank_roll}."
    elsif chance <= 20
      puts "Your grandma got a hold of your bank roll and gambled your money."
      @player.bank_roll -= 80
      puts "Your bank roll is now $#{@player.bank_roll}."
    end
  end
end

class Card
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

ranks = %w{A 2 3 4 5 6 7 8 9 10 J Q K}
suits = %w{Spades Hearts Clubs Diamonds}
stack_of_cards = suits.each_with_object([]) do |suit, res|
  ranks.size.times do |i|
    res << Card.new(ranks[i], suit)
  end
end

casino = Casino.new
