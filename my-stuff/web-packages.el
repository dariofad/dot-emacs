;; major mode (web templates and scripts)
(use-package web-mode
  :ensure t
  :mode (("\\.js\\'" . web-mode)
	 ("\\.jsx\\'" . web-mode)
	 ("\\.ts\\'" . web-mode)
	 ("\\.tsx\\'" . web-mode)
	 ("\\.html\\'" . web-mode)
	 ("\\.htm\\'" . web-mode))
  :commands web-mode
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  )

;; deno formatter
(use-package deno-fmt
  :ensure t
  :config
  ;; enable auto-format for the following file extensions
  (add-hook 'web-mode-hook #'(lambda ()
			       (ddemm/Enable-Minor-Mode
				'("\\.jsx?\\'" . deno-fmt-mode))
			       (ddemm/Enable-Minor-Mode
				'("\\.tsx?\\'" . deno-fmt-mode))))
  )

;; hook lsp to web mode
(add-hook 'web-mode-hook 'ddslsp/dariofad-Start-LSP-mode)
