#define mint_util
///mint_util()
exit;

#define mint_resize_window
///mint_resize_window(stretch app surf, [width], [height], [x], [y])

if (argument_count >= 3)
{
    var w = argument[1], h = argument[2];
    window_set_size(w, h);
    if (argument_count >= 5)
    {
        window_set_position(argument[3], argument[4]);
    }
}
else
{
    var w = window_get_width(), h = window_get_height();
    view_wview = w / zoom; view_wport = w;
    view_hview = h / zoom; view_hport = h;
}

if (argument[0])
{
    surface_resize(application_surface, w, h);
    display_set_gui_size(w, h);
}
else
{
    surface_resize(application_surface, wview, hview);
    display_set_gui_size(wview, hview);
}

#define mint_destroy_everything_else
///mint_destroy_everything_else()

with(all)
{
    if (id != other.id)
    {
        instance_destroy();
    }
}

#define mint_in_range
///mint_in_range(a, min, max)

return argument0 == median(argument0, argument1, argument2);

#define mint_mouse_update
///mint_mouse_update(init)

if (argument_count >= 1)
{
    if (argument[0])
    {
        //Init
        globalvar mouse_room_x, mouse_room_y, mouse_window_x, mouse_window_y, mouse_room_x_prev, mouse_room_y_prev, mouse_window_x_prev, mouse_window_y_prev;
        mouse_room_x = mouse_x;
        mouse_room_y = mouse_y;
        mouse_window_x = window_mouse_get_x();
        mouse_window_y = window_mouse_get_y();
        mouse_room_x_prev = mouse_room_x;
        mouse_room_y_prev = mouse_room_y;
        mouse_window_x_prev = mouse_window_x;
        mouse_window_y_prev = mouse_window_y;
        exit;
    }
}

//Update
mouse_room_x_prev = mouse_room_x;
mouse_room_y_prev = mouse_room_y;
mouse_window_x_prev = mouse_window_x;
mouse_window_y_prev = mouse_window_y;
mouse_room_x = mouse_x;
mouse_room_y = mouse_y;
mouse_window_x = window_mouse_get_x();
mouse_window_y = window_mouse_get_y();

#define mint_mouse_in_room_view
///mint_mouse_in_room_view()

return (mint_in_range(mouse_window_x, lm+1, sw-rm-1) && mint_in_range(mouse_window_y, tm+1, sh-bm-1));

#define mint_check_constant
///mint_check_constant(constant)

switch(argument0)
{
    case "true": return true;
    case "false": return false;
    default: return real(argument0);
}

#define mint_update_selection_boundary
///mint_update_selection_boundary()

for (var i = 0; i < ds_list_size(selectedInstances); i++)
{
    var inst = selectedInstances[| i];
    if (i == 0)
    {
        selectionLeft = inst.bbox_left;
        selectionTop = inst.bbox_top;
        selectionRight = inst.bbox_right;
        selectionBottom = inst.bbox_bottom;
    }
    else
    {
        selectionLeft = min(inst.bbox_left, selectionLeft);
        selectionTop = min(inst.bbox_top, selectionTop);
        selectionRight = max(inst.bbox_right, selectionRight);
        selectionBottom = max(inst.bbox_bottom, selectionBottom);
    }
}

mint_get_scale_handles();

#define mint_get_window_position
///mint_get_window_position(playtest)

if (argument0)
{
    windowPlaytestX = window_get_x();
    windowPlaytestY = window_get_y();
    windowPlaytestWidth = window_get_width();
    windowPlaytestHeight = window_get_height();
}
else
{
    windowEditorX = window_get_x();
    windowEditorY = window_get_y();
    windowEditorWidth = window_get_width();
    windowEditorHeight = window_get_height();
}