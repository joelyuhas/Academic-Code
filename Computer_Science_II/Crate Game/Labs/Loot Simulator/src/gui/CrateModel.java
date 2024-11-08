package gui;

import Helper.Crate;
import Helper.Player;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;
import java.util.Scanner;

/**
 * Created by Joel on 12/23/2015.
 */
public class CrateModel {

    private ArrayList<Crate> allCrates = new ArrayList<Crate>();
    private Player player = new Player(0);

    public CrateModel(String fileName) throws IOException {
        File file = new File(fileName);
        Scanner in = new Scanner(file);

        String name;
        int amount;
        int allows;
        int probability;
        double cost;

        String s;
        while (in.hasNext()) {
            name = in.next();
            amount = Integer.parseInt(in.next());
            allows = Integer.parseInt(in.next());
            probability = (Integer.parseInt(in.next()));
            cost = Double.parseDouble(in.next());

            Crate crate = new Crate(name,amount,allows,probability,cost);
            allCrates.add(crate);
        }




        /**
        System.out.println("");
        System.out.println("invetoring");
        System.out.println(player.toString());
        openCrate(0);
        System.out.println(player.toString());
        openCrate(0);
        System.out.println(player.toString());
         */
    }



    public void openCrate(int i){
        boolean didit = true;

        try {
            Crate openCrate = player.getCrate(i);
            player.invRemove(i);
            int numberGiven = openCrate.getAmount();


            //4x likely to get same package in first secton
            while (didit){
                for (Crate c : allCrates) {

                    Random rand = new Random();
                    int n = rand.nextInt(c.getProb()) + 1;

                    if(c.getCost() > openCrate.getCost()) {
                        if (c.equals(openCrate)) {
                            if (n == 1 || n == 2 || n == 3 || n == 4 && didit) {
                                didit = false;
                                numberGiven--;
                                player.invAdd(c);
                            }
                        } else {
                            if (n == 1 && didit) {
                                didit = false;
                                numberGiven--;
                                player.invAdd(c);
                            }
                        }
                    }
                    else{
                        if(didit){
                            numberGiven--;
                            didit = false;
                            player.invAdd(c);
                        }

                    }

                }
            }

            int nextPossible = 50;
            //
            while (numberGiven > 0) {
                didit = true;
                while (didit){
                    for (Crate c : allCrates) {




                        Random rand = new Random();
                        int n = rand.nextInt(c.getProb()) + 1;
                        int m = rand.nextInt(100) + 1;

                        if (n == 1 && didit) {


                            if(m > nextPossible){
                                didit = false;
                                numberGiven--;
                                player.invAdd(c);
                                nextPossible = nextPossible + nextPossible/2;
                            }
                            else{
                                didit = false;
                                numberGiven--;

                            }

                        } else {

                        }
                    }
                }


            }


        }
        catch (Exception e){
            System.out.println("no");
        }




    }

    public Player getPlayer(){
        return player;
    }

    public ArrayList<Crate> getCrates(){
        return allCrates;
    }
}
