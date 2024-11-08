
import gui.LootGUI;
import javafx.application.Application;

import java.io.FileNotFoundException;

/**
 * Main program that recives the filename from the command line
 * Created by Joel on 11/3/2015.
 */
public class Play{
    public static void main( String[] args ) throws FileNotFoundException {
        String fileName = null;
        switch ( args.length ) {
            case 0:
                // Read the file name from the user on standard input
                break;
            case 1:
                fileName = args[ 0 ];
                break;
            default:
                System.err.println( "Usage: java LittleChess [config-file]" );
                System.exit( 1 );
        }

        Application.launch( LootGUI.class, fileName );
    }
}