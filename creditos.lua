--creditos

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------
--Tela
local _W = display.contentWidth; --largura
local _H = display.contentHeight; --altura

local centerX = display.contentCenterX;
local centerY = display.contentCenterY;

display.setStatusBar(display.HiddenStatusBar)


--local loadsave = require("loadsave")

local button_voltar

display.setStatusBar(display.HiddenStatusBar)

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view


	--background
	local bkg = display.newImage("images/bkgMenu2.png", 264, 450)
		group:insert(bkg)
	
	--creditos
	local credits = display.newImage("images/button_credits.png", 310, 130 ) 
	--display.newImage("credits.png", 0, 140)		
		group:insert( credits )	
	
	--texto
	local text = display.newImage("images/textCredits.png", 315, 500)		
		group:insert( text )


	local function return_Menu()
		
		storyboard.gotoScene( "menu", "slideRight")	
		--return true	-- indicates successful touch
	end

	local Button_menu = widget.newButton{	
 		--defaultFile = display.newText("OPÇÕES", 450, 80, COMIC, 45 )
 		defaultFile = "images/button_voltar.png", 
     	--overFile = "Button_Purple.png",
 		left=230, top=750,
 		onRelease = return_Menu -- event listener function
 		}
 		group:insert(Button_menu)
	
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	if storyboard.getPrevious() ~= nil then
		storyboard.removeScene(storyboard.getPrevious())
	end
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	if Button_Menu then
		Button_Menu:removeSelf()	-- widgets must be manually removed
		Button_Menu = nil
	end
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene