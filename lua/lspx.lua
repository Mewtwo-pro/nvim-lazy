
-- ======================================================
--  MASON (gestor de LSPs)
-- ======================================================
vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})
-- Desactiva todos los diagnósticos globalmente
vim.diagnostic.enable(false)
vim.diagnostic.config({
  virtual_text = false,     -- Oculta el texto flotante al final de la línea
  signs = false,            -- Oculta los iconos de la columna izquierda
  underline = false,        -- Quita el subrayado de los errores/advertencias
  update_in_insert = false, -- No actualizar mientras escribes
})
    
-- atajos lsp 
vim.keymap.set('n', 'k', vim.lsp.buf.definition, { desc = 'Ir a la definición' })
vim.keymap.set('n', 'y', vim.lsp.buf.hover, { desc = 'Mostrar documentación (Hover)' })
vim.keymap.set("n", "bx", vim.lsp.buf.rename, {
    desc = "Renombrar variable LSP"
})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.cpp", "*.hpp", "*.c", "*.h" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
