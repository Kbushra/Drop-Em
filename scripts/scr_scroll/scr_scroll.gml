function get_scrollbar_height(content_height, container_height, scrollbar_container_height)
{
	if content_height == 0 || content_height < container_height { return 0; }
	return scrollbar_container_height * container_height/content_height;
}

function get_content_scroll(content_height, container_height, scrollbar_container_height, scrollbar_scroll)
{
	var scrollbar_height = get_scrollbar_height(content_height, container_height, scrollbar_container_height);
	var max_scrollbar_scroll = scrollbar_container_height - scrollbar_height;
	return (content_height - container_height) * scrollbar_scroll/max_scrollbar_scroll;
}