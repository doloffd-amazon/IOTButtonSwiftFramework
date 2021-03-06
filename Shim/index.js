'use strict';

const spawnSync = require('child_process').spawnSync;

exports.handler = (event, context, callback) => {
    // Invoke the executable via the provided ld-linux.so – this will
    // force the right GLIBC version and its dependencies
    const options = { input:JSON.stringify(event) };
    const command = 'libraries/ld-linux-x86-64.so.2';
    const childObject = spawnSync(command, ["--library-path", "libraries", "./Lambda"], options)

    if (childObject.error) {
        callback(childObject.error, null);
    } else {
        try {
            // The executable's raw stdout is the Lambda output
            var stdout = childObject.stdout.toString('utf8');
            var stderr = childObject.stderr.toString('utf8');
            console.log(stdout);
            console.warn(stderr);
            var response = { stdout: stdout, stderr: stderr };
            callback(null, response);
        } catch(e) {
            e.message += ": " + stderr
            callback(e, null);
        }
    }
};
