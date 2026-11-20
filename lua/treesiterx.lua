-- Cambiar el color de las líneas plegadas (texto y fondo)
vim.api.nvim_set_hl(0, "Folded", { 
    fg = "#7aa2f7", 
    bg = "#1f2335", 
    italic = true   
})

-- Cambiar el color de la columna lateral de folds
vim.api.nvim_set_hl(0, "FoldColumn", { 
    fg = "#565f89", 
    bg = "NONE"     
})

-- Cambiar colores de paréntesis coincidentes
vim.api.nvim_set_hl(0, "MatchParen", { bg = "#3b4211", fg = "#88c0d0", bold = true })
