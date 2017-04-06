var fs = require("fs");
var pth = require("path");
var url = require("url");
var _exists = fs.existsSync || pth.existsSync,
	iconv;
var IS_WIN = process.platform.indexOf('win') === 0;

var _ = module.exports = {};

_.is = function(source, type){
    return toString.call(source) === '[object ' + type + ']';
};

_.isFile = function(path){
    return _exists(path) && fs.statSync(path).isFile();
};

_.isDir = function(path){
    return _exists(path) && fs.statSync(path).isDirectory();
};

_.query = function(str){
    var rest = str,
        pos = rest.indexOf('#'),
        hash = '',
        query = '';
    if(pos > -1){
        hash = rest.substring(pos);
        rest  = rest.substring(0, pos);
    }
    pos = rest.indexOf('?');
    if(pos > -1){
        query = rest.substring(pos);
        rest  = rest.substring(0, pos);
    }
    rest = rest.replace(/\\/g, '/');
    if(rest !== '/'){
        rest = rest.replace(/\/\.?$/, '');
    }
    return {
        origin : str,
        rest : rest,
        hash : hash,
        query : query
    };
};

_.ext = function(str){
    var info = _.query(str), pos;
    str = info.fullname = info.rest;
    if((pos = str.lastIndexOf('/')) > -1){
        if(pos === 0){
            info.rest = info.dirname = '/';
        } else {
            info.dirname = str.substring(0, pos);
            info.rest = info.dirname + '/';
        }
        str = str.substring(pos + 1);
    } else {
        info.rest = info.dirname = '';
    }
    if((pos = str.lastIndexOf('.')) > -1){
        info.ext = str.substring(pos).toLowerCase();
        info.filename = str.substring(0, pos);
        info.basename = info.filename + info.ext;
    } else {
        info.basename = info.filename = str;
        info.ext = '';
    }
    info.rest += info.filename;
    return info;
};

_.pathinfo = function(path){
    //can not use _() method directly for the case _.pathinfo('a/').
    var type = typeof path;
    if(arguments.length > 1) {
        path = Array.prototype.join.call(arguments, '/');
    } else if(type === 'string') {
        //do nothing for quickly determining.
    } else if(type === 'object') {
        path = Array.prototype.join.call(path, '/');
    }
    return _.ext(path);
};

function getIconv(){
    if(!iconv){
        iconv = require('iconv-lite');
    }
    return iconv;
}

_.write = function(path, data, charset, append){
    if(!_exists(path)){
        _.mkdir(_.pathinfo(path).dirname);
    }
    if(charset){
        data = getIconv().encode(data, charset);
    }
    if(append) {
        fs.appendFileSync(path, data, null);
    } else {
        fs.writeFileSync(path, data, null);
    }
};

_.mkdir = function(path, mode){
    if (typeof mode === 'undefined') {
        //511 === 0777
        mode = 511 & (~process.umask());
    }
    if(_exists(path)) return;
    path.split('/').reduce(function(prev, next) {
        if(prev && !_exists(prev)) {
            fs.mkdirSync(prev, mode);
        }
        return prev + '/' + next;
    });
    if(!_exists(path)) {
        fs.mkdirSync(path, mode);
    }
};

_.realpath = function(path){
    if(path && _exists(path)){
        path = fs.realpathSync(path);
        if(IS_WIN){
            path = path.replace(/\\/g, '/');
        }
        if(path !== '/'){
            path = path.replace(/\/$/, '');
        }
        return path;
    } else {
        return false;
    }
};
