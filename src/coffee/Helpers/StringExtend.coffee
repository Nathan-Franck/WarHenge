String.prototype.endsWith = (s) ->
	return this.length >= s.length && this.substr(this.length - s.length) == s;