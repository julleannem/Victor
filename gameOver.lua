--GAME OVER
	local storyboard = require( "storyboard" )
	local scene = storyboard.newScene()
	local widget = require "widget"

	display.setStatusBar(display.HiddenStatusBar)

	function scene:createScene( event )
	        local group = self.view
	        soundOver = audio.loadStream("sound/MouseOver.wav")

	        audio.pause()
	        transition.pause()

	        local soundO = audio.play(soundOver, { loop=0})

	        --background
	        local bkgMenu = display.newImage ("images/bkgMenu2.png", 264, 450)
			group:insert(bkgMenu)

			--título do jogo
			--local gametitle = display.newImage ("images/title.png", 315, 230)
			--group:insert(gametitle)

			--over
			local fim = display.newImage ("images/over.png", 315, 350)
			group:insert(fim)

			 --Retorna Pontuação do Jogo
               
                scoreTotal = display.newText("Scores:" .. score, 0, 0, COMIC, 45 )
                scoreTotal:setFillColor(1,1,1)
                scoreTotal.x = display.contentWidth - 320
                scoreTotal.y = 550

                group:insert(scoreTotal) 


			local function return_Menu(event)
							audio.play(backgroundMusic)
                            storyboard.gotoScene("menu", "fade", "1000")
            end
            
            local function novo_Jogo(event)
                            storyboard.gotoScene("novoJogo", "fade", "300")
              end


			--FONTE
	        if "Windows" == system.getInfo( "platformName" ) then
	                    COMIC = "ChelaOne-Regular"
	        elseif "Android" == system.getInfo( "platformName" ) then
	                    COMIC = "2266"
	        end

 		-- criando os botões
 		local Button_novoJogo = widget.newButton{	
 		--defaultFile = display.newText("JOGAR", 450, 80, COMIC, 45 )
 		defaultFile = "images/button_novoJogo.png", 
     	--overFile = "Button_Purple.png",
 		left=80, top=670,
 		onRelease = novo_Jogo -- event listener function
 		}
 		group:insert(Button_novoJogo)

 		local Button_Menu = widget.newButton{	
 		--defaultFile = display.newText("JOGAR", 450, 80, COMIC, 45 )
 		defaultFile = "images/button_voltar.png", 
     	--overFile = "Button_Purple.png",
 		left=370, top=670,
 		onRelease = return_Menu -- event listener function
 		}
 		group:insert(Button_Menu)
	        
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
				elseif Button_Menu then
				Button_Menu:removeSelf()
				Button_Menu = nil
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