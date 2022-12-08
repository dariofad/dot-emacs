;; use ibuffer instead of default function
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; window resizing
;; horizontal
(global-set-key (kbd "s-[") (lambda() (interactive)(shrink-window-horizontally 3)))
(global-set-key (kbd "s-]") (lambda() (interactive)(enlarge-window-horizontally 3)))
;; vertical
(global-set-key (kbd "s-{") (lambda() (interactive)(shrink-window 2)))
(global-set-key (kbd "s-}") (lambda() (interactive)(enlarge-window 2)))

;; ace-window
(global-set-key (kbd "M-o") 'ace-window)

;; reduce and increase font size quickly
(global-set-key (kbd "s-+") (lambda() (interactive)(text-scale-increase 1)))
(global-set-key (kbd "s--") (lambda() (interactive)(text-scale-decrease 1)))

;; ivy-based interface to standard commands
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f8> l") 'counsel-find-library)
(global-set-key (kbd "<f8> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f8> u") 'counsel-unicode-char)
(global-set-key (kbd "<f8> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

;; ivy-based interface to shell and system tools
(global-set-key (kbd "C-c c") 'counsel-compile)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c L") 'counsel-git-log)
(global-set-key (kbd "C-c m") 'counsel-linux-app)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-c J") 'counsel-file-jump)

;; ivy-resume and other commands
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-c b") 'counsel-bookmark)
(global-set-key (kbd "C-c d") 'counsel-descbinds)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c o") 'counsel-outline)
(global-set-key (kbd "C-c t") 'counsel-load-theme)
(global-set-key (kbd "C-c F") 'counsel-org-file)
(global-set-key (kbd "C-^") 'completion-at-point)

;; avy
(global-set-key (kbd "C-'") 'avy-goto-char)
(global-set-key (kbd "C-:") 'avy-goto-char-2)
(global-set-key (kbd "M-g a") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)

;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

;; eshell
(global-set-key (kbd "C-!") 'ddoeh/Open-Eshell-Here)
(global-set-key (kbd "s-e") 'eshell)

;; toggle mozc mode
(global-set-key (kbd "<f7>") 'mozc-mode)

;; media (gif-screencast)
(global-set-key (kbd "M-<f8>") 'gif-screencast-start-or-stop)
