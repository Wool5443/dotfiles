return
{
    "pogyomo/cppguard.nvim",
    dependencies = {
        "L3MON4D3/LuaSnip" -- If you're using luasnip.
    },
    config = function()
        local luasnip = require("luasnip")
        luasnip.add_snippets("cpp", {
            require("cppguard").snippet_luasnip("guard")
        })
    end
}
