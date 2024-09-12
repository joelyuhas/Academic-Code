package Helper;

/**
 * Created by Joel on 12/23/2015.
 */
public class Crate {
    private String name;
    private int amount;
    private int allows;
    private int prob;
    private double cost;

    public Crate(String name, int amount,int allows, int prob, double cost ){
        this.name = name;
        this.amount = amount;
        this.allows = allows;
        this.prob = prob;
        this.cost = cost;
    }

    public String getName(){
        return name;
    }
    public int getAmount(){
        return amount;
    }
    public int getAllows(){
        return allows;
    }
    public int getProb(){
        return prob;
    }
    public double getCost(){
        return cost;
    }
    public String toString(){
        String s = "" + name + amount;
        return s;
    }
}
