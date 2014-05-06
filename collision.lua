local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

--COLISÕES
function playerCol(event)
	if(event.other.name == "queijo")then
		--audio.play()
		event.other:removeSelf()
		score = score + 5
		up_score()

	elseif(event.other.name == "semente") then
		event.other:removeSelf()
		score = score + 10
		up_score()

	elseif(event.other.name == "ratoeira") then
		sound_over = audio.loadSound('sound/MouseOver.wav')
		local Over = audio.play(sound_over, {loop = 1})
	 	event.other:removeSelf()
		display.remove(scoreDisplay)
		local function over()
			-- fim de jogo
			storyboard.gotoScene("gameOver", "crossFade")
	end

		over()
	end
end

function removeElementOnCol(event)
	event.other:removeSelf()
end