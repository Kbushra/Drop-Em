function to_time(_total_seconds)
{
	var minutes = floor(_total_seconds / 60);
	var seconds = floor(_total_seconds) - (minutes * 60);
	return $"{minutes}:{seconds < 10 ? "0" : ""}{seconds}";
}

function near_to(val, nearest) { return round(val / nearest) * nearest; }
function near_equals(val1, val2, diff) { return abs(val1 - val2) <= diff; }

///@func center(box_width, object_width)
///@param box_width {real}
///@param object_width {real}
///@desc this function returns the centered x or y position for an object with a left anchor point
function center(_box, _object) { return _box/2 - _object/2; }

function vector_to_angle(_x, _y)
{
	return darctan2(_x - _y,
		_x + _y);
}

function rotate_vector(_x, _y, deg)
{
	return new coordinate(_x * dcos(deg) + _y * dsin(deg),
		_y * dcos(deg) - _x * dsin(deg));
}

function inv_lerp(a, b, value)
{
	return (value - a) / (b - a);
}

function lerp_delta(a, b, amt)
{
	var _delta = DELTA;
	try { _delta = delta; } catch (e) {}
	
	return lerp(a, b, 1 - power(1 - amt, _delta));
}

function true_mod(dividend, divisor)
{
	return ((dividend % divisor) + divisor) % divisor;
}

enum EDGE
{
	RISE,
	FALL
}

function transformed_sin_point(_x, _min, _start, _max, _point, _edge = EDGE.RISE, _point_edge = EDGE.FALL)
{
	var _period = transformed_sin_get_period(_min, _start, _max, _point, _edge, _point_edge);
	return transformed_sin(_x, _min, _start, _max, _period, _edge);
}

///@param x In degrees
///@param min Trough value
///@param start Y-Intercept
///@param max Crest value
///@param period In degrees
///@param edge Start point in rise or fall
function transformed_sin(_x, _min, _start, _max, _period, _edge = EDGE.RISE)
{
	if !assert(_start == clamp(_start, _min, _max), "Invalid start y in sin phase!") { return 0; }
	if !assert(_min <= _max, "Min and max swapped around in sin phase!") { return 0; }
	
	var phase = darcsin(2 * inv_lerp(_min, _max, _start) - 1);
	if _edge == EDGE.FALL { phase = 180 - phase; }
	
	var normalised_dsin = (dsin(_x * 360/_period + phase) + 1)/2;
	return normalised_dsin * (_max - _min) + _min;
}

///@param min Trough value
///@param start Y-Intercept
///@param max Crest value
///@param point Point with x value in degrees
///@param edge Start point in rise or fall
///@param point_edge Given point in rise or fall
function transformed_sin_get_period(_min, _start, _max, _point, _edge = EDGE.RISE, _point_edge = EDGE.FALL)
{
	if !assert(_point.y == clamp(_point.y, _min, _max), "Invalid point y!") { return 360; }
	if !assert(_start == clamp(_start, _min, _max), "Invalid start y in sin get phase!") { return 360; }
	if !assert(_min <= _max, "Min and max swapped around in sin get phase!") { return 360; }
	
	var phase_point = darcsin(2 * inv_lerp(_min, _max, _point.y) - 1);
	var phase = darcsin(2 * inv_lerp(_min, _max, _start) - 1);
	if _edge == EDGE.FALL { phase = 180 - phase; }
	if _point_edge == EDGE.FALL { phase_point = 180 - phase_point; }
	
	var phase_change = phase_point - phase;
	while (phase_change <= 0) { phase_change += 360; }
	
	var _period = 360 * _point.x / phase_change;
	return _period;
}