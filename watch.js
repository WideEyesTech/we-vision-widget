var child_process = require('child_process');
var watch = require('node-watch');
var fs = require('fs');

var isRunningOnce = process.argv[2] === 'once';

// Run coffee command line watcher
if (isRunningOnce) {
	child_process.exec('node_modules/.bin/coffee -cb -o js coffee', function (err) {
		if (err) {
			console.log("Error while trying to compile CoffeeScript");
			console.log(arguments);
		} else {
			console.log("CoffeeScript compiled");
		}
	});
} else {
	var coffeeWatcher = child_process.spawn('node_modules/.bin/coffee', ['-wcb', '-o', 'js', 'coffee']);
	coffeeWatcher.stdout.on('data', function(chunk) {
		console.log(chunk.toString('utf8'));
	});
	coffeeWatcher.unref();
}



// Watch templates
function compileHandlebars (filename) {
	filename = filename.replace(/(\s)/g,'\\$1'); // Escape filename for the shell
	child_process.exec('node_modules/.bin/handlebars ' + filename + ' --output js/' + filename.replace(/(\.hbs)|(\.svg)/, '.js') + ' -a -r templates', function (err) {
		if (err) {
			console.log("Error while trying to compile " + filename);
			console.log(arguments);
		} else {
			console.log("Compiled " + filename);
		}
	});
}

function compileHandlebarsForDirectory (dir) {
	fs.readdir(dir, function (err, files) {
		if (err) {
			return console.log(arguments);
		}

		files.forEach(function (file) {
			// Check if file is a system file (begins with ".") or a directory (assume files without "." are directories)
			if (file.indexOf('.') === 0 || file.indexOf('.') === -1) {
				return;
			}
			compileHandlebars(dir + '/' + file);
		});
	});
}

try { fs.mkdirSync('js'); } catch (err) {}
try { fs.mkdirSync('js/templates'); } catch (err) {}

compileHandlebarsForDirectory('templates');

if (!isRunningOnce) {
	watch('templates', function (filename) {
		compileHandlebars(filename);
	});
}




// Kill child processes on exit
process.on('exit', function() {
	void (coffeeWatcher && coffeeWatcher.kill());
});
