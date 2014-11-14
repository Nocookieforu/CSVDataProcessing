import java.io.BufferedReader;  
import java.io.FileNotFoundException;  
import java.io.FileReader;  
import java.io.IOException;  


/* Sample data
millis, date, time, x, y, z
6938459, 10/11/2014,"  23:55:28""",50,-6,57
6938519, 10/11/2014,"  23:55:28""",49,-6,57
6938579, 10/11/2014,"  23:55:28""",50,-7,57
6938638, 10/11/2014,"  23:55:28""",50,-6,58
6938699, 10/11/2014,"  23:55:28""",50,-6,57
6938760, 10/11/2014,"  23:55:28""",50,-6,57
6938818, 10/11/2014,"  23:55:29""",49,-6,57
6938880, 10/11/2014,"  23:55:29""",46,-10,54
*/

/** 
 * Based on a reader from Nagesh Chauhan 
 *  http://www.beingjavaguys.com/2013/09/read-and-parse-csv-file-in-java.html
 */
public class ReadCsv {  
  
  private BufferedReader br;
  String nextLine;
  
  public ReadCsv(String filename) {
    try {  

      br = new BufferedReader(new FileReader(filename));  
      /*
      while ( (line = br.readLine ()) != null) { 
        println(line);
      }
      */
      nextLine = br.readLine();
    } 
    catch (FileNotFoundException e) {  
      e.printStackTrace();
      println("File not found");
    }
    catch (IOException e) {
      e.printStackTrace();
      println("Line read error");
    }
  }
  
  public boolean hasNextLine() {
    return nextLine != null;
  }
  
  public String nextLine() {
    String output = nextLine;
    try {
      nextLine = br.readLine();
      
    }catch (IOException e) {  
      e.printStackTrace();
      println("IO Exception");
    } 
    return output;
  }
  
  public void end() {
   if (br != null) {  
      try {  
        br.close();
      } 
      catch (IOException e) {  
        e.printStackTrace();
      }
    }
  } 
}

