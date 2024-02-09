------------------------------------------
--  Mami Tomoe's CS2D No Reload Script  --
--         Signed on 28/01/2022         --
------------------------------------------

-- Configuration:
-- You can set this variable to `true` if
-- you wish for all weapons to have infinite ammo.
local infAmmo			= { 1, 45, 3, 2 }
-- Recommended to be set at 33%, any higher will
-- cause more traffic and has no practical use.
-- Lower will support laggier players, but 33%
-- is the sweet spot.
local refillMultiplier	= 0.33


-- Initialise workspace:
mt = mt or { }
mt.NoReload = mt.NoReload or { }


-- Local functions:
local function AmmoRefill(p, wpnType)
	local ammoIn, _	= playerammo(p, wpnType)
	local minAmmo	= itemtype(wpnType, 'ammoin') * refillMultiplier

	if ammoIn <= minAmmo then
		 parse('setammo ' .. p .. ' ' .. wpnType .. ' 999 999')
	end
end


-- Hooks:
function mt.NoReload.attack_hook(p)
	local wpnType = player(p, 'weapontype')

	if infAmmo == true or infAmmo[wpnType] then
		AmmoRefill(p, wpnType)
	end
end


-- Module API:
local function init()
	if infAmmo ~= true then
		-- Quicker table access.
		local t = { }

		for i = 1, #infAmmo do
			t[infAmmo[i]] = true
		end

		infAmmo = t
	end

	-- Enable infinite ammo.
	parse('mp_infammo 1')
	-- Hide ammo on HUD.
	parse('mp_hud 119')
	-- Sadly cannot hide ammo on dropped items.
	-- parse('mp_hovertext 15')

	-- Hooks.
	addhook('attack',	'mt.NoReload.attack_hook')
end

init()
