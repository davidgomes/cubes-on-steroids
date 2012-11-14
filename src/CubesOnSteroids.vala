using GL;
using SDL;

public class CubeRunner {

    public  unowned SDL.Screen screen;
    private const int DELAY = 10;
    private const int SCREEN_WIDTH = 800;
    private const int SCREEN_HEIGHT = 600;
    private const int SCREEN_BPP = 32;
    public bool done;

    State current_state;

    private void run () {
        init_video ();
        current_state = new PlayState (this);

        while (!done) {
            current_state.update ();
            current_state.draw ();
            SDL.Timer.delay (DELAY);
        }
    }

    private void init_video () {
        uint32 video_flags = SurfaceFlag.SWSURFACE | SurfaceFlag.OPENGL;
        screen = Screen.set_video_mode (SCREEN_WIDTH, SCREEN_HEIGHT,  SCREEN_BPP, video_flags);
        if (screen == null) stderr.printf ("Could not set video mode.\n");

        glClearColor (0.0f, 0.0f, 0.0f, 1.0f);
        glMatrixMode (GL_PROJECTION);
        glLoadIdentity ();
        glFrustum (-2.0f, 2.0f, -2.0f, 2.0f, 1.0f, 300.0f);
        glMatrixMode (GL_MODELVIEW);
        glEnable (GL_DEPTH_TEST);
        glEnable (GL_TEXTURE_2D);

        SDL.WindowManager.set_caption ("Cubes on Steroids", "Cubes on Steroids");
    }

    public static int main (string[] args) {
        SDL.init (InitFlag.VIDEO);

        var main = new CubeRunner ();
        main.run ();

        SDL.quit ();

        return 0;
    }
}