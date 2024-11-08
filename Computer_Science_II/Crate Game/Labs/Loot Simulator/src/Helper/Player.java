package Helper;

import Helper.Crate;
import gui.CrateModel;

import java.util.ArrayList;

/**
 * Created by Joel on 12/23/2015.
 */
public class Player {
    private ArrayList<Crate> invetory = new ArrayList<Crate>();
    private double money;


    public Player(double money) {
        this.money = money;
    }

    public void invAdd(Crate crate) {
        invetory.add(crate);
    }

    public Crate getCrate(int i) {
        return invetory.get(i);
    }

    public void invRemove(int i) {
        invetory.remove(i);
    }

    public ArrayList<Crate> getInvetory(){
        return invetory;
    }

    public String toString(){
        String s = "" + money;
        for(Crate c: invetory){
            s = s + " " + c.toString();
        }
        return s;
    }

}
