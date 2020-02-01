// javac Monitors.java
// jar cvfm Monitors.jar MANIFEST.MF Monitors.class
import java.awt.GraphicsEnvironment;
import java.awt.GraphicsDevice;
import java.awt.Rectangle;

public class Monitors {

    protected GraphicsDevice[] devices = GraphicsEnvironment.getLocalGraphicsEnvironment().getScreenDevices();
    
    public int getNb() {
      return (int) devices.length;
    }
    
    public int[] getScreen(int num){
      if ( num>=0 &&  num< devices.length) {
        Rectangle bounds = devices[num].getDefaultConfiguration().getBounds();
        int[] S= new int[4];
        S[0]=bounds.width;
        S[1]=bounds.height;
        S[2]=bounds.x;
        S[3]=bounds.y;
        return(S);
      }else{
        int[] S = {};
        return(S);
      }
    }
    
    public int[][] getScreens(){
      int[][] S= new int[devices.length][4];
      for (int i = 0; i < devices.length; i++) {
        Rectangle bounds = devices[i].getDefaultConfiguration().getBounds();
        S[i][0]=bounds.width;
        S[i][1]=bounds.height;
        S[i][2]=bounds.x;
        S[i][3]=bounds.y;
      }
      return(S);
    }
 
    public static void main(String[] args){
      GraphicsEnvironment g = GraphicsEnvironment.getLocalGraphicsEnvironment();
      GraphicsDevice[] devices = g.getScreenDevices();

      for (int i = 0; i < devices.length; i++) {
        Rectangle bounds = devices[i].getDefaultConfiguration().getBounds();
          System.out.println(bounds.width+"x"+bounds.height+"+"+bounds.x+"+"+bounds.y);
//           System.out.println("y:" + bounds.y);
//           System.out.println("width:" + bounds.width);
//           System.out.println("heigth:" + bounds.height);
//           System.out.println("Height:" + devices[i].getDisplayMode().getHeight());
//           System.out.println("Width:" + devices[i].getDisplayMode().getWidth());
//           System.out.println("Height:" + devices[i].getDisplayMode().getHeight());
      }
    }
    
}
