<h3>Pong Game for Android :ocean:</h3>

<p>Classic Pong game for Android, built with Processing. The user interacts with the platform through the device's accelerometer.</p>

![capture](https://cloud.githubusercontent.com/assets/15648801/25671475/7afb85a6-3030-11e7-8ca2-183a2aa6da5f.PNG)

<p>As we can see on the image above, our application is built on top of the classic Pong
game. There are two players, the green player controlled by the user and the red player
controlled by a simple AI. The goal of the game is to hit the ball so it does not surpass
your own side of the game area, while trying that that same ball surpasses the enemy
player in its own game area, scoring a point every time this happens.</p>

<p>The main difference between the classic Pong game and our version is that there are
also 2 extra objects that we have named Teleporters. There are a yellow Teleporter and
a blue Teleporter. If the ball hits the yellow Teleporter, it will automatically move to
where the blue Teleporter is. This process will always be from yellow to blue, and never
the other way. If the ball hits the blue Teleporter, nothing will happen.</p>

<p>Controlling the player is very intuitive, simply press up and down on the device. The key
of the interaction in our platform is the controls for the Teleporters. Each of them will
move at a different speed, and will be controlled by the user through the accelerometer
on his device. That way, the user can use the Teleporters as support to score points and
beat the AI.
