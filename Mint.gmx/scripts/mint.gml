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
#define mint_save_room
///mint_save_room()

mint_regenerate_arrays();
var name = string(current_year);
name += "-";
if (current_month < 10) name += "0";
name += string(current_month);
name += "-";
if (current_day < 10) name += "0";
name += string(current_day);
name += "-";
if (current_hour < 10) name += "0";
name += string(current_hour);
name += "-";
if (current_minute < 10) name += "0";
name += string(current_minute);
name += "-";
if (current_second < 10) name += "0";
name += string(current_second);

var nl = chr(13) + chr(10);

var roomStr = "<!--This Document is generated by Mint, if you edit it by hand then you do so at your own risk!-->" + nl;
roomStr += "<room>" + nl;

//Room settings
roomStr += "  <caption></caption>" + nl;
roomStr += "  <width>" + string(roomWidth) + "</width>" + nl;
roomStr += "  <height>" + string(roomHeight) + "</height>" + nl;
roomStr += "  <vsnap>16</vsnap>" + nl;
roomStr += "  <vsnap>16</vsnap>" + nl;
roomStr += "  <isometric>0</isometric>" + nl;
roomStr += "  <speed>" + string(roomSpeed) + "</speed>" + nl;
roomStr += "  <persistent>0</persistent>" + nl;
if (backgroundColor != noone)
{
    roomStr += "  <colour>" + string(backgroundColor) + "</colour>" + nl;
    roomStr += "  <showcolour>-1</showcolour>" + nl;
}
else
{
    roomStr += "  <colour>0</colour>" + nl;
    roomStr += "  <showcolour>0</showcolour>" + nl;
}
roomStr += "  <code></code>" + nl;
roomStr += "  <enableViews>-1</enableViews>" + nl;
roomStr += "  <clearViewBackground>-1</clearViewBackground>" + nl;
roomStr += "  <clearDisplayBuffer>-1</clearDisplayBuffer>" + nl;

//Editor settings
roomStr += "  <makerSettings>" + nl;
roomStr += "    <isSet>0</isSet>" + nl;
roomStr += "    <w>10616993</w>" + nl;
roomStr += "    <h>10748067</h>" + nl;
roomStr += "    <showGrid>0</showGrid>" + nl;
roomStr += "    <showObjects>0</showObjects>" + nl;
roomStr += "    <showTiles>0</showTiles>" + nl;
roomStr += "    <showBackgrounds>0</showBackgrounds>" + nl;
roomStr += "    <showForegrounds>0</showForegrounds>" + nl;
roomStr += "    <showViews>0</showViews>" + nl;
roomStr += "    <deleteUnderlyingObj>0</deleteUnderlyingObj>" + nl;
roomStr += "    <deleteUnderlyingTiles>0</deleteUnderlyingTiles>" + nl;
roomStr += "    <page>11731122</page>" + nl;
roomStr += "    <xoffset>10879141</xoffset>" + nl;
roomStr += "    <yoffset>11010215</yoffset>" + nl;
roomStr += "  </makerSettings>" + nl;

//Backgrounds
roomStr += "  <backgrounds>" + nl;
for(var i = 0; i < 8; i++)
{
    var bg = backgrounds[i];
    if (bg[? "index"] >= 0)
        var bgName = background_get_name(bg[? "index"]);
    else
        var bgName = "";
    roomStr += 
    "    <background " +
    'visible="' + string(lerp(0, -1, bg[? "visible"])) + '" ' +
    'foreground="' + string(lerp(0, -1, bg[? "foreground"])) + '" ' +
    'name="' + bgName + '" ' +
    'x="' + string(bg[? "x"]) + '" ' +
    'y="' + string(bg[? "y"]) + '" ' +
    'htiled="' + string(lerp(0, -1, bg[? "htiled"])) + '" ' +
    'vtiled="' + string(lerp(0, -1, bg[? "vtiled"])) + '" ' +
    'hspeed="' + string(bg[? "hspeed"]) + '" ' +
    'vspeed="' + string(bg[? "vspeed"]) + '" ' +
    'stretch="' + string(lerp(0, -1, bg[? "stretch"])) + '"' +
    "/>" + nl;
}
roomStr += "  </backgrounds>" + nl;

//Views
roomStr += "  <views>" + nl;
roomStr += 
'    <view visible="-1" objName="&lt;undefined&gt;" xview="0" yview="0" wview="800" hview="608" xport="0" yport="0" wport="800" hport="608" hborder="400" vborder="304" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
    <view visible="0" objName="&lt;undefined&gt;" xview="0" yview="0" wview="640" hview="480" xport="0" yport="0" wport="640" hport="480" hborder="32" vborder="32" hspeed="-1" vspeed="-1"/>
';
roomStr += "  </views>" + nl;

//Instances
roomStr += "  <instances>" + nl;
for(var i = 0; i < array_height_2d(instances); i++)
{
    var instName = "inst_";
    repeat(16) instName += choose("1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F");
    
    roomStr += "    <instance ";
    
    roomStr += 'objName="' + object_get_name(instances[i, 0]) + '" ';
    roomStr += 'x="' + string(instances[i, 1]) + '" ';
    roomStr += 'y="' + string(instances[i, 2]) + '" ';
    roomStr += 'name="inst_' + instName + '" ';
    roomStr += 'locked="0" ';
    roomStr += 'code="" ';
    roomStr += 'scaleX="' + string(instances[i, 3]) + '" ';
    roomStr += 'scaleY="' + string(instances[i, 4]) + '" ';
    roomStr += 'colour="' + string(instances[i, 5]) + '" ';
    roomStr += 'rotation="' + string(instances[i, 6]) + '" ';
    
    roomStr += "/>" + nl;
}
roomStr += "  </instances>" + nl;

//Tiles
roomStr += "  <tiles>" + nl;
for(var i = 0; i < array_height_2d(tiles); i++)
{
    var instName = "inst_";
    repeat(16) instName += choose("1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F");

    roomStr += "    <tile ";
    
    roomStr += 'bgName="' + background_get_name(tiles[i, 0]) + '" ';
    roomStr += 'x="' + string(tiles[i, 1]) + '" ';
    roomStr += 'y="' + string(tiles[i, 2]) + '" ';
    roomStr += 'w="' + string(tiles[i, 3]) + '" ';
    roomStr += 'h="' + string(tiles[i, 4]) + '" ';
    roomStr += 'xo="' + string(tiles[i, 5]) + '" ';
    roomStr += 'yo="' + string(tiles[i, 6]) + '" ';
    roomStr += 'id="' + string(10000000 + i) + '" ';    
    roomStr += 'name="tile_' + instName + '" ';
    roomStr += 'depth="' + string(tiles[i, 7]) + '" ';
    roomStr += 'locked="0" ';
    roomStr += 'colour="' + string(tiles[i, 8]) + '" ';
    roomStr += 'scaleX="' + string(tiles[i, 9]) + '" ';
    roomStr += 'scaleY="' + string(tiles[i, 10]) + '" ';
        
    roomStr += "/>" + nl;
}
roomStr += "  </tiles>" + nl;

//Physics
roomStr += "  <PhysicsWorld>0</PhysicsWorld>" + nl;
roomStr += "  <PhysicsWorldTop>0</PhysicsWorldTop>" + nl;
roomStr += "  <PhysicsWorldLeft>0</PhysicsWorldLeft>" + nl;
roomStr += "  <PhysicsWorldRight>1024</PhysicsWorldRight>" + nl;
roomStr += "  <PhysicsWorldBottom>768</PhysicsWorldBottom>" + nl;
roomStr += "  <PhysicsWorldGravityX>0</PhysicsWorldGravityX>" + nl;
roomStr += "  <PhysicsWorldGravityY>10</PhysicsWorldGravityY>" + nl;
roomStr += "  <PhysicsWorldPixToMeters>0.100000001490116</PhysicsWorldPixToMeters>" + nl;

roomStr += "</room>" + nl;

var file = file_text_open_write(name + ".room.gmx");
file_text_write_string(file, roomStr);
file_text_close(file);
