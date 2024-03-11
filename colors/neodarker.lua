-- for k in pairs(package.loaded) do
--     if k:match(".*neodarker.*") then
--         package.loaded[k] = nil
--     end
-- end

require("neodarker").colorscheme()
