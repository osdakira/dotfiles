(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-c l") 'toggle-truncate-lines) ;; 折り返しをトグル

(defun my-dynamic-modeline ()
  (cond
   ((numberp (string-match "edo2" buffer-file-name))
    (set-face-foreground 'modeline "#00ffff"))
   ((numberp (string-match "edo" buffer-file-name))
    (set-face-foreground 'modeline "#ffff00"))
   (t
    (set-face-foreground 'modeline "white"))))

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1)
  (my-dynamic-modeline)
)
(global-set-key (kbd "C-t") 'other-window-or-split)

;; modeline関係
(set-face-underline-p 'modeline t) ; モードラインには下線をつける
(set-face-bold-p 'modeline t) ; モードラインは太字

;; (setq frame-background-mode 'dark)
