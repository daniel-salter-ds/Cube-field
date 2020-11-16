int maxCubeSize = 25;
float noiseVar = 0.004;
float xd = maxCubeSize*sqrt(3);
float yd = maxCubeSize*0.5;
int gridWidth, gridHeight;
float z = 0;
float dz = 0.03;

void setup() {
  size(1000, 1000);
  //fullScreen();
  background(0);
  gridWidth = ceil(width/xd) + 1;
  gridHeight = ceil(height/yd) + 1;
}

void draw() {
  background(0);
  for (int i = 0; i < gridHeight; i++) {
    for (int j = 0; j < gridWidth; j++) {
      float x = j * xd;
      float y = i * yd;
      float cubeSize = constrain(map(noise(x*noiseVar, y*noiseVar, z), 0, 1, -0.7*maxCubeSize, 1.8*maxCubeSize), 0, maxCubeSize);
      color[] sideColours = getSideColours(x, y);
      drawCube(x, y, cubeSize, sideColours);
    }
    if (i % 2 == 0) {
      translate(-0.5*sqrt(3)*maxCubeSize, 0);
    } else {
      translate(0.5*sqrt(3)*maxCubeSize, 0);
    }
  }
  z += dz;
  saveFrame("frames/cube_field_#####.png");
}

color[] getSideColours(float x, float y) {
  color[] sideColours = new color[3];
  float topr = map(x+y, 0, width+height, 150, 255);
  float topg = constrain(map(x+y, 0, width+height, -50, 300), 0, 200);
  float topb = map(x+y, 0, width+height, -100, 180);
  sideColours[0] = color(topr, topg, topb);
  float rr = map(x, 0, width, 0, 30);
  float rg = map(x, 0, width, 160, 120);
  float rb = map(x, 0, width, 255, 0);
  sideColours[1] = color(rr, rg, rb);
  float lr = map(y, 0, height, 120, 10);
  float lg = map(y, 0, height, 0, 0);
  float lb = map(y, 0, height, 100, 0);
  sideColours[2] = color(lr, lg, lb);
  return sideColours;
}

void drawCube(float x, float y, float size, color[] sides) {
  translate(x, y);
  for (int i=0; i<3; i++) {
    fill(sides[i]);
    quad(0, 0, -size*sqrt(3)/2, -size/2, 0, -size, size*sqrt(3)/2, -size/2);
    rotate(TWO_PI/3);
  }
  translate(-x, -y);
}
