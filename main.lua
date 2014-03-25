local physics = require("physics")
physics.start()


local _W = display.contentWidth;
local _H = display.contentHeight;

local centerX = display.contentCenterX;
local centerY = display.contentCenterY;

display.setStatusBar(display.HiddenStatusBar)

local bkg = display.newImageRect("bkg.jpg", _W, _H)
bkg.x = centerX
bkg.y = centerY

local ground = display.newImageRect("chao1.png", _W, _H*0.15)
ground.x = centerX 
ground.y = centerY *1.9

local remRect = display.newRect(0, _H + 100, _W, 1)

--physics.addBody(ground, "static", {density = 1, friction= 0.5, bounce = 0.0})


local player = display.newImageRect("victor1.png", _W*0.2, _H*0.20)
player.x = centerX
player.y = ground.y - 50
player.myName = rato

physics.addBody(player,"static", {density = 0.012, friction = 0.5, 
				bounce = 0, radius = 35})


local borderLeft = display.newRect(1, centerY, 1, _H)
physics.addBody(borderLeft, "static", {density = 1, friction= 0.5, bounce = 0.0})

local borderRigth = display.newRect(_W -1, centerY, 1, _H)
physics.addBody(borderRigth, "static", {density = 1, friction= 0.5, bounce = 0.0})


function gerar()
	local n = math.random(0,2)
	local x = math.random(0,_W)
	
	--comida = display.newCircle(x,0,30)
	local queijo = display.newImageRect("queijo.png", 100, 70)
	queijo.x = x
	physics.addBody(queijo)
	queijo.myName = queijo


	local rotoeira = display.newImageRect("ratr.png", 100, 70)
	rotoeira.x = n	
	physics.addBody(rotoeira)
	rotoeira.myName = rotoeira
	
	timer.performWithDelay(3000,gerar,1) 
end
 
 --Movimentos dos player
 
local screen_tap = function( event )
		player:setLinearVelocity( 0, 0)
		if event.x < centerX then
			player.x = player.x - 80

			
		else
			player.x = player.x + 80
		end
		
	end

Runtime:addEventListener( 'tap', screen_tap )

gerar()

--PONTUAÇÃO
local score = 0
local scoreDisplay = display.newText("Scores: ", 0, 0, nil, 45 )
scoreDisplay:setFillColor(1,0,1)
scoreDisplay.x = display.contentWidth - 500
scoreDisplay.y = 78

 local function onLocalCollision( self, event )
	if ( event.phase == "began" ) then
        print( "began: " .. event.player.rato .. " & " .. event.queijo.queijo)

    elseif ( event.phase == "ended" ) then
        print( "ended: " .. event.player.rato .. " & " .. event.rotoeira.ratoeira )     
     end
 end










