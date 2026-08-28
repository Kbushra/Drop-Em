hosts = [];

connecting = false;
connected = false;
client_id = NONE;
client_count = 0;
clients_removed = 0;

//Stores instances that use server's object data to update themselves
instances = {};
frame_data = {};
frame_data_delay = 0;
last_frame_data_time = current_time;