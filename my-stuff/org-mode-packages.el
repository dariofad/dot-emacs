;; major mode
(use-package org
  :ensure t
  :config
  ;; enable visual-line-mode for org-buffers
  (add-hook 'org-mode-hook 'visual-line-mode)
  ;; hide (emphasis) formatter
  (setq org-hide-emphasis-markers t)
  ;; customize indentation
  (setq org-startup-indented t)
  ;; customize headline height
  (custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.15))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.10))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.05)))))
  ;; suppress html validation link
  (setq org-html-validation-link nil)
  )

;; bullets
(use-package org-bullets
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

;; pitch-mode
(use-package org-variable-pitch
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'org-variable-pitch-minor-mode)
  )
