x_speed=0; //reset horizontal speed
y_speed+=grav; //add gravity to y_speed

if keyboard_check(vk_right){ //if the right arrow key is pressed
	x_speed=movement_speed; 
}else if keyboard_check(vk_left){ //otherwise, if the left arrow key is pressed
	x_speed=-movement_speed; //set the horizontal speed to negative heidi's movement_speed, making her move left
}

move_and_collide(x_speed, y_speed, oIcePlatform);

if(place_meeting(x,y+1,oSolid)){ //if Pagos is on the ground
	if(keyboard_check_pressed(vk_up)){ //and the 'up' arrow key is pressed
		y_speed = -20; //make Pagos jump by setting her y_speed to a negative value
	}else{ //otherwise, if Pagos is on the ground but not jumping
		y_speed = 0; //set her y_speed to 0 se she doesn't fall through the ground
	}
}



if keyboard_check(vk_right) {
	image_xscale=1; //flip Pagos's sprite so she faces right
}else if keyboard_check(vk_left){
	image_xscale=-1; //reset her Pagos so she faces left
}

if(place_meeting(x,y,oIcicles)){ //if Pagos collides with the Icicles
	room_restart() //restart the level
}

if (y>room_height or y<0 or x>room_width or x<0){ //if the player is outside of the room
	room_restart();
}
