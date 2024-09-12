package poly.stu;

import java.util.ArrayList;


/**
 * Created by jxy8307 on 8/27/15.
 */
public class PolyEval {

    public static double evaluate(ArrayList<Integer> poly, double x){
        double b=0;
        int size=poly.size();
        int i=0;
        double fin=0;
        b = poly.size();

        if(b == 0){
            return 0;
        }

        for(b=poly.size();b>0; b--){
            double a = poly.get(i);
            double z = Math.pow(x,i);
            fin = fin + a*z;
            i++;
        }

        return fin;
    }

    public static boolean isZero(ArrayList<Integer> poly){
        boolean a = false;

        if (poly.size() > 1){
            a = false;
        }

        else {
            if (poly == null) {
                a = false;}
                if (poly.get(0) == 0) {
                    a = true;
                }
            }

    return a;
    }

}