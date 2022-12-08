;; set style
 (setq c-default-style "linux"
          c-basic-offset 8)

;; hook lsp to c mode
(add-hook 'c-mode-hook 'ddslsp/dariofad-Start-LSP-mode)

;; hook lsp to cpp mode
(add-hook 'c++-mode-hook 'ddslsp/dariofad-Start-LSP-mode)

;; LANGUAGE SERVER (HINTS)

;; remember to install the proper language server

;; prerequisite/recommended: clangd (currently clangd-14)

;; clangd must be available system wide

;; you can check with: (executable-find "clangd")

;; INCLUDES (HINTS)

;; clangd is used by lsp-mode independently to the build system

;; clangd requires a file named compile_commands.json to resolve
;; includes properly

;; no idea about it -> check the `bear` package
;; run `bear -- make $OPTIONS..` to have an idea how the
;; compile_commands.json should look like

;; LINUX KERNEL (BASIC CONFIG)

;; to generate compile_commands.json first build the kernel using
;; clang (e.g., make CC=clang)

;; then use the gen_compile_commands.py to generate it (e.g., run
;; `./scripts/clang-tools/gen_compile_commands.py` from the root of
;; the project)
