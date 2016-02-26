exports.getAdjective = (change) ->
    if change > 0
        'högre'
    else if change < 0
        'lägre'
    else
        'oförändrad'

exports.getVerb = (change) ->
    if change > 0
        'ökade'
    else if change < 0
        'minskade'
    else
        'var oförändrad'
        
exports.getNoun = (change) ->
    if change > 0
        'ökning'
    else if change < 0
        'minskning'
