#------------------------------------------------------------------------------
#           LOAD DEPENDANCIES
#------------------------------------------------------------------------------
gulp            = require 'gulp'
gulpLoadPlugins = require 'gulp-load-plugins'
colors          = require 'colors'
ncp             = require 'ncp'
fs              = require 'fs'

#------------------------------------------------------------------------------
#           INITIALIZE
#------------------------------------------------------------------------------
P               = gulpLoadPlugins()

gulp.task 'default',    ['make', 'watch']
gulp.task 'render',     ['render-index', 'render-view', 'render-directive']
gulp.task 'transpile',  ['trans-coffee', 'render-sass']
gulp.task 'test',       ['test-html', 'test-css']
gulp.task 'make',       ['render', 'transpile', 'load-libs', 'load-imgs'], ->
    
    injectMake  gulp.src [
        'build/app/main.js', 'build/app/*.js', 'build/styles/*.css']
    
gulp.task 'build', 
    ['build-index', 'build-app', 'build-styles', 'build-views'], ->
    
        injectBuild gulp.src [
            'build/app/main.js', 'dist/app/**/*.js', 'dist/styles/*.css']

#------------------------------------------------------------------------------
#           TASKS
#------------------------------------------------------------------------------
fs.exists 'build', (exists) ->

    unless exists then fs.mkdirSync 'build'

# Transpile l'index.jade en HTML
gulp.task 'render-index', ->
    jade 'src/*.jade',                      'build/' 

# Transpile les jade de views en HTML    
gulp.task 'render-view', ->
    jade 'src/views/*.jade',                'build/views/' 

# Transpileles jade des directives en HTML
gulp.task 'render-directive', ->
    jade 'src/app/directives/*.jade',       'build/app/' 
        
        
# Transpile les styles SASS en CSS    
gulp.task 'render-sass', ->
    sass 'src/styles/*.sass',                   'build/styles/'
        
    
# Transpile l'app coffee en js
gulp.task 'trans-coffee', ->
    coffee 'src/app/**/**.coffee',             'build/app/'

gulp.task 'load-libs', ->

    fs.exists 'build/libs/', (exists) ->

        unless exists then fs.mkdirSync 'build/libs/'

        ncp 'src/libs/', 'build/libs/', (err)->
            if      err? then console.error err
            unless  err? then console.log 'Copying libs complete'

gulp.task 'load-imgs', ->

    fs.exists 'build/images/', (exists) ->

        unless exists then fs.mkdirSync 'build/images/'

        ncp 'src/images/', 'build/images/', (err)->
            if      err? then console.error err
            unless  err? then console.log 'Copying libs complete'            

    
#------------------------------------------------------------------------------
#           WATCHER
#------------------------------------------------------------------------------
gulp.task 'watch', ->
    
    # Watch index
    gulp.watch 'src/index.jade'
    .on 'change', (e)->  
    
        jade 'src/*.jade', 'build/'
        injectMake  gulp.src ['build/app/*.js', 'build/styles/*.css']
        console.log 'Index reloaded'
        
    # Watch views
    gulp.watch 'src/views/*.jade'
    .on 'change', (e)->    
        
        jade e.path, 'build/views/'
        console.log "#{e.path} Reloaded"
        
    # Watch styles    
    gulp.watch 'src/styles/*.sass'
    .on 'change', (e)->
        
        sass e.path, 'build/styles/'
        console.log "#{e.path} Reloaded"
    
    # Watch les coffee
    gulp.watch 'src/app/**/**.coffee'
    .on 'change', (e)->
        
        coffee e.path, 'build/app/'
        console.log "#{e.path} Reloaded"
        
    gulp.watch 'src/**.*', (e)->
        console.log e.type
        console.log 'new file detected, re-compilation of project...'
        #gulp.run 'make'

#------------------------------------------------------------------------------
#           CHECKERS
#------------------------------------------------------------------------------
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

        return console.log err if err?
        for file in files
            errors = (JSON.parse (file.contents).toString()).errors
            
            for error in errors
                console.log colors.red("Selector:  ")   + \
                    "#{colors.green error.context}"     + \
                    " line: #{colors.blue error.line} " + \
                    colors.red("error:  ")              + \
                    "#{colors.yellow error.message}" 

#------------------------------------------------------------------------------
#           BUILDERS
#------------------------------------------------------------------------------ 
gulp.task 'build-index', ->
    
    gulp.src 'build/index.html'
    .pipe P.htmlmin(
        #collapseWhitespace: true
        removeComments: false
        preserveLineBreaks: true
    )
    .pipe gulp.dest 'dist/'
                 
gulp.task 'build-app', ->
    
    gulp.src 'build/app/**.js'
    .pipe P.plumberNotifier()
    .pipe P.jsmin()
    .pipe P.concat 'app.js'
    .pipe gulp.dest 'dist/app/'
    
gulp.task 'build-views', ->
    
    gulp.src 'build/app/*.html'
    .pipe P.htmlmin(
        collapseWhitespace: true
    )
    .pipe gulp.dest 'dist/app/'
    
gulp.task 'build-styles', ->
    
    gulp.src 'build/styles/*.css'
    .pipe P.concat('style.css')
    .pipe P.csso()
    .pipe gulp.dest 'dist/styles/'
    
#------------------------------------------------------------------------------
#           HELPERS FUNCTIONS
#------------------------------------------------------------------------------
coffee  = (src, dest) ->
    gulp.src src
    .pipe P.plumberNotifier()
    .pipe P.coffee()
    .pipe(P.flatten())
    .pipe gulp.dest dest
    
jade    = (src, dest) ->
    
    gulp.src src
    .pipe P.plumberNotifier()
    .pipe P.jade(
        pretty: true
    )   
    .pipe gulp.dest dest 

sass    = (src, dest)->
    
    gulp.src src
    .pipe P.plumberNotifier()
    .pipe P.sass()
    .pipe gulp.dest dest
    
injectMake  = (files) ->    

    gulp.src 'build/index.html'
    .pipe P.inject files, 
        relative: true
    .pipe gulp.dest 'build/'

injectBuild  = (files) ->    

    gulp.src 'dist/index.html'
    .pipe P.inject files,
        relative: true
    .pipe gulp.dest 'dist/'
