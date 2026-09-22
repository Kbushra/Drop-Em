function coordinate(_x, _y) constructor
{
	x = _x;
	y = _y;
}

function range(_minimum, _maximum) constructor
{
	minimum = _minimum;
	maximum = _maximum;
	
	static range_clamp = function(n) { return clamp(n, minimum, maximum); }
}