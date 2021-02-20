import turtle.Turtle;
import turtle.StdDraw;
/**
 * Created by Joel on 8/30/2015.
 */
public class HTree {

    public static final int MAX_SEGMENT_LENGTH = 1024;

    public static Turtle init(int length, int depth){
        Turtle a = new Turtle(0,0,0);
        a.setWorldCoordinates (-length * 2, -length * 2, length * 2, length * 2);
        a.setCanvasTitle("H-Tree, depth: " + Integer.toString(depth));
        return a;
    }

    public static void drawHTree(Turtle t, int length, int depth){
        if (depth > 0){
            t.goForward(length / 2);
            t.turnLeft(90);
            t.goForward(length / 2);
            t.turnRight(90);

            drawHTree(t, length / 2, depth - 1);

            t.turnRight(90);
            t.goForward(length);
            t.turnLeft(90);

            drawHTree(t, length / 2, depth - 1);

            t.turnLeft(90);
            t.goForward(length / 2);
            t.turnLeft(90);
            t.goForward(length);
            t.turnRight(90);
            t.goForward(length / 2);
            t.turnRight(90);

            drawHTree(t, length / 2, depth - 1);

            t.turnRight(90);
            t.goForward(length);
            t.turnLeft(90);

            drawHTree(t, length / 2, depth - 1);

            t.turnLeft(90);
            t.goForward(length / 2);
            t.turnRight(90);
            t.goForward(length / 2);


        }
    }

    public static void main(String[] args){

        if (args.length < 2){
            System.out.println("no good");
            return;
        }
        int depth = Integer.parseInt(args[1]);
        if (depth < 0){
            System.out.println("the depth must be greater than or equal to 0");
            return;

        }

        drawHTree(init(MAX_SEGMENT_LENGTH, depth),MAX_SEGMENT_LENGTH,depth);



    }
}
