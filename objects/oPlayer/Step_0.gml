// If dying, flash red and wait for Alarm_0 to restart
if (dying) {
	image_alpha = lerp(image_alpha, 0, 0.08); //fade out while waiting
	exit;
}

x_speed=0; //reset horizontal speed
y_speed+=grav; //add gravity to y_speed

if (dash_cooldown_timer > 0) { dash_cooldown_timer -= 1; } //count down dash cooldown each step

if keyboard_check(vk_right){ //if the right arrow key is pressed
	x_speed=movement_speed; 
}else if keyboard_check(vk_left){ //otherwise, if the left arrow key is pressed
	x_speed=-movement_speed; //set the horizontal speed to negative movement_speed, making Pagos move left
}

//dash: space triggers a 2x speed burst in the direction Pagos is facing
if (keyboard_check_pressed(vk_space) and !dashing and dash_cooldown_timer <= 0) {
	dashing = true;
	dash_timer = dash_duration;
	sprite_index = spr_dashing; // show the dashing layer variant
}

if (dashing) {
	x_speed = image_xscale * movement_speed * 5; //override x_speed with 2x dash speed in faced direction
	dash_timer -= 1;
	grav=0.5;
	if (dash_timer <= 0) {
		dashing = false;
		grav=1;
		sprite_index = spr_normal;
		dash_cooldown_timer = dash_cooldown; //start cooldown so dash can't be spammed
	}
}

move_and_collide(x_speed, y_speed, oSolid); //use oSolid so all solid objects (oIcePlatform, oIceBlock) block the player

if(place_meeting(x,y+1,oSolid)){ //if Pagos is on the ground
	if(keyboard_check_pressed(vk_up)){ //and the 'up' arrow key is pressed
		y_speed = -17.5; //make Pagos jump by setting her y_speed to a negative value
	}else{ //otherwise, if Pagos is on the ground but not jumping
		y_speed = 0; //set her y_speed to 0 se she doesn't fall through the ground
	}
}



if keyboard_check(vk_right) {
	image_xscale=1; //flip Pagos's sprite so she faces right
}else if keyboard_check(vk_left){
	image_xscale=-1; //reset her Pagos so she faces left
}

// check if player reached the goal
if (instance_exists(oGoal) && point_distance(x, y, oGoal.x, oGoal.y) < 48) {
	room_goto_next();
}

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
