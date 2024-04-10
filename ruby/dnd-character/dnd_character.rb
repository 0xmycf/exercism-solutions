# frozen_string_literal: true

# A 6 sided die
class Die
  def initialize
    @rng = Random.new
  end

  def generate
    ret = (1..4).map do
      @rng.rand(1..6)
    end
    ret.sort[1..]
  end
end

# generate a dnd character
class DndCharacter
  ATTRS = %i[
    strength
    dexterity
    constitution
    intelligence
    wisdom
    charisma
  ].freeze

  def self.modifier(const)
    (const - 10) / 2
  end

  def self.things(*args)
    args.each do |arg|
      die = Die.new
      value = die.generate.sum
      define_method(arg) do
        value
      end
    end
  end

  things :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma

  define_method(:hitpoints) { 10 + DndCharacter.modifier(constitution) }

  def initialize; end
end
