package poly.stu;
import java.util.ArrayList;

/**
 * Created by jxy8307 on 8/27/15.
 */
public class PolyDerive {

    public static ArrayList<Integer> computeDerivative(ArrayList<Integer> poly) {
        int b = poly.size();
        int total = 0;
        int i = 1;
        ArrayList der = new ArrayList<Integer>();
        if (poly == null || poly.size() == 1) {
            der.add(0);
            return der;
        }
        else {
            for (b = poly.size(); b > 1; b--) {
                int a = poly.get(i);
                total = i * a;
                der.add(total);

                i++;
            }
        }
        return der;

    }
}