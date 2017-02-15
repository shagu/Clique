--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but
  can also be used to add functionality to the system through a manner of hooks.

  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

local Plugin = Clique:NewModule("pfUI")
Plugin.fullname = "pfUI UnitFrames"
Plugin.url = "https://github.com/shagu/pfUI"

function Plugin:Test()
  return pfUI and pfUI.uf
end

function Plugin:OnEnable()
  pfUI.uf.ClickActionOld = pfUI.uf.ClickAction
  pfUI.uf.ClickAction = Plugin.OnClick
end

function Plugin:OnDisable()
  pfUI.uf.ClickAction = pfUI.uf.ClickActionOld
end

function Plugin:OnClick()
  local button = arg1
  local label = this.label or ""
  local id = this.id or ""
  local unit = label .. id

  if not Clique:OnClick(button, unit) then
    pfUI.uf:ClickActionOld(button)
  end
end
