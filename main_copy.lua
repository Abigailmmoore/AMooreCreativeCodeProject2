require("L5")

function setup()
  size(800, 600)

  windowTitle("Chaos into Order")
  
  --The opacity of the chaos pattern
  noiseLevel = 200
  --The size of the chaos pattern particles, larger scale equals smaller particles
  noiseScale = 0.003

  --Arrays for holding the circle coordinates
  locationX = {}

  locationY = {}

  --Chooses a random number for the randomSeed function each time the program is run
  seed = random(0, 12)
end

function draw()

  --The top coordinate of the Chaos pattern, increases over time, causing the pattern to move downwards
  top = frameCount*30

  --The background color
  background(255, 232, 0, 30)
  
  --Sets the size of the dots used to make the Chaos pattern
  strokeWeight(1)

  --Iterate from top to bottom, then left to right
  for y=1, height do
    for x=1, width do

      --The inputs for the noise function. As the noiseScale increases, the dot size decreases.
      --The frameCount is to make the output different each time, because noise always gives the same output for an input.
      local nx = noiseScale * x - frameCount
      local ny = noiseScale * y - frameCount

      -- noise gives a value between 1 and 0, so when multiplied by noiseLevel, "a" becomes a value that can give varying opacity for a color.
      local a = noiseLevel * noise(nx, ny)

      --Black Pattern
      stroke(0, 0, 0, a)
      point(x, y + top)
    end
  end

  --Iterate from top to bottom, then left to right
  for y=1, height do
    for x=1, width do

      --The inputs for the noise function. As the noiseScale increases, the dot size decreases.
      --The frameCount is to make the output different each time, because noise always gives the same output for an input. It is added to make the pattern different than above.
      local nx = noiseScale * x + frameCount
      local ny = noiseScale * y + frameCount

      -- noise gives a value between 1 and 0, so when multiplied by noiseLevel, "a" becomes a value that can give varying opacity for a color.
      local a = noiseLevel * noise(nx, ny)

      --Blue Pattern
      stroke(0, 120, 191, a)
      point(x, y + top)
    end
  end

  --Iterate from left to right, then from top to bottom (to distinguish from the two patterns above)
  for x=1, width do
    for y=1, height do

      --The inputs for the noise function. As the noiseScale increases, the dot size decreases.
      --The frameCount is to make the output different each time, because noise always gives the same output for an input.
      local nx = noiseScale * x + frameCount
      local ny = noiseScale * y + frameCount

      -- noise gives a value between 1 and 0, so when multiplied by noiseLevel, "a" becomes a value that can give varying opacity for a color.
      local a = noiseLevel * noise(nx, ny)

      --Fluorescent Pink Pattern
      stroke(255, 72, 176, a)
      point(x, y + top)
    end
  end

  --Change the number of circles drawn depending on how long has passed
  number = ceil(frameCount)

  --Sequentially draw an increasing number of green circles
  for c=1, number do

    noStroke()

    --randomSeed keeps the locations of the circles consistent as they are drawn
    randomSeed(c+seed)
    
    --Logic to make the circles be drawn within grid squares a certain distance apart from each other.
    locationX[c] = random(width*((0.199*(c-1))%1), width*((0.199*c)%1))
    locationY[c] = random(height*0.25*(ceil(c/5)-1), height*0.25*ceil(c/5))
    
    --Draw larger and smaller green circles with positions based on the above calculations
    fill(255, 232, 0, 100)
    circle(locationX[c], locationY[c], height*0.1)
    fill(255, 232, 0)
    circle(locationX[c], locationY[c], height*0.05)

    --Once two circles have been drawn, start connecting the circles with lines
    if c >= 2 then
      stroke(255, 232, 0)
      strokeWeight(10)
      line(locationX[c], locationY[c], locationX[c-1], locationY[c-1])
    end
  end
end