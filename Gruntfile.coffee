module.exports = (grunt) ->
    grunt.initConfig({
        nodemon:
            dev:
                script: 'node_server.js'
    })

    grunt.loadNpmTasks('grunt-nodemon')
