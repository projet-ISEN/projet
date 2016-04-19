#------------------------------------------------------------------------------
#           LOAD DEPENDANCIES
#------------------------------------------------------------------------------
gulp            = require 'gulp'
gulpLoadPlugins = require 'gulp-load-plugins'
colors          = require 'colors'
options         = require './package.json'

#------------------------------------------------------------------------------
#           INITIALIZE
#------------------------------------------------------------------------------
P               = gulpLoadPlugins()
isDebug         = options.config.debug

gulp.task 'default', ['render', 'watch']
gulp.task 'render', ['render-view', 'render-index', 'render-sass']

#------------------------------------------------------------------------------
#           TASKS
#------------------------------------------------------------------------------
gulp.task 'render-view', ->
    
    gulp.src 'src/views/**.jade'
    .pipe P.jade(
        pretty: Boolean(isDebug)    
    )   
    .pipe gulp.dest 'build/view/' 
    
    
gulp.task 'render-index', ->
    
    gulp.src 'src/index.jade'
    .pipe P.jade(
        pretty: isDebug?    
    )   
    .pipe gulp.dest 'build/'   
    
gulp.task 'render-sass', ->
    
    gulp.src 'src/style/**'
    .pipe P.sass()
    .pipe gulp.dest 'build/style/'
    
#------------------------------------------------------------------------------
#           WATCHER
#------------------------------------------------------------------------------
gulp.task 'watch', ->
    
    gulp.watch 'src/index.jade',       ['render-index']
    .on 'change', (e)->    
        console.log 'Index reloaded'
        
    gulp.watch 'src/views/**',    ['render-view']
    .on 'change', (e)->    
        console.log "#{e.path} Reloaded"
        
    gulp.watch 'src/style/**',         ['render-sass']
    .on 'change', (e)->
        console.log "#{e.path} Reloaded"

#------------------------------------------------------------------------------
#           CHECKERS
#------------------------------------------------------------------------------
gulp.task 'test', [ 'test-html', 'test-css' ]

gulp.task 'test-html', ->
    
    
    console.log P.w3cHtml
    gulp.src 'build/**.html'
    .pipe P.w3cHtml()
    
gulp.task 'test-css', ->
    
    gulp.src 'build/**/*.css'
    .pipe P.w3cCss(
        sleep: 3000
    )
    .pipe P.util.buffer (err, files)->
        # files - array of validation results
        # files[i].contents is empty if there are no errors or warnings found
        return console.log err if err?
        for file in files
            errors = (JSON.parse (file.contents).toString()).errors
            
            for error in errors
                console.log colors.red("Selector:  ") + \
                    "#{colors.green error.context}" + \
                    " line: #{colors.blue error.line} "+ \
                    colors.red("error:  ") + \
                    "#{colors.yellow error.message}" 

    
    