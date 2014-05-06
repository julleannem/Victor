
    local storyboard = require( "storyboard" )
    local scene = storyboard.newScene()

    local widget = require "widget"

    -------------------------------------------------------------------------------------

    --Tela
    local _W = display.contentWidth; --largura
    local _H = display.contentHeight; --altura

    local centerX = display.contentCenterX;
    local centerY = display.contentCenterY;

    display.setStatusBar(display.HiddenStatusBar)

    -- Física
    local physics = require('physics')
          physics.start()
          physics.setGravity(0, 0)

    local statusGame

    -- Colisões
    local collision = require("collision")

    --Pontuação
    --local pontos = require ("pontuação")

    --background
    local bkg
    --local ground
    local remRect

    --bordas
    local borderLeft
    local borderRigth

    --elementos
    local queijo
    local ratoeira
    local cozinha
    local teto
    local luz 

    --botões
    local button_left
    local button_right
    local sound_buttons

    --pontos
    score = 0

    --tempo
    time = 60
    local timerGame

    --player
    local player


    function scene:createScene( event )
            local group = self.view
            statusGame = 'playing'

            audio.pause(backgroundMusic)
            
            -- carregando o audio
            narrationSpeech = audio.loadStream( "sound/Monkeys Spinning Monkeys.mp3" )
            sound_buttons = audio.loadSound('sound/Mouse.wav')

            
            -- carregando o audio
            local narrationChannel = audio.play( narrationSpeech, { loop=0 } )
            --onComplete=narrationFinished
            local soundBut = audio.play( sound_buttons, {loop = 1})
            
                    
            --Background
            bkg = display.newImageRect("images/background3.png", 700, 966)
            bkg.x = centerX 
            bkg.y = centerY 
            group:insert(bkg)

            remRect = display.newRect(0, _H + 100, _W, 1)
            physics.addBody(remRect,"static")
            remRect:addEventListener("collision",removeElementOnCol)
            group:insert(remRect)

            --physics.addBody(ground, "static", {density = 1, friction= 0.5, bounce = 0.0})

            borderLeft = display.newRect(1, centerY, 1, _H)
            physics.addBody(borderLeft, "static", {density = 1, friction= 0.5, bounce = 0.0})
            group:insert(borderLeft)

            borderRigth = display.newRect(_W -1, centerY, 1, _H)
            physics.addBody(borderRigth, "static", {density = 1, friction= 0.5, bounce = 0.0})
            group:insert(borderRigth)

            --BOTÕES
            button_left = display.newImage( "images/buttonL.png", 0, 0 )
            button_left.x = 80
            button_left.y = _H - 300
            button_left.alpha = .4
            
            button_right = display.newImage( "images/buttonR.png", 0, 0 )
            button_right.x = _W - 80
            button_right.y = _H - 300
            button_right.alpha = .4

            group:insert(button_left)      
            group:insert(button_right)     
            
            --Player
            player = display.newImageRect("images/Victor.png", _W * 0.3, _H * 0.2)
            player.x = centerX
            player.y = centerY * 1.7
            player.x_speed = 0
            player.myName = rato
            player:addEventListener("collision",playerCol)
            physics.addBody(player,"static", {density = 0.012, friction = 0.5, 
                            bounce = 0, radius = 35})
            group:insert(player)

            --FONTE
            if "Windows" == system.getInfo( "platformName" ) then
                        COMIC = "ChelaOne-Regular"
            elseif "Android" == system.getInfo( "platformName" ) then
                        COMIC = "2266"
            end


            --TEMPO
            local displayTime = display.newText("Tempo: ", 480, 80, COMIC, 45)
                  displayTime:setTextColor(0,0,0)
                  displayTime.x = display.contentWidth - 150  
                  displayTime.y = 78
                  group:insert(displayTime)


            function start_time_regr()
                    if statusGame == 'playing' then
                            time = time - 1  
                            displayTime.text = "Tempo: " .. time
                            displayTime.x = display.contentWidth - 150
                            print("time" .. time)  
                    
                        if(time == 0) then
                        timer.pause(timerGame)
                        end
                    end            
            
            end
            timerGame = timer.performWithDelay( 1000, start_time_regr, 0 )

            
            --PONTUAÇÃO
                score = 0
                scoreDisplay = display.newText("Scores: 0", 0, 0, COMIC, 45 )
                scoreDisplay:setFillColor(0,0,0)
                scoreDisplay.x = display.contentWidth - 520
                scoreDisplay.y = 78   

                --group:insert(score)
                --group:insert(scoreDisplay)             

            function up_score()
                scoreDisplay.text = 'Score: '..score
                scoreDisplay.x = display.contentWidth - 520
            end
    
        --Movimentos dos player
            local function update()
                if(player.x ~= nil) then
                    player.x = player.x - player.x_speed
                    if player.x < 100 then
                        player.x = 100
                elseif player.x > display.contentWidth - 100 then
                    player.x = display.contentWidth - 100
                end
                end
            end

            local function left( event )
                if(event.phase == "began") then
                    player.x_speed = 11
                    audio.play(sound_buttons)
                elseif(event.phase == "ended")then
                    player.x_speed = 0        
                            --if event.x < centerX then
                              --      player.x = player.x - 80
                                    --transition.to( player, {} )
                end
            end

            local function right( event )
                if(event.phase == "began") then
                    player.x_speed = -11
                    audio.play(sound_buttons)
                elseif(event.phase == "ended")then
                    player.x_speed = 0       
          end
            end

            button_left:addEventListener( 'touch', left )
            button_right:addEventListener( 'touch', right )
            Runtime:addEventListener('enterFrame', update)

            --gerar queijos e ratoeiras       
            function gerarElemento()
                    local num = math.random(0,1)
                    local especial = math.random(2)
                    local elemento
                    local transitionTime = time*100

                    if(time > 10)then
                            transitionTime = time*100
                    else
                            transitionTime = 1000
                    end

                    if(num == 0)then
                            elemento = display.newImageRect("images/queijoJogo.png", 100, 70)
                            elemento.x =  math.random(0, _W)
                            physics.addBody(elemento, "dynamic")
                            elemento.name = "queijo"
                    elseif(num == 1) then
                            elemento = display.newImageRect("images/ratrJogo.png", 100, 70)
                            elemento.x = math.random(0, _W)
                            physics.addBody(elemento, "dynamic")
                            elemento.name = "ratoeira"
                    
                    elseif(especial == 2)then
                            elemento = display.newImageRect("images/semente.png", 100, 70)
                            elemento.x = math.random(0, _W)
                            physics.addBody(elemento, "dynamic")
                            elemento.name = "semente"
                    end

                    group:insert(elemento)

                    transition.to(elemento,{time=transitionTime,y = _H + 100,onComplete = gerarElemento})
            end

            gerarElemento()

            local function return_Menu(event)
                    if(event.phase == "began") then
                            storyboard.gotoScene("menu", "fade", "1000")
                    end
                    display.remove(Button_Menu)

                    --display.remove(alertView)
            end
            
            --local function novo_Jogo(event)
            --       if(event.phase == "began") then
            --                storyboard.gotoScene("novoJogo", "fade", "300")
            --        end
            --        display.remove(Button_Menu)
            --end

             function acione(action)
                    --display.remove(elemento)
                    if(action == 'end') then
                            statusGame = 'over'
                            --timer.pause(timerGame)                        
                            --alertView = display.newImage('images/lose.png', 90, 300)
                            --Button_Menu = display.newText("MENU", 450, 80, COMIC, 50)
                            Button_Menu = display.newImage('images/button_Menu.png', 200, 360)
                            -- Button_Novo_Jogo = display.newText("NOVO JOGO", 500, 80, COMIC, 50)
                            --Button_Novo_Jogo = display.newImage('.png', 175, 360)
                            
                            Button_Menu:addEventListener("touch",return_Menu )
                            --Button_Novo_Jogo:addEventListener("touch", novo_Jogo)
            
                    else
                            --timer.pause(timerGame)
                            --Button_Menu = display.newText("MENU", 450, 80, COMIC, 50)
                            Button_Menu = display.newImage('images/button_Menu.png', 113, 360)
                            Button_Menu:addEventListener("touch", return_Menu)
                                    
                    end
            
                    --transition.from(alertView, {time = 200, alpha = 0.1})
            end

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