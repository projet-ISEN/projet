

const fs    = require('fs');
const exec  = require('child_process').exec;

const deployPath = '/var/www/html/clubs';

console.log('####### Start deployment #######');

console.log('####### PULL #######');

exec('git pull origin master', (err, sout, serr) => {
    console.log(`stdout: ${sout}`);
    console.log(`stderr: ${serr}`);


    if (err !== null) {
        console.log(`exec error: ${err}`);
        return;
    }

    console.log('####### GULP #######');

    exec('gulp make', (err, sout, serr) => {
        console.log(`stdout: ${sout}`);
        console.log(`stderr: ${serr}`);

        if (err !== null) {
            console.log(`exec error: ${error}`);
            return;
        }

        console.log('####### COPY FRONT #######');

        exec('cp -R ./public/build/ ' + deployPath + '/public/build/',
            (err, sout, serr ) => {

            console.log(`stdout: ${sout}`);
            console.log(`stderr: ${serr}`);

            if (err !== null) {
                console.log(`exec error: ${error}`);
                return;
            }

            console.log('####### COPY BACK #######');

            exec('cp -R ./api/ ' + deployPath + '/api',
                (err, sout, serr ) => {

                console.log(`stdout: ${sout}`);
                console.log(`stderr: ${serr}`);

                if (err !== null) {
                    console.log(`exec error: ${error}`);
                    return;
                }



            });
        });
    });
});
