local dynomark = try_require("dynomark")
if dynomark then
    dynomark.setup({
        results_view_location = "float",
    })
end
