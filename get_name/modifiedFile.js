var fs = require('fs');
var fileNames = ["passwd", "group", "gshadow", "shadow"];
var dir = process.argv[2];

fs.readdir(dir,function(err, dirNames){
  fileNames.forEach(function(fileName,index){
	var newFileName = "new/" + fileName;
	var lines = fs.readFileSync(fileName).toString().split("\n");
	var output = fs.createWriteStream(newFileName,{encoding : "utf-8"});
	for(var j in lines){
	  if(dirNames.indexOf(lines[j].split(":")[0])>-1){
		output.write(lines[j]+"\n");
	  }
	}
  }); 
});

