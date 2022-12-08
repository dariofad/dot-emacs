;; prerequisite: npm

;; hook lsp to bash mode
(add-hook 'sh-mode-hook 'ddslsp/dariofad-Start-LSP-mode)

;; the default language server (bash-ls) will be installed automatically
