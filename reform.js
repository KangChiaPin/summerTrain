var fs = require('fs');
var filepath = "table.csv";
var tmp = []; 

fs.readFile(filepath, 'utf8', function(err, data) {
	if(err) {
		console.error("Could not open file: %s", err);
		return;
	}
	console.log(data);
	fs.writeFile('trainer_node', data, function(err) {
		if(err) {
			console.error("Could not write file: %s", err);
		}
	});
});
