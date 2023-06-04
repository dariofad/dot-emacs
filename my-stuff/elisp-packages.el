;; structured editing of S-expression 
(use-package paredit
  :ensure t
  :config

  ;; enable paredit in elisp and lisp buffers
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)  
  (add-hook 'lisp-interaction-mode-hook 'paredit-mode)
  (add-hook 'ielm-mode-hook 'paredit-mode)
  (add-hook 'lisp-mode-hook 'paredit-mode)
  
  ;; change some of the default keybindings
  (add-hook 'paredit-mode-hook
	    (defun dd-paredit-key-configuration ()
	      
	      ;; default operations
	      ;; (     -> paredit-open-round
	      ;; [     -> paredit-open-square
	      ;; {     -> paredit-open-curly
	      ;; )     -> paredit-close-round
	      ;; ]     -> paredit-close-square
	      ;; }     -> paredit-close-curly
	      ;; "     -> double-quote
	      ;; M-(   -> paredit-wrap-round
	      ;; M-"   -> paredit-meta-doublequote
	      ;; C-d   -> paredit-forward-delete
	      ;; M-d   -> paredit-forward-kill-word
	      ;; DEL   -> paredit-backward-delete
	      ;; M-DEL -> paredit-backward-kill-word
	      ;; C-k   -> paredit-kill

	      ;; slurping and barfing
	      ;; C-)   -> paredit-forward-slurp-sexp
	      ;; C-}   -> paredit-forward-barf-sexp
	      ;; C-(   -> paredit-backward-slurp-sexp
	      ;; C-{   -> paredit-backward-barf-sexp

	      ;; non-default keybindings
	      (local-set-key (kbd "C-M f") 'paredit-forward)
	      (local-set-key (kbd "C-M b") 'paredit-backward)
	      (local-set-key (kbd "C-M d") 'paredit-forward-down)
	      (local-set-key (kbd "C-M u") 'paredit-backward-up)
	      (local-set-key (kbd "C-M p") 'paredit-backward-down)
	      (local-set-key (kbd "C-M n") 'paredit-forward-up)
	      (local-set-key (kbd "C-M <up>") 'paredit-splice-sexp-killing-backward)
	      (local-set-key (kbd "C-M <down>") 'paredit-splice-sexp-killing-forward)
	      (local-set-key (kbd "M s") 'paredit-splice-sexp)
	      (local-set-key (kbd "M S") 'paredit-split-sexp)
	      (local-set-key (kbd "M J") 'paredit-join-sexps))))
