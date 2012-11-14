all:
	#valac --vapidir=./vapi/ --pkg gl --pkg sdl --pkg gio-2.0 --pkg sdl-image --pkg sdl-ttf -X -lSDL_image -X -lSDL_ttf -X -lm --Xcc=-I/usr/include/SDL -o spacecube SpaceCube.vala State.vala PlayState.vala Cube.vala Player.vala Font.vala
	valac --vapidir=./vapi/ --pkg gl --pkg sdl --pkg gio-2.0 -X -lm --Xcc=-I/usr/include/SDL -o cubes-on-steroids src/CubesOnSteroids.vala src/State.vala src/PlayState.vala src/Cube.vala src/Player.vala

# TODO Find a way to have a different Makefile because on Windows, -X lopengl32 is necessary
