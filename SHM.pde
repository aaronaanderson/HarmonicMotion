/*
I stumbled on a cool animation on imgur and decided to recreate it for fun. I've added some features and 
documented it as well as I could so others can have fun too. Enjoy. Steal it, do w/e you want with it, idc.
*/

//=====================================================================
int numNodes = 200; //number of points in the spiral
float frequency = 0.05; // how many full rotations per second
PVector previousLocation = new PVector();//needed to create lines between points

int mode = 1;//initialize mode

//=====================================================================
void setup(){
  size(800, 800);//size/resolution of window
  colorMode(HSB);//set color mode for hue, saturation, brightness instead of standard Red, Green, Blue (makes coloring easier)
  //blendMode(ADD);//add color layers instead of overlapping. 
}

//=====================================================================
void draw(){//for every frame
  background(0);//erase what was there (replace with black)
  
  PVector location = new PVector();//set memory for new node
  float angle = 0;
  if(mode < 2){
       angle = (frameCount/60.0)  * TWO_PI * frequency; //get ellapsed time
       println(frameCount);
  }else{
    PVector mousePosition = new PVector(mouseX, mouseY);
    PVector center = new PVector(width*0.5, height*0.5);
    numNodes = (int)mousePosition.dist(center);
    angle = center.sub(mousePosition).heading() + PI;
    
  }

  color c =  color(0, 255, 255, 10);//make an initial color
  
  for(int i = 1; i < numNodes; i++){//for every node that must be drawn (set above)
    
    if(mode == 0){
      c = color(255);//set to white
    }else{
      c = color(map(i, 1, numNodes, 0, 1000)%255, 255, 255);//color dependant on distance from center
    }
    
    
    pushMatrix();//must push and popmatrix to use translate() correctly
    translate(width* 0.5, height * 0.5);//Move location (0,0) to center of window
    float radius = (width*0.5) - (i * (width*0.5/numNodes));//distance from center depends on number of nodes
    location.x = cos(angle * i) * radius;//math to calculate x value of a circle trajectory in time
    location.y = sin(angle * i) * radius;//math to calculate y value of a circle trajectory in time
    
    //draw line from current point to previous point
    if(i>1){//(if index is zero, there is no previous point. 
      strokeWeight(2);stroke(c);
      line(location.x, location.y, previousLocation.x, previousLocation.y);
    }
    
    fill(c);//set the color of the inside of the circles
    ellipse(location.x, location.y, 20, 20);//draw the circles
    previousLocation.x = location.x;//update previous x location
    previousLocation.y = location.y;//update previous y location
    popMatrix();//must push and pop matrix to use translate() correctly
  }//end for loop
  saveFrame();
}//end draw loop


void keyPressed(){//in the event that any key is pressed
 
  if(key == '1'){//if that key was the number 1
   println("yup");
    mode = 0;//this is the setting in a gif online
    numNodes = 20;
  }else if(key == '2'){//if that key was the number 2
    mode = 1;//adds color and a lot more nodes
    numNodes = 200;
  }else if(key == '3'){//if that key was the number 3
    mode = 2;//this mode replace time with angle from center
    //nodes set by distance mouse is from center
  }
}
