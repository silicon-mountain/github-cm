const fs = require('fs');
var dataFile = JSON.parse(fs.readFileSync('step4.json'));

function sortUsersBy(key, dataObject) {
	return dataObject.sort(function (a, b) {
		var x = parseInt(a[key]); 
		var y = parseInt(b[key]);
		return ((x > y) ? -1 : ((x < y) ? 1 : 0));
	});
}
dataFile = sortUsersBy('repos', dataFile);
fs.appendFileSync('sortedUserData.json', JSON.stringify(dataFile));
