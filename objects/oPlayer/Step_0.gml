// If dying, flash red and wait for Alarm_0 to restart
if (dying) {
	image_alpha = lerp(image_alpha, 0, 0.08); //fade out while waiting
	exit;
}

x_speed=0; //reset horizontal speed

// ------------------------------------
// FREEZE FRAME (top of Step)
// ------------------------------------
if (freeze_timer > 0) {
    freeze_timer--;
    exit;
}


// ------------------------------------
// COOLDOWNS
// ------------------------------------
if (dash_cooldown_timer > 0) {
    dash_cooldown_timer--;
}


// ------------------------------------
// RESET AIR DASH ON LAND
// ------------------------------------
if (place_meeting(x, y + 1, oSolid)) {
    air_dashes_left = max_air_dashes;
}


// ------------------------------------
// NORMAL MOVEMENT (disabled during dash)
// ------------------------------------
if (!dashing) {

    if (keyboard_check(vk_right)) {
        x_speed = movement_speed;
        image_xscale = 1;
    }
    else if (keyboard_check(vk_left)) {
        x_speed = -movement_speed;
        image_xscale = -1;
    }
    else {
        x_speed = 0;
    }

}


// ------------------------------------
// START DASH (ground OR air)
// ------------------------------------
if (keyboard_check_pressed(vk_space) && !dashing && dash_cooldown_timer <= 0) {

    if (place_meeting(x, y + 1, oSolid) || air_dashes_left > 0) {

        dashing = true;
        dash_timer = dash_duration;
        dash_dir = image_xscale;

        y_speed = 0;
        grav = 0;

        sprite_index = spr_dashing;

        // Freeze + Camera Shake
        freeze_timer = 3;
        shake_timer = 10;
        shake_strength = 6;

        if (!place_meeting(x, y + 1, oSolid)) {
            air_dashes_left--;
        }
    }
}


// ------------------------------------
// DASH LOGIC
// ------------------------------------
if (dashing) {

    x_speed = dash_dir * (movement_speed * 5);
    dash_timer--;

    // Dash cancel into jump
    if (keyboard_check_pressed(vk_up)) {
        dashing = false;
        y_speed = -jump_speed;
    }

    if (dash_timer <= 0) {
        dashing = false;
    }

    if (!dashing) {
        grav = 1;
        sprite_index = spr_normal;
        dash_cooldown_timer = dash_cooldown;
    }
}

// ------------------------------------
// CAMERA SHAKE
// ------------------------------------
if (shake_timer > 0) {
    shake_timer--;
    shake_strength *= 0.9;

    var offset_x = random_range(-shake_strength, shake_strength);
    var offset_y = random_range(-shake_strength, shake_strength);

    camera_set_view_pos(
        view_camera[0],
        camera_get_view_x(view_camera[0]) + offset_x,
        camera_get_view_y(view_camera[0]) + offset_y
    );
}

if(place_meeting(x,y+1,oSolid)){ //if Pagos is on the ground
	if(keyboard_check_pressed(vk_up)){ //and the 'up' arrow key is pressed
        y_speed = -jump_speed; //make Pagos jump by setting her y_speed to a negative value
	}else if (y_speed > 0){ //otherwise, if Pagos is on the ground but not jumping
		y_speed = 0; //set her y_speed to 0 so she doesn't sink into the ground
	}
}

y_speed+=grav; //add gravity to y_speed

move_and_collide(x_speed, y_speed, oSolid); //use oSolid so all solid objects (oIcePlatform, oIceBlock) block the player

if(place_meeting(x,y,oIcicles)){ //if Pagos collides with the Icicles
	if (!dying) {
		dying = true;
		image_blend = c_red; //flash red on death
		alarm[0] = 45; //restart after ~0.75 seconds
	}
}

if (y>room_height or y<0 or x>room_width or x<0){ //if the player is outside of the room
	if (!dying) {
		dying = true;
		image_blend = c_red;
		alarm[0] = 45;
	}
}

if (!dashing) {
    if (dash_cooldown_timer <= 0) {
        sprite_index = spr_dashavailable;
    } else {
        sprite_index = spr_normal;
    }
}
