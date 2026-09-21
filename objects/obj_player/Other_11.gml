///@desc States

state = new SnowState("walk");
state.event_set_default_function("step", empty);
state.event_set_default_function("draw", draw_self);
state.add("walk", {});
state.add("knockback", {});
state.add("ghost", {});