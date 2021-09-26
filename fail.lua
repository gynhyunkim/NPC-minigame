local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local cX, cY = display.contentWidth * 0.5 , display.contentHeight * 0.5
	
	local bg = display.newRect(cX, cY, 1280, 720)
	bg:setFillColor(1)
	sceneGroup:insert(bg)

	local game_name = display.newText("실패 !!", cX, cY * 0.9, native.systemFont, 64)
	game_name:setFillColor(0)
	sceneGroup:insert(game_name)

	local start = display.newText("재시작", cX, cY * 1.05, native.systemFont, 40);
	start:setFillColor(0.1)
	sceneGroup:insert(start) 

	local function game_start( event )
		composer.gotoScene("view1")
	end

	start:addEventListener("tap", game_start)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene