
import java.util.Arrays;
// This is the number of values to average
// Number of data points will be divided by this number
int numToCollapse = 30;
ArrayList<Float> mags;
ArrayList<String> times;

// used for drawing
int xPos = 0;
float min, max;


/*
 * Processing (Java) code .pde
 * This processing sketch opens a CSV file, reads data
 * saved from an accelerometer, processes the data,
 * and creates a simple graph that can be viewed.
 * Author: Nocookieforu
 */
void setup() {
  ReadCsv r = new ReadCsv("data.csv");
  println(r.nextLine());
  
  mags = new ArrayList<Float>();
  times = new ArrayList<String>();
  float[] currentMag = new float[numToCollapse];
  String firstPointTime = "";
  int count = 0;
  
  while (r.hasNextLine()) {
    String[] piece = r.nextLine().split(",");
    
    // Parse strings to floats from back of array
    float mag = 0;
    for (int i = 1; i <= 3; i++) {
      //nums[nums.length-i] = Float.valueOf(piece[piece.length-i]);
      mag += pow(Float.valueOf(piece[piece.length-i]),2);
    }
    if (count == 0) times.add(piece[1] + " " + piece[2].substring(3,piece[2].length()-3));
    currentMag[count] = mag;
    
    count++;
    if (count == numToCollapse) {
      // Don't forget that we squared the magnitudes but
      // didn't take the square root yet.
      mags.add(sqrt(average(currentMag)));
      count = 0;
    }
  }
  
  // Clean up any extra values
  // Only use the part of the array filled with new data
  mags.add(sqrt(average(Arrays.copyOfRange(currentMag, 0, count))));
  
  /* Prints all the values
  for (int i = 0; i < mags.size(); i++) {
    println(times.get(i) + " : " + mags.get(i));
  }
  */
  println("Total num of points: " + mags.size());
  println("Approx original number of points: " + mags.size()*numToCollapse);
  println("Data processing finished");
  
  WriteCSV writer = new WriteCSV();
  writer.generateCsvFile("processedData.csv",times.toArray(),mags.toArray());
  
  // Drawing the graph using simple Processing functions
  size(1000,500);
  background(230);
  
  min = mags.get(0);
  max = mags.get(0);
  for (int i = 0; i < mags.size(); i++) {
   if (mags.get(i) < min) { min = mags.get(i); }
   if (mags.get(i) > max) { max = mags.get(i); }
  } 
  drawData();
  save("data.jpg");
}

void draw() {
  xPos = floor(map(mouseX,0,width,-mags.size(),500));
  background(230);
  drawData();
}

void drawData() {
  int startX = xPos;
  /*
  if (startX > mags.size()) {
    startX = mags.size();
  }else if (startX < 1) {
    startX = 1;
  }
  */
  stroke(128);
  line(0,50,width,50);
  line(0,450,width,450);
  stroke(32);
  for (int i = 1; i < mags.size(); i++) {
    line(i-1+startX,450-map(mags.get(i-1),min,max,0,400),
         i+startX,450-map(mags.get(i),min,max,0,400));
  }
}

void keyPressed() {
  if (key == 's') {
    String timestamp = year() + nf(month(),2) + nf(day(),2) 
      + "-"  + nf(hour(),2) + "h" + nf(minute(),2) 
      + "m" + nf(second(),2) + "s";
    save(timestamp + ".jpg");
    println("saved");
  }else if (keyCode == 37) {
    xPos -= 5;
    if (xPos < 0) xPos = 0;
  }else if (keyCode == 39) {
    xPos += 5;
    if (xPos > mags.size()) xPos = mags.size();
  }
}

float average(float[] vals) {
  float avg = 0;
  for (int i = 0; i < vals.length; i++) {
    avg += vals[i];
  }
  return avg/vals.length;
}
  


