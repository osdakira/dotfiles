(defun my-dynamic-modeline ()
  (cond
   ((numberp (string-match "edo2" buffer-file-name))
    (set-face-foreground 'modeline "#00ffff"))
   ((numberp (string-match "edo" buffer-file-name))
    (set-face-foreground 'modeline "#ffff00"))
   (t
    (set-face-foreground 'modeline "white"))))
(add-hook 'find-file-hook 'my-dynamic-modeline)
(add-hook 'select-window-functions 'my-dynamic-modeline)
