# Mint

Mint is a live room editor for GameMaker Studio 1. It works by providing a set of assets that you import into your own project.

## Missing features

The project is currently very unfinished. It can currently only work with instances -
tiles and backgrounds get shown but there's no way to interact with them, and you can't change room settings or views.
This means the editor is overwhelmingly best suited for making platforming, that then gets polished up in the regular editor.

The editor currently has no support for creation code. This means that when opening a room, all creation code gets scrapped
and there is no way to add any from the editor. There are workarounds planned for this. Instance rotation is also not supported.

The editor is by no means polished - window scaling, for instance, is rather janky when trying to stretch the editor to full screen.
A couple similar quirks probably mean the editor has a certain workflow you might take a while to get used to.

## Setup

The project comes with Mint as part of a blank Verve Engine project. I would advise against using the project itself as an
engine itself, as I will not be keeping this copy of Verve Engine up to date. It is however viable as a way to test out the
editor without having to set it up yourself first.

Before importing the editor into your own project, make a backup of that project. 

To import the editor, you will need to import over all the Mint assets from this project into yours. This includes 3 sprites,
4 scripts (when asked, import them as tabbed scripts), 1 font, and 3 objects. `objMintEditor` should be the first object in your asset tree.
You then need to add a way to start the editor from withing the game, by creating an instance of `objMintEditor`.
In the provided project, this is done in objWorld -> Step -> Game checks -> Very bottom of the code action.

You then need to customize some editor behavior to work with the specific setup of your project. Go to objMintEditor -> Create -> Config.
The only important change here is the ignore array. It holds all objects that the editor should ignore when scanning the room for objects.
The listed examples should give a good example of the nature of objects you probably wish to include.

The other spot to customize is scrMint -> mint_on_playtest_start. Here you can provide basically any code to patch up anything
that happens to go wrong - it's generally quite difficult to predict how the editor will function ahead of time, so this might
take some experimentation. In the provided project, I for example reset the gravity direction, otherwise it wouldn't happen on
its own.

## Usage

Open the game, and start the editor with your implemented method - in the provided project, this is the F8 key.

Arrow keys or the middle mouse button move the camera. The scroll wheel zooms in and out.

Shift + Click to select a region, Ctrl + Click to add or remove from selection, Click and drag to move your selection around.

Left click to place, Right click to remove.

Select objects from the palette on the left. This palette includes all objects in the room, there is currently no way to add more.
You need to place all the objects you'll want to use somewhere in the room ahead of time in the regular room editor.

Enter to start and end a playtest. R to restart the playtest. Both of these are rebindable in objMintEditor's config. Saves don't
function while playtesting. Instead, move the player start around.

## Saving

Ctrl+S saves the project in your game's save folder - %localappdata%\your_project_name\. Import the room file into your project,
and replace the old room.
