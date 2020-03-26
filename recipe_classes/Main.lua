function Initialize(a_Plugin)
	a_Plugin:SetName("RecipeTest")
	a_Plugin:SetVersion(1)

	CreateRecipes()
	cPluginManager:AddHook(cPluginManager.HOOK_CRAFTING_NO_RECIPE, OnCraftingNoRecipe)
	return true
end


-- The hook for ingredients who has no bult-in recipe
function OnCraftingNoRecipe(a_Player, a_Grid, a_Recipe)
	if (CheckRecipes(a_Grid, a_Recipe)) then
		return true
	end
end


-- Loops over all custom recipes and looks for a match
function CheckRecipes(a_CraftingGrid, a_Recipe)
	for _, recipe in pairs(shapelessRecipes) do
		if (recipe:CheckIfMatch(a_CraftingGrid, a_Recipe)) then
			return true
		end
	end

	for _, recipe in pairs(shapedRecipes) do
		if (recipe:CheckIfMatch(a_CraftingGrid, a_Recipe)) then
			return true
		end
	end

	return false
end



-- Creates the two variables with custom recipes, shaped and shapeless
function CreateRecipes()
	shapelessRecipes =
	{
		cShapelessRecipe.new(cItem(E_ITEM_WATER_BUCKET, 2))
		:AddIngredient(1, E_ITEM_WATER_BUCKET)
		:AddIngredient(1, E_ITEM_BUCKET),

		cShapelessRecipe.new(cItem(E_ITEM_LAVA_BUCKET, 1))
		:AddIngredient(1, E_BLOCK_OBSIDIAN)
		:AddIngredient(1, E_ITEM_BLAZE_ROD)
		:AddIngredient(1, E_ITEM_FLINT_AND_STEEL)
		:AddIngredient(1, E_ITEM_BUCKET),

		cShapelessRecipe.new(cItem(E_ITEM_ENDER_PEARL, 2))
		:AddIngredient(4, E_BLOCK_COBBLESTONE),

		cShapelessRecipe.new(cItem(E_ITEM_BLAZE_ROD, 1))
		:AddIngredient(1, E_ITEM_RAW_FISH)
		:AddIngredient(1, E_ITEM_RAW_FISH, E_META_RAW_FISH_SALMON)
	}

	shapedRecipes =
	{
		cShapedRecipe.new(cItem(E_ITEM_BLAZE_ROD, 1))
		:Shape("S W", " X ", "W S")
		:SetIngredient("S", E_ITEM_RAW_FISH)
		:SetIngredient("W", E_ITEM_RAW_FISH, E_META_RAW_FISH_SALMON)
		:SetIngredient("X", E_BLOCK_OBSIDIAN),

		cShapedRecipe.new(cItem(E_BLOCK_OBSIDIAN, 1))
		:Shape(" S ","SBS"," S ")
		:SetIngredient("S", E_BLOCK_STONE)
		:SetIngredient("S", E_BLOCK_COBBLESTONE) -- Different item types for same char possible
		:SetIngredient("B", E_ITEM_BLAZE_ROD),

		cShapedRecipe.new(cItem(E_BLOCK_OBSIDIAN, 1))
		:Shape(" S","SB")
		:SetIngredient("S", E_BLOCK_STONE)
		:SetIngredient("S", E_BLOCK_COBBLESTONE) -- Different items types for same char possible
		:SetIngredient("B", E_ITEM_BLAZE_ROD),

		cShapedRecipe.new(cItem(E_BLOCK_END_PORTAL_FRAME, 1))
		:Shape("BIB","ECE","EEE")
		:SetIngredient("B", E_ITEM_BLAZE_ROD)
		:SetIngredient("I", E_ITEM_ENDER_PEARL)
		:SetIngredient("E", E_BLOCK_END_STONE)
		:SetIngredient("C", E_ITEM_CAULDRON),
	}
end
