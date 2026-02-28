x_speed=0;
y_speed=0;
movement_speed=4.5;
grav=1;
dying=false;
dashing=false;
dash_timer=0;
dash_duration=20; //frames the dash lasts
dash_cooldown_timer=0;
dash_cooldown=30; //frames before dash can be used again
// sprite variants for toggling layers: use two small resource variants
spr_normal = sPlayer_normal;
spr_dashing = sPlayer_dashing;
sprite_index = spr_normal;