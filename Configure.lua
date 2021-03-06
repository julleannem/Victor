--Configure
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"

	display.setStatusBar(display.HiddenStatusBar)

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

	function scene:createScene( event )
	        local group = self.view
	        --Create a background
local background = display.newImage( "images/bkgMenu2.png", centerX, centerY, true )
local text = display.newImage("images/button_options.png", 300, 100)
group:insert(background)
group:insert(text)

--Box to underlay our audio status text
local gradient = {
	type = 'gradient',
	color1 = { 1, 1, 1 }, 
	color2 = { 117/255, 139/255, 168/255 },
	direction = "down"
}

local statusBox = display.newRect( centerX, 20, _W, 44 )
statusBox:setFillColor( gradient ) 
-- statusBox.fill = gradient
statusBox.alpha = 0.7
group:insert(statusBox)

--Create a text object to show the current status
local statusText = display.newText( "Audio Player Sample", statusBox.x, statusBox.y, native.systemFontBold, 18 )
group:insert(statusText)

--Variable to store what platform we are on.
local platform

--Check what platform we are running this sample on
if system.getInfo( "platformName" ) == "Android" then
	platform = "Android"
elseif system.getInfo( "platformName" ) == "Mac OS X" then
	platform = "Mac"
elseif system.getInfo( "platformName" ) == "Win" then
	platform = "Win"
else
	platform = "IOS"
end

--Create a table to store what types of audio are supported per platform
local supportedAudio = {
	["Mac"] = { extensions = { ".aac", ".aif", ".caf", ".wav", ".mp3", ".ogg" } },
	["IOS"] = { extensions = { ".aac", ".aif", ".caf", ".wav", ".mp3" } },
	["Win"] = { extensions = { ".wav", ".mp3", ".ogg" } },
	["Android"] = { extensions = { ".wav", ".mp3", ".ogg" } },
}

--Create a table to store what types of audio files should be streamed or loaded fully into memory.
local loadTypes = {
	["sound"] = { extensions = { ".aac", ".aif", ".caf", ".wav" } },
	["stream"] = { extensions = { ".mp3", ".ogg" } },
}

--Forward references for our buttons/labels
local volumeLabel
local loopButton, playButton, stopButton

--Variables
local audioFiles = { "note2", "bouncing" } --Table to store what audio files are available for playback. (ie included in the app).
local audioLoaded, audioHandle = nil, nil --Variables to hold audio states.
local audioLoops = 0	--Variables to hold audio states.
local audioVolume = 0.5 --Variables to hold audio states.
local audioWasStopped = false -- Variable to hold whether or not we have manually stopped the currently playing audio.

--Set the initial volume to match our initial audio volume variable
audio.setVolume( audioVolume, { channel = 1 } )


--Handle slider events
local function sliderListener( event )
	local value = event.value
		    		    
	--Convert the value to a floating point number we can use it to set the audio volume	
	audioVolume = value / 100
	audioVolume = string.format('%.02f', audioVolume )
	
	--Update the volume text to reflect the new value
	volumeLabel.text = "Volume: " .. audioVolume
				
	--Set the audio volume at the current level
   	audio.setVolume( audioVolume, { channel = 1 } )
end

--Create a slider to control the volume level
local volumeSlider = widget.newSlider
{
	left = 50,
	top = 210,
	width = _W - 80,
	orientation = "horizontal",
	listener = sliderListener
}
group:insert(volumeSlider)

--Create our volume label to display the current volume on screen
volumeLabel = display.newText( "Volume: " .. audioVolume .. "0", centerX, volumeSlider.y -40, native.systemFontBold, 18 )
group:insert(volumeLabel)
-- Set up the Picker Wheel's columns
local columnData = 
{ 
	{ 
		align = "left",
		width = 190,
		startIndex = 1,
		labels = audioFiles,
	},

	{
		align = "right",
		width = 90,
		startIndex = 1,
		labels = supportedAudio[ platform ].extensions,
	},
}

--Create the picker which will display our audio files & extensions
local audioPicker = widget.newPickerWheel
{
	top = display.contentHeight - 222, 	
	width = 300,
	font = native.systemFontBold,
	columns = columnData,
}


--Function to handle all button events
local function manageButtonEvents( event )
	local phase = event.phase
	local buttonPressed = event.target.id
	
	if phase == "began" then
		--Loop Button
		if buttonPressed == "loopAudio" then
			--Toggle the buttons state ( 1 or 0 )
			loopButton.toggle = 1 - loopButton.toggle
			
			--If loop is set to on
			if loopButton.toggle == 1 then
				--Set the audio to loop forever
				audioLoops = -1
				
				--Set the buttons label to true
				--loopButton:setLabel( "Loop: Yes" )
				
				--Update status text
				statusText.text = "Audio will loop forever"
				
				--If there is audio playing, stop it so that when it is played again it will reflect the change in loop setting
				if audio.isChannelPlaying( 1 ) then
					audio.stop( 1 )
				end
			--If loop is set to off
			else
				--Set the audio to not loop
				audioLoops = 0
				
				--Set the buttons label to false
				--loopButton:setLabel( "Loop: No" )
				
				--Update status text
				statusText.text = "Audio will play once"
				
				--If there is audio playing, stop it so that when it is played again it will reflect the change in loop setting
				if audio.isChannelPlaying( 1 ) then
					audio.stop( 1 )
				end
			end

		
		--Play button
		elseif buttonPressed == "PlayAudio" then
			--Toggle the buttons state ( 1 or 0 )
			playButton.toggle = 1 - playButton.toggle
			
			--Function to reset the play button state when audio completes playback
			local function resetButtonState()
				playButton:setLabel( "Play" ); 
				playButton.toggle = 0
				
				--Only update the status text to finished if we didn't stop the audio manually
				if audioWasStopped == false then
					--Update status text
					statusText.text = "Playback finished on channel 1"
				end
				
				--Set the audioWasStopped flag back to false
				audioWasStopped = false
			end
				
			--Audio playback is set to paused		
			if playButton.toggle == 0 then
				--Pause any currently playing audio
				if audio.isChannelPlaying( 1 ) then
					audio.pause( 1 )
				end
				
				--Set the buttons label to "Resume"
				playButton:setLabel( "Resume" )
				
				--Update status text
				statusText.text = "Audio paused on channel 1"
				
			--Audio playback is set to play	
			else
				--If the audio is paused resume it
				if audio.isChannelPaused( 1 ) then
					audio.resume( 1 )
					
					--Update status text
					statusText.text = "Audio resumed on channel 1"
					
				--If not play it from scratch
				else
				 	local audioFileSelected = audioPicker:getValues()[1].index
				 	local audioExtensionSelected = audioPicker:getValues()[2].index
					
					--Print what sound we have loaded to the terminal
					print( "Loaded sound:", audioFiles[ audioFileSelected ] .. supportedAudio[ platform ].extensions[ audioExtensionSelected ] )
					
					--If we are trying to load a sound, then use loadSound
					if supportedAudio[ platform ].extensions[ audioFileSelected ] == loadTypes[ "sound" ].extensions[ audioExtensionSelected ] then
						--Load the audio file fully into memory
						audioLoaded = audio.loadSound( audioFiles[ audioFileSelected ] .. supportedAudio[ platform ].extensions[ audioExtensionSelected ] )
						--Play audio file
						audioHandle = audio.play( audioLoaded, { channel = 1, loops = audioLoops, onComplete = resetButtonState } )
					else
						--Load the audio file in chunks
						audioLoaded = audio.loadStream( audioFiles[ audioFileSelected ] .. supportedAudio[ platform ].extensions[ audioExtensionSelected ] )
						--Play the audio file
						audioHandle = audio.play( audioLoaded, { channel = 1, loops = audioLoops, onComplete = resetButtonState } )
					end
					
					--Update status text
					statusText.text = "Audio playing on channel 1"
				end
				
				--Set the buttons label to "Pause"
				playButton:setLabel( "Pause" )
			end

			--Stop button
			elseif buttonPressed == "StopAudio" then
				--If there is audio playing on channel 1
				if audio.isChannelPlaying( 1 ) then
					--Stop the audio
					audio.stop( 1 )
					
					--Let the system know we stopped the audio manually
					audioWasStopped = true
					
					--Update status text
					statusText.text = "Stopped Audio on channel 1"
					
				--No audio currently playing
				else
					--Update status text
					statusText.text = "No Audio playing to stop!"
				end
			end
		end
	
	return true
end


--Play/pause/resume Button
playButton = widget.newButton{
	id = "PlayAudio",
	style = "sheetBlack",
	label = "Play",
	yOffset = - 3,
	fontSize = 24,
	emboss = true,
	width = 140,
	onEvent = manageButtonEvents,
}
playButton.toggle = 0
playButton.x, playButton.y = playButton.contentWidth * 0.5 + 10, 80
group:insert(playButton)

--Stop button
stopButton = widget.newButton{
	id = "StopAudio",
	style = "sheetBlack",
	label = "Stop",
	yOffset = - 3,
	fontSize = 24,
	emboss = true,
	width = 140,
	onEvent = manageButtonEvents,
}
stopButton.x, stopButton.y = display.contentWidth - stopButton.contentWidth * 0.5 - 10, 80
group:insert(stopButton)

--Loop Button
--loopButton = widget.newButton{
--	id = "loopAudio",
--	style = "sheetBlack",
--	label = "Loop: No",
--	yOffset = -3,
--	fontSize = 24,
--	emboss = true,
--	width = 140,
--	onEvent = manageButtonEvents,
--}
--loopButton.toggle = 0
--loopButton.x, loopButton.y = display.contentCenterX, stopButton.y + stopButton.contentHeight + loopButton.contentHeight * 0.5 - 10
--group:insert(loopButton)
	        
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




