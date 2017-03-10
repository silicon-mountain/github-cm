GitHub CM
=========

This project highlights the usage of GitHub in Cameroon. It is based on the [CodeAfrica](http://codeafrica.org) initiative and it's updated and deployed to the [Silicon Mountain](http://smconf.org/github-cm) site. Using GitHub's API it searches for users who have Cameroon or a Cameroonian city listed on their profile. This is an imperfect method but it shows the usage of GitHub in Cameroon.  We feel that this provides a good proxy about where opensource and modern software practices is growing in Cameroon. 

These scripts will generate [github-cm](https://github.com/silicon-mountain/github-cm/blob/master/github-users.csv) list. We use this to generate a Map with [MapBox](http://mapbox.com) and deployed to [Silicon Mountain site](http://smconf.org/github-cm)

Feel free to check out the [license](LICENSE), and make contributions through pull requests.


## Build Instructions

### Prerequisites

Install pip, python, mapbox-studio on your Linux/Mac OS distro

```
$ dnf install python pip | apt-get install python pip | brew install python pip

```
### Build

-----
Create virtualenv and install pip.

```
$ pip install -r requirements.pip

````

* Create  `secret.py` based on your GitHub details.
* Edit `secret.py` with a `clientID` and `secretID` from your github profile/auth page
* Add your username and password (in clear) to `secret.py`

```
$ ./auth.py

```
export the `GITHUB_TOKEN` as suggested.
remove `secret.py`


* Run the following python scripts.

```
$ ./step1_search_by_location.py && ./step2_cleanup_users.py && ./step3_extend_users.py && ./step4_cleanup_dates.py && ./step5_export_for_map.py

```

This generates the github-users.csv


### Render output as markdown

------------

Install Node.js and Node Package Manager
``` shell
$ sudo apt install nodejs
$ sudo apt install npm

```
#### Sort the JSON file

Modify `sortJSON` and change the sort parameter if necessary

``` javascript
	var dataFile = JSON.parse(fs.readFileSync('step4.json'));
	....

	dataFile = sortUsersBy('repos', dataFile);
	fs.appendFileSync('sortedUserData.json', JSON.stringify(dataFile));
```
`repos` can be modified to any key that exit in the JSON file.  
`datafile` string object that holds the formated data.

Run `node sortJSON` to produce a sorted JSON file using `repos` as key.  
The output JSON file `sortedUserData.json`, can then be formated with any [JSON formatter](http://www.freeformatter.com/json-formatter.html)

### Build a markdown from `sortedUserData.json`

The parameters in the `BuildProfileUsingData()` function can be modified eg.

``` javascript
	const userDataObject = JSON.parse(fs.readFileSync('sortedUserData.json').toString());
	...

	function BuildProfileUsingData(index, username, fullname, repos, location, followers, avatar) {...}
```
`index` auto counter  
`username` a key in the JSON file (eg `userDataObject[index].username`)  
`fullname, repos ...` keys in JSON file    

Run `node JSONParser`. This outputs the file `users.md`
## License

github-cm is licensed under [The Apache-2 License](LICENSE).


