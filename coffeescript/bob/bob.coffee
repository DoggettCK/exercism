module.exports = class Bob
  hey: (text) ->
    [silence, question, has_letters] = (re.test(text) for re in [/^\s*$/, /\?$/, /[a-zA-Z]/])
    loud = (text.toUpperCase() == text)

    return 'Fine. Be that way!' if silence
    return 'Whoa, chill out!' if loud and has_letters
    return 'Sure.' if question
    return 'Whatever.'

