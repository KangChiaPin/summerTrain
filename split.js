var fs = require('fs');

fs.readFile('whole_data', function (err, data) {
	  if (err) throw err;
	    console.log(data);
});
