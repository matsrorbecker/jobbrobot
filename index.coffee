fs =            require 'fs'
path =          require 'path'
express =       require 'express'
bodyParser =    require 'body-parser'

app = express()

app.locals.formatPercentage =       require('./lib/utils').formatPercentage
app.locals.capitalizeFirstLetter =  require('./lib/utils').capitalizeFirstLetter

app.locals.getAdjective =           require('./lib/words').getAdjective
app.locals.getVerb =                require('./lib/words').getVerb
app.locals.getNoun =                require('./lib/words').getNoun

app.set 'view engine', 'jade'
app.set 'views', path.join __dirname, 'views'
app.use express.static path.join __dirname, 'public'
app.use bodyParser.urlencoded { extended: false }

data = JSON.parse fs.readFileSync('./data/data.json', 'utf8')
app.locals.totals = data.shift()

getData = (municipality) ->
    for obj in data
        if obj.municipality.toLowerCase() == municipality.toLowerCase().trim()
            return obj

app.get '/', (req, res) ->
    res.render 'index', {}

app.post '/', (req, res) ->
    choice = req.body.municipality
    localData = getData choice
    if !localData
        res.render 'index', { municipality: choice, validChoice: false }
    else
        localData.validChoice = true
        res.render 'index', localData

app.listen process.env.PORT or 3000
