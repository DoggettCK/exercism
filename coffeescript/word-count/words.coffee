module.exports = class Words
  constructor: (words) ->
    @words = words

  count: () ->
    @words.toLowerCase().replace(/[^a-z0-9]/g, ' ').split(/\s+/).reduce((word_count, word) ->
      return word_count if word == ''
      word_count[word] = (word_count[word] || 0) + 1
      word_count
    , {})
