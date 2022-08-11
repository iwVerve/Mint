#define mint
///mint(don't call this script)
exit;

//Config
mint_on_playtest_start()

//Room
mint_get_room()
mint_regenerate_arrays()
mint_room_set_backgrounds()

//Editor
mint_snap(x, snap)
mint_restart_playtest()
mint_get_button_offset(anchor, x)

#define mint_on_playtest_start
///mint_on_playtest_start()

global.grav = 1;

#define mint_get_room
///mint_get_room()

with(all)
{
    var ignored = false;
    for(var i = 0; i < array_length_1d(other.ignore); i++)
    {
        if (object_index == other.ignore[i])
        {
            ignored = true;
            break;
        }
    }
    if (!ignored)
    {
        var index = array_height_2d(other.instances);
        other.instances[index, 0] = object_index;
        other.instances[index, 1] = x;
        other.instances[index, 2] = y;
        other.instances[index, 3] = image_xscale;
        other.instances[index, 4] = image_yscale;
        other.instances[index, 5] = image_blend;
        other.instances[index, 6] = image_angle;
        other.instances[index, 7] = array_create(0);
    }
}
var roomTiles = tile_get_ids();
for(var i = 0; i < array_length_1d(roomTiles); i++)
{
    var tile = roomTiles[i];
    tiles[i, 0] = tile_get_background(tile);
    tiles[i, 1] = tile_get_x(tile);
    tiles[i, 2] = tile_get_y(tile);
    tiles[i, 3] = tile_get_width(tile);
    tiles[i, 4] = tile_get_height(tile);
    tiles[i, 5] = tile_get_left(tile);
    tiles[i, 6] = tile_get_top(tile);
    tiles[i, 7] = tile_get_depth(tile);
    tiles[i, 8] = tile_get_blend(tile);
    tiles[i, 9] = tile_get_xscale(tile);
    tiles[i, 10] = tile_get_yscale(tile);
}

for(var i = 0; i < 8; i++)
{
    var bg = backgrounds[i];
    bg[? "visible"] = background_visible[i];
    bg[? "index"] = background_index[i];
    bg[? "foreground"] = background_foreground[i];
    bg[? "x"] = background_x[i];
    bg[? "y"] = background_y[i];
    bg[? "htiled"] = background_htiled[i];
    bg[? "vtiled"] = background_vtiled[i];
    bg[? "hspeed"] = background_hspeed[i];
    bg[? "vspeed"] = background_vspeed[i];
    bg[? "stretch"] = (background_width[i] == room_width);
}

backgroundColor = noone;
if (background_showcolour)
{
    backgroundColor = background_color;
}

roomWidth = room_width;
roomHeight = room_height;
roomSpeed = room_speed;

room_set_width(editorRoom, room_width);
room_set_height(editorRoom, room_height);
room_set_view_enabled(editorRoom, true);
room_set_view(editorRoom, 0, true, -lm, -tm, sw, sh, 0, 0, sw, sh, 0, 0, 0, 0, -1);

#define mint_regenerate_arrays
///mint_regenerate_arrays()

instances = array_create(0);
with(objMintInstance)
{
    var index = array_height_2d(other.instances);
    other.instances[index, 0] = object;
    other.instances[index, 1] = x;
    other.instances[index, 2] = y;
    other.instances[index, 3] = image_xscale;
    other.instances[index, 4] = image_yscale;
    other.instances[index, 5] = image_blend;
    other.instances[index, 6] = image_angle;
    other.instances[index, 7] = code;
}

tiles = array_create(0);
with(objMintTile)
{
    var index = array_height_2d(other.tiles);
    other.tiles[index, 0] = back;
    other.tiles[index, 1] = x;
    other.tiles[index, 2] = y;
    other.tiles[index, 3] = width;
    other.tiles[index, 4] = height;
    other.tiles[index, 5] = left;
    other.tiles[index, 6] = top;
    other.tiles[index, 7] = depth
    other.tiles[index, 8] = image_blend;
    other.tiles[index, 9] = image_xscale;
    other.tiles[index, 10] = image_yscale;
}

#define mint_snap
///mint_snap(x, snap)

return argument1 * floor(argument0 / argument1);

#define mint_restart_playtest
///mint_restart_playtest()

state = "start playtest";
mint_destroy_everything_else();
room_goto(playtestRoom);

#define mint_room_set_backgrounds
///mint_room_set_backgrounds()
    
for (var i = 0; i < 8; i++)
{
    var bg = backgrounds[i];
    background_visible[i] = bg[? "visible"];
    background_index[i] = bg[? "index"];
    background_foreground[i] = bg[? "foreground"];
    background_x[i] = bg[? "x"];
    background_y[i] = bg[? "y"];
    background_htiled[i] = bg[? "htiled"];
    background_vtiled[i] = bg[? "vtiled"];
    background_hspeed[i] = bg[? "hspeed"];
    background_vspeed[i] = bg[? "vspeed"];
    if (bg[? "stretch"])
    {
        background_xscale[i] = room_width / background_width[i];
        background_yscale[i] = room_height / background_height[i];
    }
}

if (backgroundColor == noone)
{
    background_showcolour = false;
}
else
{
    background_showcolour = true;
    background_color = backgroundColor;
}
