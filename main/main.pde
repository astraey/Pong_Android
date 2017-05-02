//Commented lines to execute with Java. Uncomment to execute on Android device
//import ketai.sensors.*;

//PVector contains x, y, z components
PVector player, enemy, ball;

float ballSpeedX, ballSpeedY, enemySpeed;

int playerScore = 0;
int enemyScore = 0;
float ballSize;

PVector ballColor = new PVector(255, 255, 255);
PVector playerColor = new PVector(0, 200, 0);
PVector enemyColor = new PVector(200, 0, 0);


//Commented lines to execute with Java. Uncomment to execute on Android device
//KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;

void setup()
{

  
    orientation(LANDSCAPE);
    size(displayWidth, displayHeight);

    ball = new PVector(width/2, height/2);
    player = new PVector(width, height/2);
    enemy = new PVector(0, height/2);
    

    ballSpeedX = width/100;
    ballSpeedY = width/100;
    
    
    enemySpeed = width/150;
    
    ballSize = width/20;
    
    //Commented lines to execute with Java. Uncomment to execute on Android device
    //sensor = new KetaiSensor(this);
    //sensor.start();
    
    rectMode(CENTER);
      
}

void drawTeleporter()
{
  
  println("Teleporter Drawn");
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
    //Prints accelerometer stats
    //println("-------");
    //println("X: " + accelerometerX);
    //println("Y: " + accelerometerY);
    //println("Z: " + accelerometerZ);
    //println("-------");
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
   int numberOfLines = 20;
  
   for (int i = 0; i < numberOfLines; i++) {
     strokeWeight(width/100);
     stroke(255);
     line(width/2, i * width/numberOfLines, width/2, (i+1) * width/numberOfLines - width/40);
     stroke(0, 0);
     line(width/2, (i+1) * width/numberOfLines - width/40, width/2, (i+1) * width/numberOfLines);
     
   }
}