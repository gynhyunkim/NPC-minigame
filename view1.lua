-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local cX, cY = display.contentWidth * 0.5 , display.contentHeight * 0.5
	
	local cardImage = {"image/1.png", "image/2.png", "image/3.png", "image/4.png", "image/5.png"}
	local cardNum = {4, 4, 4, 4, 4}
	local card = {}
	local back = {}

	local bg = display.newRect(cX, cY, 1280, 720)
	bg:setFillColor(1)
	sceneGroup:insert(bg)

	-- 배치할 카드 고르는 함수
	local function pick()
		local i = -1
		while i == -1 do
			i = math.random(1, 5)
			if cardNum[i] > 0 then
				cardNum[i] = cardNum[i] - 1
				return i
			end
			i = -1
		end
		return -2
	end

	local selected = -1
	local cnt = 0

	-- 터치 이벤트 구현
	local function select( event )
		local obj = event.target
		local idx = obj.name
		
		card[idx].alpha = 1
		if (selected ~= -1) then
			if (selected ~= idx and card[selected].name == card[idx].name) then
				print(equal)
				transition.to(card[selected], {delay = 400, alpha = 0, time = 30})
				transition.to(card[idx], {delay = 400, alpha = 0, time = 30})
				transition.to(obj, {delay = 400, alpha = 0, time = 0})
				transition.to(back[selected], {delay = 400, alpha = 0, time = 0})
				selected = -1
				cnt = cnt + 1
				if (cnt == 10) then
					composer.gotoScene("success", {effect = "fade", time = 500})
				end
			elseif (selected ~= idx) then
				transition.to(card[selected], {delay = 400, alpha = 0, time = 30})
				transition.to(card[idx], {delay = 400, alpha = 0, time = 30})
				selected = -1
			end
		else
			selected = idx
		end
		print(obj.name)
		return true
	end

	-- 카드 앞면, 뒷면 배치
	local backGroup = display.newGroup()
	local cardGroup = display.newGroup()
	local newX, newY = cX - 155, cY - 255
	for i = 1, 20 do
		local n = pick()
		card[i] = display.newImage(cardGroup, cardImage[n])
		card[i].name = n
		card[i].x, card[i].y = newX, newY
		back[i] = display.newImageRect(backGroup,"image/cover.png", 75, 125)
		back[i].name = i
		back[i].x, back[i].y = newX, newY
		back[i]:addEventListener("tap", select)
		transition.to(card[i], {time = 0, xScale = 0.5, yScale = 0.5})
		newX = newX + 80
		if i % 5 == 0 then
			newX = cX - 155
			newY = newY + 130
		end
		cardGroup:insert(card[i])
	end

	sceneGroup:insert(backGroup)
	sceneGroup:insert(cardGroup)

	
	-- 1.5초 후에 카드 숨기기
	local function onTimer( event )
		for i = 1, #card do
			card[i].alpha = 0
		end
 	end


	timer.performWithDelay(1500, onTimer)

	local function setTimer()
		local time = 30

		local text_num = display.newText(
		{	text = "남은 시간 : "..tostring(time),
			x = 1150,
			y = 50,
			font = "fonts/SeoulNamsanB.ttf",
			fontSize = 25 })
		text_num:setFillColor(0)
		sceneGroup:insert(text_num)

		local function gameTimer()
			time = time - 1
			if (time == 0) then	
				composer.gotoScene("fail", {effect = "fade", time = 500})
			end
			text_num.text = "남은 시간 : "..tostring(time)
		end
	
		gt = timer.performWithDelay(1000, gameTimer, -1)
	end
	
	timer.performWithDelay(1500, setTimer)
	
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
		composer.removeScene("view1")
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