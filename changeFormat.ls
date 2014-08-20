require! <[fs]>

(err, data) <-! fs.readFile \table.csv, \utf-8
data = data.split \\n
data.pop!
data.shift!
data[0] = data[0].split \,
output = ''
for i from 1 to data.length - 1 by 1
  data[i] = data[i].split \,
  if data[i][4] - data[i - 1][4] > 0
    select = "1"
  else
    select = "-1"
  output += select
  for j from 1 to data[i].length - 1 by 1
    output += \\t + j + ':' + data[i][j]
  output += \\n
err <-! fs.writeFile \app/res/train_data, output, ->
  console.log \ok
