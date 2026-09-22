draw_set_colour(c_black);

/*
-1s and +1s are added to the coords so that they fill the edge of the window too.
For some reason draw_line works in window pixels, and draw_line_width works in gui, so I
used draw_line_width with width 1.
*/

for (var i = 0; i < (GUI_W + GUI_H + 1) div 2; i++)
{
	var offset = i * 2;
	draw_line_width(offset * first_pass.minimum - 1, offset * (1 - first_pass.minimum) + 1,
		 offset * first_pass.maximum + 1, offset * (1 - first_pass.maximum) - 1, 1);
}

for (var i = 0; i < (GUI_W + GUI_H) div 2; i++)
{
	var offset = i * 2 + 1;
	draw_line_width(offset * second_pass.minimum - 1, offset * (1 - second_pass.minimum) + 1,
		 offset * second_pass.maximum + 1, offset * (1 - second_pass.maximum) - 1, 1);
}

draw_set_colour(c_white);