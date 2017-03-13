
const fs = require('fs');
const userDataObject = JSON.parse(fs.readFileSync('sortedUserData.json').toString());
var i = 1;

function BuildProfileUsingData(index, username, fullname, repos, location, followers, avatar) {
	var github = 'https://github.com/';
	location = (location == null) ? userDataObject[index].country_name : location;
	fullname = (fullname == '') ? userDataObject[index].username : fullname;
	var appender = "|" + index + "|[" + fullname + "](" + github + username + ") |" + repos + "|" + location + "|" + followers + "| ![profile_img](" + avatar + ") |";
	return appender;
}

for (var i in userDataObject) {
	fs.appendFileSync('users.md', BuildProfileUsingData(
		i,
		userDataObject[i].username,
		userDataObject[i].fullname,
		userDataObject[i].repos,
		userDataObject[i].city_name,
		userDataObject[i].followers,
		userDataObject[i].avatar_url
	) + '\n');
}
fs.appendFileSync('users.md', '\n<link rel="stylesheet" href="style.css" />\n');
