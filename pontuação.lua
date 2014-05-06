	-- --PUTUAÇÃO

	-- local storyboard = require( "storyboard" )
	-- local scene = storyboard.newScene()

	-- -- include Corona's "widget" library
	-- local widget = require "widget"

	-- --------------------------------------------

	-- --Tela
	-- local _W = display.contentWidth; --largura
	-- local _H = display.contentHeight; --altura

	-- local centerX = display.contentCenterX;
	-- local centerY = display.contentCenterY;

	-- display.setStatusBar(display.HiddenStatusBar)

	-- -- Física
	-- local physics = require('physics')
	--       physics.start()
	--       physics.setGravity(0, 0)

	-- local Button_Menu

	-- display.setStatusBar(display.HiddenStatusBar)


	-- -- Called when the scene's view does not exist:
	-- function scene:createScene( event )
	-- 	local group = self.view

	-- 	--background
	-- 	local bkg = display.newImage('images/bgk.png', 0, -45)
	-- 		group:insert(bkg)
		
	-- 	--título do jogo
	-- 	local title = display.newImage("images/titleJogo.png", 64, 70)		
	-- 		group:insert( title )
		
	-- 	-- 'onRelease' event listener for playBtn
	-- 	local function return_Menu()
	-- 		storyboard.gotoScene( "menu", "slideLeft")	
	-- 	end

	-- 	--FONTE
	--         if "Windows" == system.getInfo( "platformName" ) then
	--                     COMIC = "Comic Sans MS"
	--         elseif "Android" == system.getInfo( "platformName" ) then
	--                     COMIC = "2266"
	--         end

	-- 	--PONTUAÇÃO
	-- 		score = 0
	-- 		scoreDisplay = display.newText("Scores: 0", 0, 0, COMIC, 45 )
	-- 		scoreDisplay:setFillColor(0,0,0)
	-- 		scoreDisplay.x = display.contentWidth - 500
	-- 		scoreDisplay.y = 78

	-- 	function up_score()
	-- 		scoreDisplay.text = 'Score: '..score
	-- 		scoreDisplay.x = display.contentWidth - 500
	-- 	end
	-- 		-- score = loadsave.loadTable("score.json")
	-- 		-- print('-----')
	-- 		-- for k, v in pairs(score) do
	-- 		-- 	print(k, v)
	-- 		-- 	if (v < 20) then 
	-- 		-- 		local options = 
	-- 		-- 		{
	-- 		-- 		   text = "Score:".. v,    
	-- 		-- 		    x = 165,
	-- 		-- 		    y = 250,  
	-- 		-- 		    fontSize = 30
	-- 		-- 		}
	-- 		-- 		local myText = display.newText( options )
	-- 		-- 		local grade = display.newText( "Awesome", 70, 300, COMIC, 40 )				
	-- 		-- 		group:insert(myText)
	-- 		-- 		group:insert(grade)
				
	-- 		-- 	elseif (v < 30) then
	-- 		-- 		local options = 
	-- 		-- 		{
	-- 		-- 		   text = "Score:".. v,    
	-- 		-- 		    x = 165,
	-- 		-- 		    y = 250,  
	-- 		-- 		    fontSize = 28
	-- 		-- 		}
	-- 		-- 		local myText = display.newText( options )
	-- 		-- 		local grade = display.newText( "Great", 105, 300, COMIC, 40 )				
	-- 		-- 		group:insert(myText)
	-- 		-- 		group:insert(grade)
				
	-- 		-- 	elseif (v < 40) then
	-- 		-- 		local options = 
	-- 		-- 		{
	-- 		-- 		   text = "Score:".. v,    
	-- 		-- 		    x = 165,
	-- 		-- 		    y = 250,  
	-- 		-- 		    fontSize = 28,
	-- 		-- 		}
	-- 		-- 		local myText = display.newText( options )
	-- 		-- 		local grade = display.newText( "Cool", 117, 300, COMIC, 40 )				
	-- 		-- 		group:insert(myText)
	-- 		-- 		group:insert(grade)
				
	-- 		-- 	elseif (v < 50) then
	-- 		-- 		local options = 
	-- 		-- 		{
	-- 		-- 		   text = "Score:".. v,    
	-- 		-- 		    x = 165,
	-- 		-- 		    y = 250,  
	-- 		-- 		    fontSize = 28,
	-- 		-- 		}
	-- 		-- 		local myText = display.newText( options )
	-- 		-- 		local grade = display.newText( "You are better than that!", 15, 300, COMIC, 25 )				
	-- 		-- 		group:insert(myText)
	-- 		-- 		group:insert(grade)
				
	-- 		-- 	elseif (v > 50) then
	-- 		-- 		local options = 
	-- 		-- 		{
	-- 		-- 		   text = "Score:".. v,    
	-- 		-- 		    x = 165,
	-- 		-- 		    y = 250,  
	-- 		-- 		    fontSize = 28,
	-- 		-- 		}
	-- 		-- 		local myText = display.newText( options )
	-- 		-- 		local grade = display.newText( "Never give up!", 65, 300, COMIC, 30 )				
	-- 		-- 		group:insert(myText)
	-- 		-- 		group:insert(grade)			
	-- 		-- 	end		
	-- 		-- end
			
	-- 	local Button_Menu = widget.newButton{	
	-- 		defaultFile = display.newText("MENU",450, 80, COMIC, 50)
	-- 		--defaultFile = "images/voltarBtn.png", 
	--     	--overFile = "Button_Purple.png",
	-- 		left=134, top=395,
	-- 		release = return_Menu
	-- 	}
	-- 	group:insert(Button_Menu)
		
		
	-- end

	-- -- Called immediately after scene has moved onscreen:
	-- function scene:enterScene( event )
	-- 	local group = self.view
		
	-- 	if storyboard.getPrevious() ~= nil then
	-- 		storyboard.removeScene(storyboard.getPrevious())
	-- 	end
		
	-- end

	-- -- If scene's view is removed, scene:destroyScene() will be called just prior to:
	-- function scene:destroyScene( event )
	-- 	local group = self.view
		
	-- 	if Button_Menu then
	-- 		Button_Menu:removeSelf()
	-- 		Button_Menu = nil
	-- 	end
	-- end

	-- -----------------------------------------------------------------------------------------
	-- -- END OF YOUR IMPLEMENTATION
	-- -----------------------------------------------------------------------------------------

	-- -- "createScene" event is dispatched if scene's view does not exist
	-- scene:addEventListener( "createScene", scene )

	-- -- "enterScene" event is dispatched whenever scene transition has finished
	-- scene:addEventListener( "enterScene", scene )

	-- -- "destroyScene" event is dispatched before view is unloaded, which can be
	-- -- automatically unloaded in low memory situations, or explicitly via a call to
	-- -- storyboard.purgeScene() or storyboard.removeScene().
	-- scene:addEventListener( "destroyScene", scene )

	-- -----------------------------------------------------------------------------------------

	-- return scene