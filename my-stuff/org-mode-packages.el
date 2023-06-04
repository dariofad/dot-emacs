;; major mode
(use-package org
  :ensure t
  :config
  ;; hide (emphasis) formatters
  (setq org-hide-emphasis-markers t)
  ;; customize indentation
  (setq org-startup-indented t)  
  ;; customize headline height
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.20))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.18))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.16))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.14))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.12)))))
  ;; suppress html validation link
  (setq org-html-validation-link nil)
  ;; larger latex formulas in preview mode
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.5))
  ;; do not use actual image width
  (setq org-image-actual-width nil)
  ;; preserve indentation
  (setq org-src-preserve-indentation t)
  ;; enable elisp and python evaluation with babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t))))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/git/notes/orgroam")
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 :map org-mode-map
	 ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup)
  (setq org-startup-with-latex-preview t)
  (setq org-startup-with-inline-images t))

;; bullets
(use-package org-bullets
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; pitch-mode
(use-package org-variable-pitch
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'org-variable-pitch-minor-mode)
  )

;; minimalist presentation environment
(use-package org-present
  :ensure t
  :after org
  )

;; visual table alignment
(use-package valign
  :ensure t
  :after (org org-present)
  :config
  (add-hook 'org-mode-hook #'valign-mode)
  (add-hook 'org-present-mode-hook #'valign-mode)  
  )

(use-package visual-fill-column
  :ensure t
  :after org-present
  )

;; a custom function to present org buffers as formatted slides
(defun dariofad/when-org-present-start ()
  ;; stop blinking the cursor
  (blink-cursor-mode 0)
  ;; adjust width and centering
  (setq visual-fill-column-width 130)
  (setq-default visual-fill-column-center-text t)
  ;; fix width and center text
  (visual-fill-column-mode 1)
  (visual-line-mode 1)
  ;; turn off line nummbers
  (linum-mode 0)
  ;; adjust font size
  (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
				     (header-line (:height 4.0) variable-pitch)
				     (org-document-title (:height 1.75) org-document-title)
				     (org-code (:height 1.5) org-code)
				     (org-verbatim (:height 1.5) org-verbatim)
				     (org-block (:height 1.5) org-block)
				     (org-block-begin-line (:height 0.7) org-block-begin-line)))
  ;; move the title of the slide down a little
  (setq header-line-format " ")
  ;; fold all regions containing meta attrs
  (ddvf/DDVimish-Fold))
(add-hook 'org-present-mode-hook 'dariofad/when-org-present-start)

;; remove customizations when exiting the presentation mode
(defun dariofad/when-org-present-end ()
  (blink-cursor-mode 1)
  (visual-fill-column-mode 0)
  (visual-line-mode 0)
  (linum-mode 1)
  (setq-local face-remapping-alist '((default variable-pitch default)))
  (setq header-line-format nil)
  (vimish-fold-delete-all))
(add-hook 'org-present-mode-quit-hook 'dariofad/when-org-present-end)

;; break slides with sub elements into smaller fragments
(defun dariofad/org-present-prepare-slide (buffername heading)
  ;; show top level
  (org-overview)
  ;; unfold current entry
  (org-show-entry)
  ;; show children without expanding
  (org-show-children)
  )
(add-hook 'org-present-after-navigate-functions 'dariofad/org-present-prepare-slide)
