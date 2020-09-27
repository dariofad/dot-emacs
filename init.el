(message "Bootstrapping emacs")

;; reading hostname
(setq host-name
      (substring 
       (shell-command-to-string "hostname") 
       0 -1))

;; will be used to check whether Emacs was already started
(setq t_checker (boundp' EXWM_REFRPACKAGE))

;; packages global configuration (executed only once)
(if (eq nil t_checker) 
    (progn
      (require 'package)
      ;; add melpa stable
      (eval-when-compile
	(add-to-list 'package-archives
		     '("melpa-stable" . "https://stable.melpa.org/packages/"))
	(add-to-list 'package-archives
		     '("melpa" . "https://melpa.org/packages/"))      
	)
      ;; initialize packages
      (package-initialize)
      )
  )

(setq use-package-verbose t)

;; EXWM bootstrap - window manager section (executed only once)
;; (NOTE1: this config is useful when the window manager is not the same for all hosts, based on the selected XXX.desktop entry selected at login the right WM is loaded properly)
;; (NOTE2: at the moment no Emacs server is used, this could be a little annoying when emacs hangs)
(if (or (string= host-name "bukamon") (string= host-name "tentomon") (string= host-name "greymon"))
    (if (eq nil t_checker)
	(progn
	  ;; The window manager (EXWM) is complemented with by a list of gnome utilities (provided by the gnome-flashback package).
	  ;; Also remind to disable gnome hotkeys (we will no longer need them).
	  ;; The gnome-flashback packet should be installed using apt, and then the repository exwm-gnome-flashback should be cloned and installed.
	  (use-package exwm
	    :ensure t
	    :commands (ace-window)
	    :config
	    (require 'exwm-config)
	    (exwm-config-default)
	    )
	  ;; RandR multi-monitor support some hosts (rotation can also be managed with by gnome-control-center, if you have issues you can also use nvidia-settings to manually generate and merge new xorg config file)
	  ;; (here we only tell exwm there are two monitors that need to be used)
	  (if (or (string= host-name "greymon"))
	      (progn
	  	(require 'exwm-randr)
	  	(setq exwm-randr-workspace-output-plist
	  	      '(0 "HDMI-1" 1 "HDMI-2"))
	  	(add-hook 'exwm-randr-screen-change-hook
	  		  (lambda ()
	  		    (start-process-shell-command
	  		     "xrandr" nil "xrandr --output VGA-1 --off --output HDMI-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output HDMI-2 --mode 2560x1440 --pos 2560x0 --rotate left")))
	  	(exwm-randr-enable)
	  	)  )
	  ;; enable exwm
	  (exwm-enable)
	  ;; load other packages useful when exwm is active
	  (load-file "~/.emacs.d/my-stuff/exwm-config-and-keybindings.el")
	  ))
  ()
  )

;; set successful exwm bootstrap
(setq EXWM_REFRPACKAGE 1)   

;; WM setup done, now loading all other packages
(load-file "~/.emacs.d/init-helper.el")

(setq inhibit-startup-echo-area-message "Startup complete")
