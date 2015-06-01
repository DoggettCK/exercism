# Print out a rhyme
class FoodChain
  VERSION = 1

  VERSES = {
    'fly' => {},
    'spider' => {
      'action' => 'wriggled and jiggled and tickled inside her',
      'reaction' => 'It wriggled and jiggled and tickled inside her.'
    },
    'bird' => {
      'reaction' => 'How absurd to swallow a bird!'
    },
    'cat' => {
      'reaction' => 'Imagine that, to swallow a cat!'
    },
    'dog' => {
      'reaction' => 'What a hog, to swallow a dog!'
    },
    'goat' => {
      'reaction' => 'Just opened her throat and swallowed a goat!'
    },
    'cow' => {
      'reaction' => 'I don\'t know how she swallowed a cow!'
    },
    'horse' => {
      'outcome' => 'She\'s dead, of course!'
    }
  }

  FORMATS = {
    perhaps: 'I don\'t know why she swallowed the %s. Perhaps she\'ll die.',
    swallow_action: 'She swallowed the %s to catch the %s that %s.',
    swallow: 'She swallowed the %s to catch the %s.'
  }

  def self.song
    seen_animals = []
    output = []

    VERSES.keys.each do |animal|
      seen_animals.push(animal)

      next if handle_outcome(animal) { |x| output.push(x) }
      handle_reaction(animal) { |x| output.push(x) }
      traverse_swallowed(seen_animals.dup) { |x| output.push(x) }

      output.push ''
    end

    output.join("\n")
  end

  def self.handle_reaction(animal)
    yield VERSES[animal]['reaction'] if VERSES[animal]['reaction']
  end

  def self.traverse_swallowed(swallowed_animals)
    until swallowed_animals.empty?
      swallowed = swallowed_animals.pop

      handle_pair(swallowed, swallowed_animals.last) { |line| yield line }
    end
  end

  def self.handle_pair(predator, prey)
    if prey.nil?
      yield format(FORMATS[:perhaps], predator)
    else
      action = VERSES[prey]['action']
      if action
        yield format(FORMATS[:swallow_action], predator, prey, action)
      else
        yield format(FORMATS[:swallow], predator, prey)
      end
    end
  end

  def self.handle_outcome(animal)
    yield "I know an old lady who swallowed a #{animal}."

    if VERSES[animal]['outcome']
      yield VERSES[animal]['outcome']
      yield ''
      return true
    end

    false
  end
end
