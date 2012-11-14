using SDL;
using GL;

private class PlayState : State {

    CubeRunner main;

    private List<Cube> cubes;

    private Player player;

    int max_size = 0;

    public PlayState (CubeRunner _main) {
        main = _main;
        start();
    }

    public override void start () {
        player = new Player ();
    }

    public override void update () {
        Event event;
        Event.poll (out event);

        uchar[] keystates = SDL.Key.get_keys ();

        /* Did player quit? */
        main.done = keystates[KeySymbol.ESCAPE] == 1 || event.type == EventType.QUIT;

        for (int i = 0; i < cubes.length (); i++) {
            Cube current_cube = cubes.nth_data (i);
            current_cube.update ();

            if (current_cube.z  > 5.0f)
                cubes.remove (current_cube);

            if (current_cube.x < current_cube.size && current_cube.x > -current_cube.size && current_cube.y < current_cube.size && current_cube.y > -current_cube.size && current_cube.z < current_cube.size && current_cube.z > -current_cube.size) {
                print ("You lost - " + player.score.to_string () + ".\n");

                try {
                    FileUtils.set_contents ("score.txt", "You lost - " + player.score.to_string () + ".\n");
                } catch (GLib.Error e) {
                    stderr.printf ("Error: %s\n", e.message);
                }

                main.done = true;
            }
        }

        /* Randomly spawn cubes */
        for (int i = 0; i < 1; i++) {
            cubes.append (new Cube (Random.int_range (-100, 100), Random.int_range (-100, 100), -300.0f, (float) Random.double_range (1, max_size + 1), player));
        }

        /* Make game harder as it goes */
        max_size = (int) Math.floor(8.966497462 * Math.pow(10, -3) * player.score - 4.121827411 * Math.pow(10, -2));

        player.score++;
    }

    public override void draw () {
        glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        for (int i = 0; i < cubes.length (); i++)
            cubes.nth_data (i).draw ();

        SDL.GL.swap_buffers ();
    }
}