;; always kill current buffer
(defun ddkcb/Kill-Curr-Buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'ddkcb/Kill-Curr-Buffer)

;; kill current word
(defun ddkiw/Kill-Inner-Word ()
  "Kill the word where the point is located."
  (interactive)
  (forward-char 1)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w k") 'ddkiw/Kill-Inner-Word)

;; insert line in the ring buffer
(defun ddcwl/Copy-Whole-Line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point-at-bol)
      (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'ddcwl/Copy-Whole-Line)

;; copy the current line from the point to the end
(defun ddcteol/Copy-To-End-Of-Line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point)
      (point-at-eol)))))
(global-set-key (kbd "C-c w e") 'ddcteol/Copy-To-End-Of-Line)

;; set the focus to the new window after an horizonal split
(defun ddsfh/Split-and-Follow-Horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'ddsfh/Split-and-Follow-Horizontally)

;; set the focus to the new window after a vertical split
(defun ddsfv/Split-and-Follow-Vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'ddsfv/Split-and-Follow-Vertically)

;; clear kill-ring
(defun ddckr/Clear-Kill-Ring ()
  (interactive)
  (setq kill-ring nil)
  (message "kill-ring cleared")
  )

;; kill slack
(defun ddksla/Kill-SLAck ()
  (interactive)
  (call-process-shell-command "kill -9 $(ps -aux | grep -i 'slack' | grep -v 'grep' | awk '{ print $2 }')" nil 0)
  )

;; kill skype
(defun ddksky/Kill-SKYpe ()
  (interactive)
  (call-process-shell-command "kill -9 $(ps -aux | grep -i 'skype' | grep -v 'grep' | awk '{ print $2 }')" nil 0)
  )

;; kill teams
(defun ddktea/Kill-microsoft-TEAms ()
  (interactive)
  (call-process-shell-command "kill -9 $(ps -aux | grep -i 'teams' | grep -v 'grep' | awk '{ print $2 }')" nil 0)
  )

;; kill zoom
(defun ddkzoo/Kill-ZOOm ()
  (interactive)
  (call-process-shell-command "kill -9 $(ps -aux | grep -i 'zoom' | grep -v 'grep' | awk '{ print $2 }')" nil 0)
  )

;; start vpn connection
(defun ddsvpn/Start-VPN ()
  (interactive)
  (let ((default_vpn "unibgonly"))
    (let (
	  (vpn_name
	   (read-from-minibuffer "Input vpn name: " default_vpn)))
      (let (( start_command
	      (concat "sudo systemctl enable openvpn-client@" vpn_name
		      ".service; sudo systemctl start openvpn-client@" vpn_name ".service")))
	(async-shell-command start_command)
	(sleep-for 1)
	(switch-to-buffer-other-window "*Async Shell Command*")
	(delete-window)
	)))
  )

;; stop and disable vpn connection
(defun ddkvpn/Kill-VPN ()
  (interactive)
  (let ((default_vpn "unibgonly"))
    (let (
	  (vpn_name
	   (read-from-minibuffer "Input vpn name: " default_vpn)))
      (let (( start_command
	      (concat "sudo systemctl stop openvpn-client@" vpn_name
		      ".service; sudo systemctl disable openvpn-client@" vpn_name ".service")))
	(async-shell-command start_command)
	(sleep-for 1)
	(switch-to-buffer-other-window "*Async Shell Command*")	
	(delete-window)
	)))
  )

;; kill all messaging apps
(defun ddkama/Kill-All-Messaging-Apps()
  (interactive)
  (ddckr/Clear-Kill-Ring)
  (ddksky/Kill-SKYpe)
  (ddksla/Kill-SLAck)
  (ddktea/Kill-microsoft-TEAms)
  )

;; open eshell in the directory associated with the current buffer
(defun ddoeh/Open-Eshell-Here ()
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input))
  )

;; quickly close eshell
(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))

;; top-to-bottom jump
(defun ddttbj/Top-To-Bottom-Jump ()
  (interactive)
  (point-to-register ?t)
  (jump-to-register ?b))
(global-set-key (kbd "C-<f7>") 'ddttbj/Top-To-Bottom-Jump)

;; bottom-to-top jump
(defun ddbttj/Bottom-To-Top-Jump ()
  (interactive)  
  (point-to-register ?b)
  (jump-to-register ?t))
(global-set-key (kbd "M-<f7>") 'ddbttj/Bottom-To-Top-Jump)

;; enable minor mode if finename matches regexp
;; `binding` is a cons cell (regexp . minor-mode)
(defun ddemm/Enable-Minor-Mode (new-binding)
  (interactive)
  (if (buffer-file-name)
      (if (string-match (car new-binding) buffer-file-name)
	  (funcall (cdr new-binding)))))

;; placeholder to execute a function by name
(defvar callable-function-placeholder "initialize function name"
  "Name of a function callable with dd/ utility.
   Use only functions with 0 arguments.")

(defun ddscfn/Set-Callable-Function-Name ()
  "Sets the value of the variable callable-function-placeholder."
  (interactive)
  (setq callable-function-placeholder
	(read-from-minibuffer "Set callable-function-name: " callable-function-placeholder)))

(defun ddccf/Call-Callable-Function ()
  "Calls the function name saved in the callable-function-placeholder variable."
  (interactive)
  (funcall (intern callable-function-placeholder)))
(global-set-key (kbd "C-~") 'ddccf/Call-Callable-Function)
