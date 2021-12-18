;; rotations
(use-package rotate
  :ensure t
  :config
  ;; global window and layout rotations (also working for X application windows)
  (global-set-key (kbd "s-b") 'rotate-window) ;; blend
  (global-set-key (kbd "s-d") 'rotate-layout) ;; dislocate
  )

;; ace-window (window movement)
(use-package ace-window
  :ensure t
  :config
  (ace-window-display-mode)
  (setq aw-dispatch-always t)
  (defvar aw-dispatch-alist
  '((?x aw-delete-window "Delete Window")
	(?m aw-swap-window "Swap Windows")
	(?M aw-move-window "Move Window")
	(?c aw-copy-window "Copy Window")
	(?j aw-switch-buffer-in-window "Select Buffer")
	(?n aw-flip-window)
	(?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	(?c aw-split-window-fair "Split Fair Window")
	(?v aw-split-window-vert "Split Vert Window")
	(?b aw-split-window-horz "Split Horz Window")
	(?o delete-other-windows "Delete Other Windows")
	(?? aw-show-dispatch-help))
  "List of actions for `aw-dispatch-default'."))

;; blue bigs letters to mark windows (only working in textual buffers)
(custom-set-faces
 '(aw-leading-char-face ((t (:foreground "deep sky blue" :bold t :height 3.0)))))


;; counsel from MELPA (it brings ivy and swiper as dependency)
(use-package counsel
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  ;; suggest to counsel-find-file the file under cursor as first candidate 
  (setq counsel-find-file-at-point t))

;; theme set - avoid some coloring hues
(use-package dichromacy-theme
  :defer t
  :init (load-theme 'dichromacy t))

;; prints a map of free keys
(use-package free-keys
  :ensure t)

;; avy for fast jumps to text of all the displayed windows
(use-package avy
  :ensure t)

;; ace-link to jump quickly through links of documentation (and other formats...)
(use-package ace-link
  :ensure t
  :config
  (ace-link-setup-default))

;; expand-region to quickly highlight parenthesized text 
(use-package expand-region
  :ensure t)

;; tramp 
(use-package tramp
  :ensure t
  :config
  (setq tramp-default-method "ssh")
  (setq tramp-chunksize 10000)
  ;; avoid tramp backing up file (avoid accidental file exposure)
  (add-to-list 'backup-directory-alist
	       (cons tramp-file-name-regexp nil))
  )


;; useful to edit line tail and head, plus with keyboard macros
(use-package multiple-cursors         
  :ensure t                           
  :bind                               
  ("C-$" . mc/edit-lines)             
  ("C->" . mc/mark-next-like-this)    
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this)
  )


;; useful to interactively build a regexp, also allows to replace matches
(use-package visual-regexp
  :ensure t
  )
