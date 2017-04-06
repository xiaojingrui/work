/**
 * @name 本地Cookie类
 * @description 利用cookie来存储本地数据
 */
var _ = require("underscore");

var localCookie = {
    encode: function(s) {
        return encodeURIComponent(s);
    },

    decode: function(s) {
        return decodeURIComponent(s);
    },

    stringifyCookieValue: function (value) {
        return this.encode(_.isObject(value) ? JSON.stringify(value) : String(value));
    },

    parseCookieValue: function (s) {
        if (s.indexOf('"') === 0) {
            // This is a quoted cookie as according to RFC2068, unescape...
            s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
        }

        try {
            // Replace server-side written pluses with spaces.
            // If we can't decode the cookie, ignore it, it's unusable.
            // If we can't parse the cookie, ignore it, it's unusable.
            s = decodeURIComponent(s.replace(pluses, ' '));
            return config.json ? JSON.parse(s) : s;
        } catch(e) {}
    },
    read: function (s, converter) {
        var value = config.raw ? s : this.parseCookieValue(s);
        return _.isFunction(converter) ? converter(value) : value;
    },
    setItem: function( key, value, options ){
        if (value !== undefined && !_.isFunction(value)) {
            options = _.extend({
              expires: 365,
              path: "/",
              domain: location.host
            }, options);

            if (typeof options.expires === 'number') {
                var days = options.expires, t = options.expires = new Date();
                t.setTime(+t + days * 864e+5);
            }

            return (document.cookie = [
                this.encode(key), '=', this.stringifyCookieValue(value),
                options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
                options.path    ? '; path=' + options.path : '',
                options.domain  ? '; domain=' + options.domain : '',
                options.secure  ? '; secure' : ''
            ].join(''));
        }
    },
    getItem: function( key, value, options ){
        var result = key ? undefined : {};

        // To prevent the for loop in the first place assign an empty array
        // in case there are no cookies at all. Also prevents odd result when
        // calling $.cookie().
        var cookies = document.cookie ? document.cookie.split('; ') : [];

        for (var i = 0, l = cookies.length; i < l; i++) {
            var parts = cookies[i].split('=');
            var name = this.decode(parts.shift());
            var cookie = parts.join('=');

            if (key && key === name) {
                // If second argument (value) is a function it's a converter...
                result = this.read(cookie, value);
                break;
            }

            // Prevent storing a cookie that we couldn't decode.
            if (!key && (cookie = this.read(cookie)) !== undefined) {
                result[name] = cookie;
            }
        }

        return result;
    },
    removeItem: function (key, options) {
        if (this.getItem(key) === undefined) {
            return false;
        }

        // Must not alter options, thus extending a fresh object...
        this.setItem(key, '', _.extend({}, options, { expires: -1 }));
        return !this.getItem(key);
    }
};

module.exports = localCookie;
