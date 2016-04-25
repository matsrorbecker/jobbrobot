var fs = require('fs');
var xlsx = require('xlsx');

var wb = xlsx.readFile('./unemployment.xlsx');
var ws = wb.Sheets[wb.SheetNames[0]];
var data = xlsx.utils.sheet_to_json(ws);
var newData = [];

for (var i = 0; i < data.length; i += 3) {
    var obj = {};
    obj.municipality = data[i].municipality.trim();
    obj.unemployedWomen2015 = data[i].unemployed2015;
    obj.unemployedWomen2016 = data[i].unemployed2016;
    obj.unemployedMen2015 = data[i + 1].unemployed2015;
    obj.unemployedMen2016 = data[i + 1].unemployed2016;
    obj.unemployed2015 = data[i + 2].unemployed2015;
    obj.unemployed2016 = data[i + 2].unemployed2016;
    obj.change = (obj.unemployed2016 - obj.unemployed2015).toFixed(1);
    newData.push(obj);
};

var compare = function (obj1, obj2) {
    return obj1.unemployed2016 - obj2.unemployed2016;
};

// Objektet med genomsnitt för alla kommuner ska inte vara med i rankningen
var totals = newData.shift()

newData.sort(compare);

for (var i = 0; i < newData.length; i++) {
    newData[i].rank = i + 1;
};

// Lägg tillbaka objektet med genomsnitt i början av arrayen
newData.unshift(totals);

fs.writeFileSync('./data.json', JSON.stringify(newData));