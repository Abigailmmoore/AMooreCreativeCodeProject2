require("L5")

chaosBlue = {56, 43, 115}

chaosGreen = {83, 43, 88}

chaosTeal = {42, 63, 77}

function setup()
  size(800, 600)

  windowTitle("Chaos into Order")
  
  --The opacity of the chaos pattern
  noiseLevel = 200
  --The size of the chaos pattern particles, larger scale equals smaller particles
  noiseScale = 0.003
end

function draw()

  background(255)
  --Iterate from top to bottom, then left to right
  for y=1, height do
    for x=1, width do

      --The inputs for the noise function. As the noiseScale increases, the dot size decreases.
      --The frameCount is to make the output different each time, because noise always gives the same output for an input.
      local nx = noiseScale * x - frameCount
      local ny = noiseScale * y - frameCount

      -- noise gives a value between 1 and 0, so when multiplied by noiseLevel, "a" becomes a value that can give varying opacity for a color.
      local a = noiseLevel * noise(nx, ny)

      --Green Pattern
      stroke(83, 43, 88, a)
      point(x, y)
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
      stroke(56, 43, 115, a)
      point(x, y)
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

      --Teal Pattern
      stroke(42, 63, 77, a)
      point(x, y)
    end
  end

  --Change the number of circles drawn depending on how long has passed
  number = ceil(frameCount)

  --Sequentially draw an increasing number of green circles
  for c=1, number do

    --randomSeed keeps the locations of the circles consistent as they are drawn
    randomSeed(c+1)
    
    --Logic to make the circles be drawn in a grid area a certain distance apart from each other.
    local xLocation = random(width*((0.198*(c-1))%1), width*((0.198*c)%1))
    local yLocation = random(height*0.25*(ceil(c/5)-1), height*0.25*ceil(c/5))
    
    --Draw larger and smaller green circles with positions based on the above calculations
    fill(128,239,128,180)
    circle(xLocation, yLocation, height*0.1)
    fill(76,187,23)
    circle(xLocation, yLocation, height*0.05)

    --Attempting to draw a line between the circles, unsure how to save the coordinates of the previous circle.
    if c >= 2 then
    line(xLocation, yLocation, --unknown, unknown)
    end
  end
end