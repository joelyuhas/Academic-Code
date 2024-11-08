package poly.stu;
import com.sun.org.apache.xpath.internal.SourceTree;
import poly.stu.PolyEval;

import java.lang.reflect.Array;
import java.util.ArrayList;

/**
 * Created by Joel on 8/30/2015.
 */
public class PolyRoot {

    public static final double EPSILON = 0.0001;
    public static final double INITIAL_GUESS = 0.1;
    public static final int MAX_ITERATIONS = 100;

    public static double computeRoot(ArrayList<Integer> poly) {
        double x3 = 0;
        if (PolyEval.isZero(poly)== false) {
            x3 = PolyRoot.newtonsMethod(poly, INITIAL_GUESS, 0);
            return x3;
            }
        return x3;
        }

    public static double newtonsMethod(ArrayList<Integer> poly, double x0, int iter){
        int newIter = iter + 1;
        double x1 = 0;
        double xFinal = 0;

        if(MAX_ITERATIONS > iter) {
            double fx = PolyEval.evaluate(poly, x0);
            double dfx = PolyEval.evaluate(PolyDerive.computeDerivative(poly), x0);
            x1 = x0 - (fx / dfx);

            if (Math.abs(Math.abs(x1) - Math.abs(x0)) > EPSILON) {
                xFinal = PolyRoot.newtonsMethod(poly, x1, newIter);
                return xFinal;
            }

        }
        return x0;
    }
}
