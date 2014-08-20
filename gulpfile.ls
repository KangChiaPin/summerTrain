require! <[gulp main-bower-files gulp-concat gulp-filter gulp-jade gulp-livereload gulp-livescript gulp-markdown gulp-print gulp-rename gulp-stylus gulp-util streamqueue tiny-lr]>
require! \fs

port = 1555
tiny-lr-port = 35729

paths =
  app: \app
  build: \public

tiny-lr-server = tiny-lr!
livereload = -> gulp-livereload tiny-lr-server

gulp.task \css ->
  css-bower = gulp.src main-bower-files! .pipe gulp-filter \**/*.css
  styl-app = gulp.src paths.app+\/**/*.styl .pipe gulp-stylus!
  streamqueue {+objectMode}
    .done css-bower, styl-app
    .pipe gulp-concat \app.css
    .pipe gulp.dest paths.build
    .pipe livereload!

gulp.task \html ->
  html = gulp.src paths.app+\/**/*.html
  jade = gulp.src paths.app+\/**/*.jade .pipe gulp-jade {+pretty}
  streamqueue {+objectMode}
    .done html, jade
    .pipe gulp.dest paths.build
    .pipe livereload!
  gulp.src \README.md .pipe gulp-markdown!
    .pipe gulp.dest paths.build
    .pipe livereload!

gulp.task \js ->
  js-bower = gulp.src main-bower-files! .pipe gulp-filter \**/*.js
  ls-app = gulp.src paths.app+\/ani/*.ls .pipe gulp-livescript {+bare}
  streamqueue {+objectMode}
    .done js-bower, ls-app
    .pipe gulp-concat \app.js
    .pipe gulp.dest paths.build
    .pipe livereload!
  gulp.src paths.app+\/*.ls .pipe gulp-livescript {+bare}
    .pipe gulp.dest paths.build
    .pipe livereload!

gulp.task \res ->
  gulp.src paths.app+\/res/**
    .pipe gulp.dest paths.build+\/res
    .pipe livereload!
  gulp.src main-bower-files!, { base: \./bower_components } .pipe gulp-filter \**/fonts/*
    .pipe gulp-rename -> it.dirname = ''
    .pipe gulp.dest paths.build+\/fonts

gulp.task \server ->
  require! \express
  express-server = express!
  express-server.use require(\connect-livereload)!
  express-server.use express.static paths.build
  express-server.listen port
  gulp-util.log "Listening on port: #port"

gulp.task \watch <[build server]> ->
  tiny-lr-server.listen tiny-lr-port, ->
    return gulp-util.log it if it
  gulp.watch paths.app+\/**/*.styl, <[css]>
  gulp.watch [paths.app+\/**/*.html,paths.app+\/**/*.jade,\README.md], <[html]>
  gulp.watch paths.app+\/**/*.ls, <[js]>
  gulp.watch paths.app+\/res/*, <[res]>

gulp.task \build <[css html js res]>
gulp.task \default <[watch]>

# vi:et:ft=ls:nowrap:sw=2:ts=2
