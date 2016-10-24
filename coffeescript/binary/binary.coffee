module.exports = class Binary
  constructor: (str) ->
    @number = '0' + str

  toDecimal: ->
    @number.replace(/[^01]/g, '').split('').reverse().reduce((acc, x, i) ->
      return acc + 2**i if x == '1'
      acc
    , 0)

