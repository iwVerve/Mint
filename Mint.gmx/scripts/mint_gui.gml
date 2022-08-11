#define mint_gui
///mint_gui()
exit;

#define mint_draw_gui_elements
///mint_draw_gui_elements()

for(var i = 0; i < array_length_1d(buttons); i++)
{
    var _button = buttons[i];
    if (!_button[? "visible"]) continue;
    
    var _ox = mint_get_button_offset(_button[? "anchor"], true);
    var _oy = mint_get_button_offset(_button[? "anchor"], false);
    
    if (hoveredButton == _button)
        draw_set_color(colorButtonHover);
    else
        draw_set_color(colorButton);
    mint_draw_rounded_rectangle(_button[? "x"] + _ox, _button[? "y"] + _oy, _button[? "x"] + _button[? "width"] - 1 + _ox, _button[? "y"] + _button[? "height"] - 1 + _oy, _button[? "radius"]);
    
    if (_button[? "sprite"] > -1)
    {
        var _sprite = _button[? "sprite"];
        var _image = _button[? "image"];
        var _width = min(32, sprite_get_width(_sprite));
        var _height = min(32, sprite_get_height(_sprite));
        var _xscale = _width / sprite_get_width(_sprite);
        var _yscale = _height / sprite_get_height(_sprite);
        var _x = _button[? "x"] + _button[? "width"] / 2 + _ox - _width/2 + _xscale * sprite_get_xoffset(_sprite);
        var _y = _button[? "y"] + _button[? "height"] / 2 + _oy - _height/2 + _yscale * sprite_get_yoffset(_sprite);
        var _angle = 0;
        var _blend = c_white;
        var _alpha = 1;
        draw_sprite_ext(_sprite, _image, _x, _y, _xscale, _yscale, _angle, _blend, _alpha);
    }
}

draw_set_font(fEditor);
for(var i = 0; i < array_length_1d(textboxes); i++)
{
    var _textbox = textboxes[i];
    if (!_textbox[? "visible"]) continue;
    
    var _ox = mint_get_button_offset(_textbox[? "anchor"], true);
    var _oy = mint_get_button_offset(_textbox[? "anchor"], false);
    
    if (hoveredTextbox == _textbox || selectedTextbox == _textbox)
        draw_set_color(colorTextboxHover);
    else
        draw_set_color(colorTextbox);
    mint_draw_rounded_rectangle(_textbox[? "x"] + _ox, _textbox[? "y"] + _oy, _textbox[? "x"] + _textbox[? "width"] - 1 + _ox, _textbox[? "y"] + _textbox[? "height"] - 1 + _oy, _textbox[? "radius"]);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_color(c_black);
    draw_text(_textbox[? "x"] + _ox + 4, _textbox[? "y"] + _oy + _textbox[? "height"] / 2, string(_textbox[? "value"]));
    if (selectedTextbox == _textbox && textboxTimer < 20)
    {
        draw_text(_textbox[? "x"] + _ox + 1 + string_width(string(_textbox[? "value"])), _textbox[? "y"] + _oy + _textbox[? "height"] / 2, "|");
    }
}

#define mint_highlight_rectangle
///mint_highlight_rectangle(x1, y1, x2, y2, alpha);

var x1 = (argument0 - view_xview) * zoom;
var y1 = (argument1 - view_yview) * zoom;
var x2 = (argument2 - view_xview) * zoom;
var y2 = (argument3 - view_yview) * zoom;

draw_set_alpha(argument4);
    draw_set_color(c_white);
    draw_rectangle(x1, y1, x2, y2, true);
    draw_set_color(c_black);
    draw_rectangle(x1 + 1, y1 + 1, x2 - 1, y2 - 1, true);
draw_set_alpha(1);

#define mint_draw_tooltip
///mint_draw_tooltip()

if (tooltip != "")
{
    var xx = mouse_window_x, yy = mouse_window_y, maxw = 160;
    var mox = 8, moy = 24, mi = 4;
    var dirX = 1, dirY = 1;
    draw_set_font(font);
                            
    
    var tw = string_width_ext(tooltip, -1, maxw) + 8, th = string_height_ext(tooltip, -1, maxw) + 8;
    
    draw_set_halign(fa_left);
    if (tw + mi + mox > sw - xx)
    {
        dirX = -1;
        draw_set_halign(fa_right);
    }
    draw_set_valign(fa_top);
    if (th + mi + moy > sh - yy)
    {
        dirY = -1;
        draw_set_valign(fa_bottom);
    }
    
    xx += dirX * mox;
    yy += dirY * moy;
    draw_set_color(c_white);
    draw_rectangle(xx, yy, xx + dirX * (tw - 1), yy + dirY * (th - 1), false);
    draw_set_color(c_black);
    draw_rectangle(xx, yy, xx + dirX * (tw - 1), yy + dirY * (th - 1), true);
    draw_text_ext(xx + dirX * mi, yy + dirY * mi, tooltip, -1, maxw);
}

#define mint_draw_rounded_rectangle
///mint_draw_rounded_rectangle(x1, y1, x2, y2, radius, [color])

var x1 = argument[0];
var y1 = argument[1];
var x2 = argument[2];
var y2 = argument[3];
var rad = argument[4];
if (argument_count >= 6)
{
    draw_set_color(argument[5]);
}

draw_rectangle(x1+rad, y1, x2-rad, y2, false);
draw_rectangle(x1, y1+rad, x2, y2-rad, false);
draw_circle(x1+rad-1, y1+rad-1, rad, false);
draw_circle(x2-rad, y1+rad-1, rad, false);
draw_circle(x1+rad-1, y2-rad, rad, false);
draw_circle(x2-rad, y2-rad, rad, false);

#define mint_add_button
///mint_add_button(x, y, anchor, width, height, radius, sprite, image, callback, [callback arg], [visible])

var _index = array_length_1d(buttons);
var _button = ds_map_create();

_button[? "x"] = argument[0];
_button[? "y"] = argument[1];
_button[? "anchor"] = argument[2];
_button[? "width"] = argument[3];
_button[? "height"] = argument[4];
_button[? "radius"] = argument[5];
_button[? "sprite"] = argument[6];
_button[? "image"] = argument[7];
_button[? "callback"] = argument[8];
_button[? "callback arg"] = undefined;
if (argument_count >= 10)
{
    _button[? "callback arg"] = argument[9];
}
_button[? "visible"] = true;
if (argument_count >= 11)
{
    _button[? "visible"] = argument[10];
}

buttons[_index] = _button;

return _button;

#define mint_get_button_offset
///mint_get_button_offset(anchor, x)
var ox = 0, oy = 0;
switch(argument0)
{
    case "tl":
        break;
    case "l":
        oy = tlm;
        break;
    case "t":
        ox = lm;
        break;
    case "b":
        break;
    case "r":
        break;
}
if (argument1)
{
    return ox;
}
return oy;

#define mint_get_instance_tooltip
///mint_get_instance_tooltip(id)

var inst = id;
if (argument_count >= 1)
{
    inst = argument[0];
}
var tooltip = "";

with(inst)
{
    tooltip = object_get_name(object);
    if (array_height_2d(code) > 0)
    {
        tooltip += "#";
        for (var i = 0; i < array_height_2d(code); i++)
        {
            var value = code[i, 1];
            if (is_string(value))
            {
                value = '"' + value + '"';
            }
            else
            {
                value = string(value);
            }
            tooltip += "#" + string(code[i, 0]) + " = " + value;
        }
    }
}

return tooltip;

#define mint_draw_scale_handles
///mint_draw_scale_handles()

for(var i = 0; i < 8; i++)
{
    var r = 4 / zoom;
    var xx = scaleHandles[i, 0];
    var yy = scaleHandles[i, 1];
    mint_highlight_rectangle(xx-r, yy-r, xx+r, yy+r, 1);
}

#define mint_get_scale_handles
///mint_get_scale_handles()

var xx, yy, xDir, yDir, r = 4 / zoom;
for(var i = 0; i < 8; i++)
{
    switch(i)
    {
        case 3:
        case 4:
        case 5:
            xx = selectionLeft - r; xDir = -1; break;
        case 2:
        case 6:
            xx = mean(selectionLeft, selectionRight); xDir = 0; break;
        case 0:
        case 1:
        case 7: 
            xx = selectionRight + r + 1; xDir = 1; break;
    }
    switch(i)
    {
        case 1:
        case 2:
        case 3:
            yy = selectionTop - r; yDir = -1; break;
        case 0:
        case 4:
            yy = mean(selectionTop, selectionBottom); yDir = 0; break;
        case 5:
        case 6:
        case 7:
            yy = selectionBottom + r + 1; yDir = 1; break;
    }
    scaleHandles[i, 0] = xx;
    scaleHandles[i, 1] = yy;
    scaleHandles[i, 2] = xDir;
    scaleHandles[i, 3] = yDir;
}

#define mint_check_for_scale_handle
///mint_check_for_scale_handle(x, y)

var r = 4 / zoom;
for(var i = 0; i < 8; i++)
{
    if (mint_in_range(argument0, scaleHandles[i, 0] - r, scaleHandles[i, 0] + r) && mint_in_range(argument1, scaleHandles[i, 1] - r, scaleHandles[i, 1] + r))
    {
        var a;
        a[0] = scaleHandles[i, 2];
        a[1] = scaleHandles[i, 3];
        return a;
    }
}
return noone;

#define mint_add_textbox
///mint_add_textbox(x, y, anchor, width, height, radius, value, numeric, update, finish, [update arg], [finish arg], [visible])

var _index = array_length_1d(textboxes);
var _textbox = ds_map_create();

_textbox[? "x"] = argument[0];
_textbox[? "y"] = argument[1];
_textbox[? "anchor"] = argument[2];
_textbox[? "width"] = argument[3];
_textbox[? "height"] = argument[4];
_textbox[? "radius"] = argument[5];
_textbox[? "value"] = argument[6];
_textbox[? "numeric"] = argument[7]
_textbox[? "update"] = argument[8];
_textbox[? "finish"] = argument[9];
_textbox[? "update arg"] = undefined;
if (argument_count >= 11)
{
    _textbox[? "update arg"] = argument[10];
}
_textbox[? "finish arg"] = undefined;
if (argument_count >= 12)
{
    _textbox[? "finish arg"] = argument[11];
}
_textbox[? "visible"] = true;
if (argument_count >= 13)
{
    _textbox[? "visible"] = argument[12];
}

textboxes[_index] = _textbox;

return _textbox;
#define mint_add_gui_elements
///mint_add_gui_elements()

mint_add_button(6, 6, "tl", 88, 30, 6, sprMintIcon, 0, print, "Hello");
mint_add_button(98, 6, "tl", 88, 30, 6, sprMintIcon, 1, print, "Hello");
mint_add_button(6, 40, "tl", 88, 30, 6, sprMintIcon, 2, print, "Hello");
mint_add_button(98, 40, "tl", 88, 30, 6, sprMintIcon, 3, print, "Hello");
mint_add_button(6, 74, "tl", 88, 30, 6, sprMintIcon, 4, print, "Hello");
mint_add_button(98, 74, "tl", 88, 30, 6, sprMintIcon, 5, print, "Hello");

for(var i = 0; i < 4; i++)
{
    mint_add_button(6 + 46 * i, 6, "l", 42, 42, 6, sprMiku+i, 0, print, "Hello");
}

mint_add_textbox(4, 6, "t", 32, 20, 6, snapX, true, mint_callback_update_snap, mint_callback_finish_snap, true, true);
mint_add_textbox(40, 6, "t", 32, 20, 6, snapY, true, mint_callback_update_snap, mint_callback_finish_snap, false, false);