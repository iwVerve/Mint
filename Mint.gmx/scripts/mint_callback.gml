#define mint_callback
///mint_callback()
exit;

#define mint_callback_update_snap
///mint_callback_update_snap(snap, x)

if argument1 snapX = max(argument0, 1);
else snapY = max(argument0, 1);

#define mint_callback_finish_snap
///mint_callback_finish_snap(textbox, x)

if (argument1)
{
    argument0[? "value"] = snapX;
}
else 
{
    argument0[? "value"] = snapY;
}
#define mint_callback_switch
///mint_callback_switch(button, type)

var b = variable_instance_get(id, argument1);
b = !b;
argument0[? "on"] = b;
variable_instance_set(id, argument1, b);

switch(argument1)
{
    case "showObjects":
    case "showInvisibleObjects":
        with(objMintInstance)
        {
            visible = other.showObjects && (object_get_visible(object) || other.showInvisibleObjects);
        }
        break;
        break;
    case "showTiles":
        with(objMintTile)
        {
            visible = b;
        }
        break;
    case "showBackgrounds":
    case "showForegrounds":
        var f = (argument1 == "showForegrounds");
        for(var i = 0; i < 8; i++)
        {
            var _bg = backgrounds[i];
            if (_bg[? "foreground"] == f)
            {
                background_visible[i] = _bg[? "visible"] && b;
            }
        }
        break;
}

#define mint_callback_select_object
///mint_callback_select_object(button, object)

selectedObject = argument1;

exit; show_debug_message(argument0); //thank you gamemaker