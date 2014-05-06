	--MENU
	local storyboard = require( "storyboard" )
	local scene = storyboard.newScene()
	local widget = require "widget"

	display.setStatusBar(display.HiddenStatusBar)

	function scene:createScene( event )
	        local group = self.view

	         -- carregando o audio
            backgroundMusic = audio.loadStream( "sound/Batty McFaddin.mp3" )

	        -- rodando o audio
            local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )


	        --background
	        local bkgMenu = display.newImage ("images/bkgMenu1.png", 264, 450)
			group:insert(bkgMenu)

			--título do jogo
			local gametitle = display.newImage ("images/title.png", 315, 230)
			group:insert(gametitle)

			-- função jogar
			local function play()
			-- vai para o jogo
			audio.stop(backgroundMusicChannel)
			storyboard.gotoScene("jogo", "crossFade")	
			end

			--função das configurações do jogo
			local function options()
			storyboard.gotoScene( "configure", "slideLeft")	
			end

			--função créditos
			local function credits()
			storyboard.gotoScene( "creditos", "slideLeft")	
			end

			--FONTE
	        if "Windows" == system.getInfo( "platformName" ) then
	                    COMIC = "ChelaOne-Regular"
	        elseif "Android" == system.getInfo( "platformName" ) then
	                    COMIC = "2266"
	        end

 		-- criando os botões
 		local Button_play = widget.newButton{
 		defaultFile = "images/button_play.png", 
     	overFile = "images/button_play2.png",
 		left=180, top=440,
 		onRelease = play -- event listener function
 		}
 		group:insert(Button_play)

 		local Button_options = widget.newButton{	
 		defaultFile = "images/button_options.png", 
     	overFile = "images/Button_options2.png",
 		left=180, top=540,
 		onRelease = options -- event listener function
 		}
 		group:insert(Button_options)

 		local Button_credits = widget.newButton{	
 		--defaultFile = display.newText("CRÉDITOS", 450, 80, COMIC, 45 )
 		defaultFile = "images/button_credits.png", 
     	overFile = "images/Button_credits2.png",
 		left=130, top=650,
 		onRelease = credits -- event listener function
 		}
 		group:insert(Button_credits)
	        
 end

	-- Called immediately after scene has moved onscreen:
	function scene:enterScene( event )
	        local group = self.view
	        if storyboard.getPrevious() ~= nil then
				storyboard.removeScene(storyboard.getPrevious())
			end
	end

	-- Called prior to the removal of scene's "view" (display group)
	function scene:destroyScene( event )
	        local group = self.view
			if Button_play then
				Button_play:removeSelf()	-- widgets must be manually removed
				Button_play = nil
			elseif Button_options then
				Button_options:removeSelf()
				Button_options = nil
			elseif Button_credits then
				Button_credits:removeSelf()
				Button_credits = nil
			end
	end
	---------------------------------------------------------------------------------
	-- END OF YOUR IMPLEMENTATION
	---------------------------------------------------------------------------------

	-- "createScene" event is dispatched if scene's view does not exist
	scene:addEventListener( "createScene", scene )

	-- "enterScene" event is dispatched whenever scene transition has finished
	scene:addEventListener( "enterScene", scene )

	-- "destroyScene" event is dispatched before view is unloaded, which can be
	-- automatically unloaded in low memory situations, or explicitly via a call to
	-- storyboard.purgeScene() or storyboard.removeScene().
	scene:addEventListener( "destroyScene", scene )

	---------------------------------------------------------------------------------

	return scene