'use strict';

var gulp = require('gulp'),
	fs = require("fs"),
	runSequence = require('run-sequence'),
	gulpsync = require('gulp-sync')(gulp),
	inline = require('inline-html'),
	replace = require('gulp-string-replace'),
	sass = require('gulp-sass'),
	concat = require('gulp-concat'),
	rename = require("gulp-rename"),
	gulpCopy = require('gulp-copy'),
	browserSync = require('browser-sync'),
	uglify = require('gulp-uglify'),
	uglifycss = require('gulp-uglifycss'),
	html2string = require('gulp-html2string'),
	sourcemaps = require('gulp-sourcemaps');

// Init browser
gulp.task('browser-sync', function() {
    browserSync.init({
        server: {
            baseDir: "./dist"
        }
    });
});

// Refresh browser
gulp.task('reload', [], function (done) {
    browserSync.reload();
    done();
});

// Transpile SCSS
gulp.task('sass', [], function() {
	return  gulp.src( './src/component.scss' )
		.pipe( sass().on('error', sass.logError) )
		.pipe( sourcemaps.init() )
		.pipe( uglifycss() )
		.pipe( sourcemaps.write() )
		.pipe( gulp.dest( './dist/css' ) );
});

// Compile templata
gulp.task('html2js', function () {
	return  gulp.src('./src/template.html')
		.pipe( html2string({ base: './src/template.html', createObj: true, objName: 'TEMPLATE' }) )
		.pipe(rename({extname: '.js'}))
    	.pipe(gulp.dest('./src/template'));
});

// Minify JS
gulp.task('concat', ['html2js'] , function(done) {
	return  gulp.src( ['./src/component.js', './src/template/template.js'] )
		.pipe( concat('main.js') )
		.pipe( sourcemaps.init() )
		.pipe( uglify() )
		.pipe( sourcemaps.write() )
		.pipe( gulp.dest( './dist/js' ) );
});

// Secuence js
gulp.task('js', function() {
	runSequence( 
		['html2js'],
		['concat'],
		['reload']
	)
});

// Copy HTML
gulp.task('copy-html', [], function() {
	return gulp.src( './src/index.html' )
		.pipe( gulp.dest( './dist' ) )
});

// watch files
gulp.task('watch', [], function() {
	gulp.watch( './src/component.js', ['js'] );
	gulp.watch( './src/template.html', [ 'js'] );
	gulp.watch( './src/component.scss', ['sass', 'reload'] );
	gulp.watch( './src/index.html', ['copy-html', 'reload'] );
});

gulp.task( 'default', runSequence(
		[ 'html2js', 'copy-html'], 
		['js', 'sass'], 
		['watch'], 
		['browser-sync'], 
		['reload' ] 
) );
