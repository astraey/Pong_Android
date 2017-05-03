//Commented lines to execute with Java. Uncomment to execute on Android device
import ketai.sensors.*;

//PVector contains x, y, z components
PVector player, enemy, ball, teleporter, teleporter2;

float ballSpeedX, ballSpeedY, teleporterSpeedX, teleporterSpeedY, teleporter2SpeedX, teleporter2SpeedY, enemySpeed;

int playerScore = 0;
int enemyScore = 0;
float ballSize;

PVector ballColor = new PVector(255, 255, 255);
PVector playerColor = new PVector(0, 200, 0);
PVector enemyColor = new PVector(200, 0, 0);



//Commented lines to execute with Java. Uncomment to execute on Android device
KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;

void setup()
{

  
    orientation(LANDSCAPE);
    size(displayWidth, displayHeight);

    ball = new PVector(width/2, height/2);
    player = new PVector(width, height/2);
    enemy = new PVector(0, height/2);
    teleporter = new PVector(0, 0);
    teleporter2 = new PVector(0, 0);
    

    ballSpeedX = width/100;
    ballSpeedY = width/100;
    
    ballSpeedX = width/100;
    ballSpeedY = width/100;
    
    teleporterSpeedX = width/1200;
    teleporterSpeedY = width/1200;
    teleporter2SpeedX = width/600;
    teleporter2SpeedY = width/500;
    
    
    enemySpeed = width/150;
    
    ballSize = width/20;
    
    //Commented lines to execute with Java. Uncomment to execute on Android device
    sensor = new KetaiSensor(this);
    sensor.start();
    
    rectMode(CENTER);
      
}

void drawTeleporter()
{
  
   
   int greenColor = (int)((teleporter.y/width) * 255);
   int redColor = (int)((teleporter.x/width) * 255);
   
   stroke(redColor,greenColor,0);
   ellipse(teleporter.x, teleporter.y, width/20, width/20);
   
   teleporter.x += teleporterSpeedX;
   teleporter.y += teleporterSpeedY;
   
   teleporterBoundary();
}

void drawTeleporter2()
{
  
   
   int blueColor = (int)((teleporter.x/width) * 255);
   
   stroke(0,0,blueColor);
   ellipse(teleporter2.x, teleporter2.y, width/20, width/20);
   
   teleporter2.x += teleporter2SpeedX;
   teleporter2.y += teleporter2SpeedY;
   
   teleporter2Boundary();
}

void draw()
{
    //Clears the screen to draw the next frame
    background(0); 
    
    centerLine();
    drawBall();
    drawPlayer();
    drawEnemy();
    scoreText();
    drawTeleporter();    
    drawTeleporter2();
    teleporterLogic();
    
    //Prints accelerometer stats
    println("-------");
    println("X: " + accelerometerX);
    println("Y: " + accelerometerY);
    println("Z: " + accelerometerZ);
    println("-------");
}

void drawBall()
{
    pushMatrix();
      translate(ball.x, ball.y);
      fill(ballColor.x, ballColor.y, ballColor.z);      
      ellipse(0, 0, width/20, width/20);
    popMatrix();
    
    ball.x += ballSpeedX;
    ball.y += ballSpeedY;
    
    ballBoundary();
}

void ballBoundary()
{
   //top
   if (ball.y < 0) {
      ball.y = 0;
      ballSpeedY *= -1; 
   }
  
   //bottom
   if (ball.y > height) {
      ball.y = height;
      ballSpeedY *= -1; 
   }

    ball.dist(player);
    
    if (ball.x > width) {
       ball.x = width/2;
       ballSpeedX *= -1;
       enemyScore ++;
    }
    
    if (ball.x < 0) {
       ball.x = width/2; 
       ballSpeedX *= -1;
       playerScore ++;
    }
    
    //player
    if (ball.x > width - width/40 - ballSize && ball.x < width && Math.abs(ball.y - player.y) < width/10) {
       ball.x = width - width/40 - ballSize;
       ballSpeedX *= -1;
    }
    
    //enemy
    if (ball.x < width/40 + ballSize && ball.x > 0 && Math.abs(ball.y - enemy.y) < width/10) {
       ball.x = width/40 + ballSize;
       ballSpeedX *= -1; 
    }
    
    
 
}


void teleporterBoundary()
{
   //top
   if (teleporter.y < 0) {
      teleporter.y = 0;
      teleporterSpeedY *= -1; 
   }
  
   //bottom
   if (teleporter.y > height) {
      teleporter.y = height;
      teleporterSpeedY *= -1; 
   }

    //ball.dist(player);
    
    if (teleporter.x > width) {
       teleporter.x = width;
       teleporterSpeedX *= -1;
      
    }
    
    if (teleporter.x < 0) {
       teleporter.x = 0; 
       teleporterSpeedX *= -1;
    }
    
    
 
}

void teleporter2Boundary()
{
   //top
   if (teleporter2.y < 0) {
      teleporter2.y = 0;
      teleporter2SpeedY *= -1; 
   }
  
   //bottom
   if (teleporter2.y > height) {
      teleporter2.y = height;
      teleporter2SpeedY *= -1; 
   }

    //ball.dist(player);
    
    if (teleporter2.x > width) {
       teleporter2.x = width;
       teleporter2SpeedX *= -1;
      
    }
    
    if (teleporter2.x < 0) {
       teleporter2.x = 0; 
       teleporter2SpeedX *= -1;
    }
    
    
 
}

void teleporterLogic()
{
  if(abs(ball.x - teleporter.x) < width/19 && abs(ball.y - teleporter.y) < width/19)
  {
    ball.x = teleporter2.x;
    ball.y = teleporter2.y;
  }
  

}

void drawPlayer()
{  
   player.y = mouseY;
  
   pushMatrix();
     translate(player.x - width/20, player.y);
     stroke(0);
     fill(playerColor.x, playerColor.y, playerColor.z);
     rect(0, 0, width/20, width/5);
   popMatrix();
  
}

void drawEnemy()
{
    enemy.y += enemySpeed;
  
    pushMatrix();
      translate(enemy.x + width/20, enemy.y);
      fill(enemyColor.x, enemyColor.y, enemyColor.z);
      rect(0, 0, width/20, width/5);
    popMatrix();
    
    enemyAI();
  
}

void enemyAI()
{
    if (enemy.y < ball.y) {
      enemySpeed = width/150;
    }
    
    if (enemy.y > ball.y) {
      enemySpeed = - width/150; 
    }
    
    if (enemy.y == ball.y) {
      enemySpeed = 0; 
    }
    
    if (ball.x > width/2) {
      enemySpeed = 0; 
    }
}

void scoreText()
{
    fill(255);
    textSize(width/20);
    text(enemyScore, width/10 * 3, height/5);
    text(playerScore, width/10 * 7, height/5);  
}

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}

void centerLine()
{
   strokeWeight(width/120);
   stroke(255);
   line(width/2,  0, width/2, height);
}