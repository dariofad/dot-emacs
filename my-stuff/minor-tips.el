;; removing bell sound and 
(setq bell-volume 0)
;; subtly flash the modeline when something is wrong
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

;; turn on absolute line numbers
;; (setq display-line-numbers t)
(global-linum-mode t)
;; (global-display-line-numbers-mode)   

;; enable camel-case inner-to-word micro-movement
(global-subword-mode 1)

;; display basic info in modeline
(display-battery-mode 1)
(setq display-time-default-load-average nil)
(setq display-time-24hr-format 1)
(display-time-mode 1)

;; disable company mode for remote buffers
(add-hook 'eval-after-load 'dariofad/disable-company-mode-for-remote-buffers)

;; cliboard adjustments
(setq select-enable-clipboard t)
(setq select-enable-primary t)
(setq save-interprogram-paste-before-kill t)

;; disable menu bar, scrollbar and toolbar
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
