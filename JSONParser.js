
const fs = require('fs');
const userDataObject = JSON.parse(fs.readFileSync('step2.json').toString());
var i = 1;

function BuildProfileUsingData(index, username, fullname, repos, location, followers) {
	var github = 'https://github.com/';
	var appender = "<tr><th scope='row'> #" + index + "</th><td><a href='" + github + username + "'>" + fullname + "</a></td><td>" + repos + "</td><td>" + location + "</td><td>" + followers + "<td></tr>";
	return appender;
}

for (var i in userDataObject) {
	fs.appendFileSync('userdata.md', BuildProfileUsingData(
		i, 
		userDataObject[i].username, 
		userDataObject[i].fullname,
		userDataObject[i].repos,
		userDataObject[i].location,
		userDataObject[i].followers
		) + '\n');
}
fs.appendFileSync('userdata.md', '</tbody></table>');
