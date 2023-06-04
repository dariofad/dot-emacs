(message "Emacs startup")

;; reading host-name
(setq host-name
      (substring 
       (shell-command-to-string "hostname") 
       0 -1))

;; set t_checker to 1 if EMACS_BOOTED is defined, nil otherwise
(setq t_checker (boundp' EMACS_BOOTED))

;; cold boot
(if (eq nil t_checker)
    (progn

      ;; init packages
      (package-initialize)

      ;; use ahead-of-time native compilation if available
      (setq package-native-compile t)

      ;; setup archives
      (add-to-list 'package-archives
		   '("melpa-stable" . "https://stable.melpa.org/packages/"))
      (add-to-list 'package-archives
		   '("melpa" . "https://melpa.org/packages/"))

      ;; use-package installation
      (unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

      ;; enable verbose mode (use-package) 
      (setq use-package-verbose t)      
      )
  )

;; vanilla emacs + use-package successfully bootstrapped
(setq EMACS_BOOTED 1)   

;; int helper to load packages
(load-file "~/.emacs.d/init-helper.el")

;; all the packages have been loaded, and the init procedure is
;; complete
(setq EMACS_PACKAGES_LOADED 1)

(setq inhibit-startup-echo-area-message "Emacs started!")


;; AUTO-GENERATED CONTENT
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(add-hook 'cmake-mode-hook t)
 '(auth-source-save-behavior nil)
 '(company-show-quick-access t nil nil "Customized with use-package company")
 '(custom-enabled-themes '(wombat))
 '(package-selected-packages
   '(org-roam paredit magit visual-fill-column valign org-present org-variable-pitch org-bullets gif-screencast powerline mozc deno-fmt prettier-js web-mode json-mode rust-mode lsp-pyright lsp-treemacs lsp-ui lsp-mode envrc go-mode go-mode-hook rotate counsel-projectile yasnippet direnv flycheck which-key visual-regexp treemacs emacs-rotate ivy-posframe company-reftex latex-extra company-math company-auctex latex tex-site multiple-cursors jedi company-quickhelp company-box free-keys counsel ace-link use-package smex ido-vertical-mode expand-region company ace-window))
 '(safe-local-variable-values
   '((reftex-default-bibliography . "./bibliography.bib")
     (TeX-master . main\.tex)
     (reftex-default-bibliography . "../../bib/biblio.bib")
     (reftex-default-bibliography . "../../../../bib/biblio.bib")
     (reftex-default-bibliography . "../../../bib/biblio.bib")
     (reftex-default-bibliography . "../../biblio.bib")
     (reftex-default-bibliography . "./biblio.bib")
     (reftex-default-bibliography . "../biblio.bib")
     (reftex-default-bibliography . "../../bibliof.bib")
     (reftex-default-bibliography . "bibliof.bib")
     (reftex-default-bibliography . "../bibliof.bib")
     (reftex-default-bibliography . "biblio.bib")
     (reftex-default-bibliography . "../bib/biblio.bib")
     (reftex-default-bibliography . "./bib/biblio.bib")))
 '(tramp-default-method "scp")
 '(tramp-encoding-shell "/bin/bash"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:foreground "deep sky blue" :bold t :height 3.0))))
 '(company-tooltip ((t (:background "black" :foreground "white"))))
 '(company-tooltip-common ((t (:hinerit))))
 '(company-tooltip-common-selection ((t (:hinerit))))
 '(company-tooltip-scrollbar-thumb ((t (:background "white"))))
 '(company-tooltip-scrollbar-track ((t (:background "yellow"))))
 '(company-tooltip-selection ((t (:backgroud "red" :foreground "red"))))
 '(fixed-pitch ((t (:family "Inconsolata for Powerline" :slant normal :weight normal :height 120 :width normal))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.15))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.05))))
 '(variable-pitch ((t (:family "Hack" :height 120 :weight light)))))
(put 'upcase-region 'disabled nil)
