return {
    "danymat/neogen",
    config = function()
        require('neogen').setup({
            enabled = true,
            langauages = {
                python = {
                    template = {
                        annotation_convention = 'google_docstrings'
                    }
                }
            }
        })
    end
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*" 
}
