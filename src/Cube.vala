using GL;
using SDL;

private class Cube : Object {

    public float x;
    public float y;
    public float z;
    public float size;
    public float x_angle = 0.0f;
    public float y_angle = 0.0f;
    public float z_angle = 0.0f;

    private float vx;
    private float vy;
    private float vz;
    private float speed = 2.0f;

    public Player player;

    public Cube (float _x, float _y, float _z, float _size, Player _player) {
        x = _x;
        y = _y;
        z = _z;
        size = _size;
        player = _player;
    }

    private int new_angle () {
        if (Random.int_range (0, 2) == 0) {
            return 1;
        } else {
            return -1;
        }
    }

    public void update () {
        uchar[] keystates = SDL.Key.get_keys ();

        vz = 3.0f;

        if (keystates[KeySymbol.DOWN] == 1 && player.y > -4000) {
            player.y--;
            vy = speed;
        }
        if (keystates[KeySymbol.UP] == 1 && player.y < 4000) {
            vy = -speed;
            player.y++;
        }

        if (keystates[KeySymbol.LEFT] == 1 && player.x > -4000) {
            player.x--;
            vx = speed;
        }
        if (keystates[KeySymbol.RIGHT] == 1 && player.x < 4000) {
            player.x++;
            vx = -speed;
        }

        /* Horizontal friction */
        if (vx > 0) vx -= 0.1f;
        if (vx < 0) vx += 0.1f;
        if (Math.fabs (vx) < 0.1f) vx = 0.0f;

        /* Vertical friction */
        if (vy > 0) vy -= 0.1f;
        if (vy < 0) vy += 0.1f;
        if (Math.fabs (vy) < 0.1f) vy = 0.0f;

        if (Math.fabs (x_angle) >= 360.0) x_angle = new_angle ();
        if (Math.fabs (y_angle) >= 360.0) y_angle = new_angle ();
        if (Math.fabs (z_angle) >= 360.0) z_angle = new_angle ();

        if (x_angle > 0) {
            x_angle += 5.0f;
        } else {
            x_angle -= 5.0f;
        }

        if (y_angle > 0) {
            y_angle += 5.0f;
        } else {
            y_angle -= 5.0f;
        }

        if (z_angle > 0) {
            z_angle += 5.0f;
        } else {
            z_angle -= 5.0f;
        }
        
        x += vx;
        y += vy;
        z += vz;
    }

    public void draw () {
        glLoadIdentity ();
        glTranslatef (x, y, z);
        glScalef (size, size, size);
        glRotatef (x_angle, 1.0f, 0.0f, 0.0f);
        glRotatef (y_angle, 0.0f, 1.0f, 0.0f);
        glRotatef (z_angle, 0.0f, 0.0f, 1.0f);
        glBegin (GL_QUADS);

        /* Front face */
        glColor3f (1.0f, 0.0f, 0.0f);
        glVertex3f (0.5f, 0.5f, 0.5f);
        glVertex3f (-0.5f, 0.5f, 0.5f);
        glVertex3f (-0.5f, -0.5f, 0.5f);
        glVertex3f (0.5f, -0.5f, 0.5f);

        /* Left face */
        glColor3f (0.0f, 1.0f, 0.0f);
        glVertex3f (-0.5f, 0.5f, 0.5f);
        glVertex3f (-0.5f, -0.5f, 0.5f);
        glVertex3f (-0.5f, -0.5f, -0.5f);
        glVertex3f (-0.5f, 0.5f, -0.5f);

        /* Back face */
        glColor3f (0.0f, 0.0f, 1.0f);
        glVertex3f (0.5f, 0.5f, -0.5f);
        glVertex3f (-0.5f, 0.5f, -0.5f);
        glVertex3f (-0.5f, -0.5f, -0.5f);
        glVertex3f (0.5f, -0.5f, -0.5f);

        /* Right face */
        glColor3f (1.0f, 1.0f, 0.0f);
        glVertex3f (0.5f, 0.5f, 0.5f);
        glVertex3f (0.5f, -0.5f, 0.5f);
        glVertex3f (0.5f, -0.5f, -0.5f);
        glVertex3f (0.5f, 0.5f, -0.5f);

        /* Top face */
        glColor3f (0.0f, 1.0f, 1.0f);
        glVertex3f (0.5f, 0.5f, 0.5f);
        glVertex3f (-0.5f, 0.5f, 0.5f);
        glVertex3f (-0.5f, 0.5f, -0.5f);
        glVertex3f (0.5f, 0.5f, -0.5f);

        /* Bottom face */
        glColor3f (1.0f, 0.0f, 1.0f);
        glVertex3f (0.5f, -0.5f, 0.5f);
        glVertex3f (-0.5f, -0.5f, 0.5f);
        glVertex3f (-0.5f, -0.5f, -0.5f);
        glVertex3f (0.5f, -0.5f, -0.5f);
        glEnd ();
    }
}