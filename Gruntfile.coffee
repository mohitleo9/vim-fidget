module.exports = (grunt) ->
    grunt.initConfig({
        watch:
            reTest:
                files: ['*.sh']
                tasks: ['shell:testCurl']
        nodemon:
            dev:
                script: 'node_server.js'
        shell:
            testCurl:
                options:
                    stdout: false
                    stderr: false
                command: 'sh testCurl.sh'

        concurrent:
            options:
                logConcurrentOutput: true
            mainTask: ['nodemon', 'watch']

    })

    grunt.loadNpmTasks 'grunt-nodemon'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-shell'
    grunt.loadNpmTasks 'grunt-concurrent'

    grunt.registerTask 'default', ['concurrent']
