#macro SCROLL_PARAMS content_height, container_height, scrollbar_container_height

function get_scrollbar_height(content_height, container_height, scrollbar_container_height)
{
	if content_height == 0 || content_height < container_height { return 0; }
	print($"{content_height}, {container_height}");
	return scrollbar_container_height * container_height/content_height;
}

function get_content_scroll(content_height, container_height, scrollbar_container_height, scrollbar_scroll)
{
	var scrollbar_height = get_scrollbar_height(content_height, container_height, scrollbar_container_height);
	var max_scrollbar_scroll = scrollbar_container_height - scrollbar_height;
	var max_content_scroll = content_height - container_height;
	return scrollbar_scroll/max_scrollbar_scroll * max_content_scroll;
}

function get_scrollbar_scroll(content_height, container_height, scrollbar_container_height, content_scroll)
{
	var scrollbar_height = get_scrollbar_height(content_height, container_height, scrollbar_container_height);
	var max_scrollbar_scroll = scrollbar_container_height - scrollbar_height;
	var max_content_scroll = content_height - container_height;
	return content_scroll/max_content_scroll * max_scrollbar_scroll;
}