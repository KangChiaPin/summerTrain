var fs = require('fs');
var dir = "/home";
var fileName = process.argv[2];
var newFileName = "new" + fileName;
//console.log(fs.readFileSync("passwd","utf-8"));

//console.log(fs.readdirSync(dir));
var validNames = [];
var names = [];
var lines = fs.readFileSync(fileName).toString().split("\n");

for(var i in lines){
		names.push(lines[i].split(":")[0]);
	}

fs.readdir(dir,function(err, dirNames){
	console.log(names);	
	console.log(dirNames);	
	for(var i in dirNames){
		if(names.indexOf(dirNames[i])>-1){
			validNames.push(name);
			console.log(validNames);
		}
	}
});

