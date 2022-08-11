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