
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.File;

/* 
 * Based on a writer from Mykong
 * http://www.mkyong.com/java/how-to-export-data-to-csv-file-java/
 */
public class WriteCSV {

  public WriteCSV() {
    
  }
  
  // Assumes the two input arrays are the same length
  public void generateCsvFile(String sFileName, 
    Object[] first, Object[] second) {
      
    try {
      //Path currentRelativePath = Paths.get(".").toAbsolutePath().normalize().toString();
      String absPath = Paths.get(".").toAbsolutePath().normalize().toString();
      /*
      File dir1 = new File (".");
      File dir2 = new File ("..");
      System.out.println ("Current dir : " + dir1.getCanonicalPath());
      System.out.println ("Parent  dir : " + dir2.getCanonicalPath());
      println(System.getProperty("user.dir"));
      println("File saved at: " + absPath);
      */
      FileWriter writer = new FileWriter(absPath +"/"+ sFileName);

      for (int i = 0; i < first.length; i++) {
        writer.append(first[i].toString() + "," 
                      + second[i].toString() + "\n");
      }
      writer.flush();
      writer.close();
    }
    catch(IOException e)
    {
      e.printStackTrace();
    }
  }
}

