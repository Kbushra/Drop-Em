///@desc Typing

if !focused { exit; }

if keyboard_check_pressed(ord("V")) && keyboard_check(vk_control)
	{ typed_string += clipboard_get_text(); }

var len_diff = string_length(keyboard_string) - keyboard_len;
if len_diff < 0
{
	typed_string = string_copy(typed_string, 1, max(0, string_length(typed_string) + len_diff));
}
else if len_diff > 0
{
	for (var i = 0; i < len_diff; i++)
	{
		var ascii = ord(string_char_at(keyboard_string, keyboard_len + i + 1));
		if string_width(typed_string + chr(ascii)) >= sprite_width - 10 { break; }
		if limit >= 0 && string_length(typed_string) >= limit { break; }
	
		if ascii == clamp(ascii, ord("A"), ord("Z")) || ascii == clamp(ascii, ord("a"), ord("z")) ||
		ascii == clamp(ascii, ord("0"), ord("9")) || array_contains(special_chars, ascii)
		{
			typed_string += chr(ascii);
		}
	}
}

if string_length(keyboard_string) >= 1024 || string_length(keyboard_string) < string_length(typed_string)
{
	keyboard_string = typed_string;
}

keyboard_len = string_length(keyboard_string);

with type_bar
{
	x = other.x + 2;
	y = other.y + other.sprite_height/2;
	if typed_string != other.typed_string { image_index = 0; }
	typed_string = other.typed_string;
}