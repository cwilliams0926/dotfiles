return {
    "barrett-ruth/live-server.nvim",
    build = "npm i -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = function()
        vim.g.live_server = {
            port = 5500,
            browser = "google-chrome",
        }
    end,
}
