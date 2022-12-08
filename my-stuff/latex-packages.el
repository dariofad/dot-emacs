;; auctex based setup

(use-package company-math
  :after (company)
  :ensure t
  :init
  (add-to-list 'company-backends 'company-math-symbols-latex)
  (add-to-list 'company-backends 'company-latex-commands))

(use-package company-reftex
  :after (company)
  :ensure t
  :init
  (add-to-list 'company-backends 'company-reftex-labels)
  (add-to-list 'company-backends 'company-reftex-citations))
  
(use-package latex-extra
  :ensure t
  :hook
  (LaTeX-mode . latex-extra-mode)
  (latex-mode . latex-extra-mode))

;; always use pdflatex
(with-eval-after-load "tex"
  (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
  (setq reftex-use-external-file-finders t)
  (TeX-global-PDF-mode 1)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'latex-mode-hook 'turn-on-reftex)  
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq reftex-plug-into-AUCTeX t)
  )

;; hook company mode to latex mode
(add-hook 'LaTeX-mode-hook 'company-mode)
