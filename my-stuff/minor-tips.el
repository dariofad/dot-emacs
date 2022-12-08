;; disable the bell sound
(setq bell-volume 0)

;; disable the flash in the modeline when something is wrong
(setq ring-bell-function
      (lambda ()
        (let ((orig-fg (face-foreground 'mode-line)))
          (set-face-foreground 'mode-line "#F2804F")
          (run-with-idle-timer 0.1 nil
                               (lambda (fg) (set-face-foreground 'mode-line fg))
                               orig-fg))))

;; always display *Help* in current window
(add-to-list 'display-buffer-alist
             '("*Help*" display-buffer-same-window))

;; use absolute line numbers
(global-linum-mode t)

;; enable camel-case inner-to-word movement
(global-subword-mode 1)

;; disable company mode for remote buffers
(add-hook 'eval-after-load 'dariofad/disable-company-mode-for-remote-buffers)

;; cliboard
(setq select-enable-clipboard t)
(setq select-enable-primary t)
(setq save-interprogram-paste-before-kill t)

;; disable menu bar, scrollbar and toolbar
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
