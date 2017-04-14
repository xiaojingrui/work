// 引入 gulp
var gulp = require('gulp'); 

// 引入组件
var concat = require('gulp-concat');
var minifycss = require('gulp-minify-css');
var uglify = require('gulp-uglify');

// 合并，压缩css
gulp.task('css', function() {
    gulp.src(['css/slide.css','css/index.css','css/jun.css'])
        .pipe(concat('main.css'))
        .pipe(minifycss())
        .pipe(gulp.dest('./dist/css'));
});

// 合并，压缩js
gulp.task('scripts', function() {
    gulp.src(['js/**/*.js'])
        .pipe(uglify())
        .pipe(gulp.dest('./dist/js'));
});

// 默认任务
gulp.task('default', ['css', 'scripts']);