package gui;


import Helper.Crate;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.*;
import javafx.stage.Stage;


/**
 * LittleChessGUI takes in the information provided by little chess model
 * and initializes and creates a functional GUI using that data
 * Created by Joel on 11/3/2015.
 */
public class LootGUI extends Application {

   //private CrateModel crateModel;

    private CrateModel modelObject;

    private FlowPane center;

    private Pane makeButtonList(){
        Pane pane = new HBox();
        Button btn1 = new Button("NewGame");
        Button btn2 = new Button("Restart");
        Button btn3 = new Button("Hint");
        Button btn4 = new Button("Solve");
        pane.getChildren().add(btn1);
        pane.getChildren().add(btn2);
        pane.getChildren().add(btn3);
        pane.getChildren().add(btn4);

        return pane;
    }

    /**
     * Initializes and creates a lable for the top
     * @return
     */
    private Label makeTop(){
        Label tex = new Label("Good Luck");
        return tex;
    }


    private HBox makeCenter(){
        HBox tex = new HBox();
        /**
        for(Crate c: crateModel.getCrates()){
            System.out.println(c);
            Button b = new Button(c.getName());
            tex.getChildren().add(b);
        }
         */

        int i = 0;
        System.out.println("AFEazsd");
        for(Crate c: modelObject.getPlayer().getInvetory()){

            Button b = new Button(c.getName());
            tex.getChildren().add(b);
            b.setId("" + i);
            b.setOnAction(myHandler);
            i++;
        }
        System.out.println(tex.getChildren().toString());
        return tex;
    }





    /**
     * Initialzies the board using the filename
     * @throws Exception
     */
    public void init() throws Exception {
        super.init();
        Application.Parameters params = super.getParameters();
        String fileName = params.getUnnamed().get(0);
        CrateModel crateModel = new CrateModel(fileName);
        this.modelObject = crateModel;
        modelObject.getPlayer().invAdd(modelObject.getCrates().get(26));

    }


    /**
     * starts and adds all sections together into the GUI
     * @param stage
     */
    public void start( Stage stage ){

        BorderPane border = new BorderPane();


        border.setBottom(this.makeButtonList());
        border.setTop(this.makeTop());

        center = new FlowPane(makeCenter());
        border.setCenter(center);

        stage.setTitle("Solitare Chess");
        stage.setScene(new Scene(border));
        stage.show();
    }


    final EventHandler<ActionEvent> myHandler = new EventHandler<ActionEvent>(){

        public void handle(final ActionEvent event) {

            Object source = event.getSource();
            if (source instanceof Button) { //should always be true in your example
                Button clickedBtn = (Button) source; // that's the button that was clicked
                modelObject.openCrate(0);
                center.getChildren().clear();
                center.getChildren().add(makeCenter());

            }
        }
    };
}
