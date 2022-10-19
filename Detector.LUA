-- This line gets the Selection Service, which allows the program to see what you have selected when calling the Selection:Get() Function.
local Selection = game:GetService("Selection")


-- Creates a new Button Catagory/Toolbar named Augustus Import Detector
local toolbar = plugin:CreateToolbar("Augustus Import Detectors")

-- Creates two buttons in the catagory mentioned above, they are the Simple Import Detector, and Advanced Import Detector.
-- The First Parameter is the name
-- Second is the description.
-- Third is the asset id used for the logo.
local SimpleButton = toolbar:CreateButton("Simple Import Detector", "For Quick Detection", "rbxassetid://4458901886")
local AdvancedButton = toolbar:CreateButton("Advanced Import Detector", "Only if you know Lua.", "rbxassetid://4458901886")
-- Makes the button clickable even if the workspace is hidden
SimpleButton.ClickableWhenViewportHidden = true
AdvancedButton.ClickableWhenViewportHidden = true
-- Function for when the Simple Import Detector Button gets clicked.
function onSimpleButtonClicked()
	-- Gets the selected Objects.
	local selectedObjects = Selection:Get()
	-- Sets the amount of scripts flagged to 0.
	local RequireAmount = 0
	local AssetAmount = 0
	-- Executes the below if the Selected Objects is more than 0.
	if #selectedObjects > 0 then
		-- Foreach loop for flagging scripts.
		for k,v in selectedObjects do
			-- Gets the script's code.
			local ScriptContents = v.source
			-- Finds "require" and "rbxassetid://", and if it does it increases the flagged script count by 1.
			if string.find(ScriptContents, "require") then
				RequireAmount = RequireAmount + 1
			end
			if string.find(ScriptContents, "rbxassetid://") then
				AssetAmount = AssetAmount + 1
			end
		end
		-- Says how many scripts were flagged.
		print("There are " .. RequireAmount .. " Scripts importing other scripts.")
		print("There are " .. AssetAmount .. " Scripts importing Assets (Models, Images, Videos, Audios)") 
		print("If you KNOW lua, you should investigate the imports or use the Advanced Detector")
		print("If you DONT KNOW lua, you should delete the model.")
		
	end
	end
function onAdvancedButtonClicked()
		-- Gets the amount of objects selected.
	local selectedObjects = Selection:Get()
		-- Initiates the amounts flagged.
		local RequireAmount = 0
		local RbxAssetAmount = 0
	-- Same thing as top.
		if #selectedObjects > 0 then
			for k,v in selectedObjects do

				local ScriptContents = v.source
				if string.find(ScriptContents, "require") then
					RequireAmount = RequireAmount + 1
				end
				if string.find(ScriptContents, "rbxassetid://") then
					RbxAssetAmount = RbxAssetAmount + 1
				end
			
		end
		-- Same thing as top except more complex explanation.
			print("There are " .. RequireAmount .. " Mentions of the 'require' keyword, which is used in importing scripts.")
			print("There are " .. RbxAssetAmount .. " Mentions of 'rbxassetid://', which is a way to import Models, Audio Files, Videos, and Images.")
			print("If you DONT KNOW lua, Use the Simple Detector, and you should probably delete this model.")
			print("If you DO know lua, you should investigate more and maybe delete the model.")
			end
end

-- Connects button to function.
SimpleButton.Click:Connect(onSimpleButtonClicked)
AdvancedButton.Click:Connect(onAdvancedButtonClicked)
	
