module.exports = class Anagram
  constructor: (word) ->
    @word = word.toLowerCase()
    @key = @to_key(@word)

  to_key: (word) ->
    word.replace(/[^a-z]/g, '').split('').sort().join('').trim()

  match: (words) ->
    [to_key, key, original_word] = [@to_key, @key, @word]
    words.map((x) -> x.toLowerCase()).filter (word) -> key == to_key(word) and word != original_word
