var instance_ids = struct_get_names(instances);
for (var i = 0; i < array_length(instance_ids); i++)
{
	if instance_exists(instances[$ instance_ids[i]]) && instances[$ instance_ids[i]].persistent { continue; }
	struct_remove(instances, instance_ids[i]);
}