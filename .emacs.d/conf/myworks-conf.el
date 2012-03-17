;; coding: utf-8
;; 自分の作業用

(defun change-frame-background-color-by-project()
  "change-frame-background-color-by-project"
  (when (not (equal buffer-file-name nil))
    (cond 
     ((string-match "otogi" buffer-file-name)
      (change-face-mode-and-tab-by-project "#FF00FF"))
     ((string-match "dragon" buffer-file-name)
       (set-face-foreground 'modeline "#0000FF"))
     ((string-match "poodle" buffer-file-name)
      (set-face-foreground 'modeline "#009900"))
     (t (set-face-foreground 'modeline "#FF0000")
        ))))

(change-face-mode-and-tab-by-project "#FF00FF")
(defun change-face-mode-and-tab-by-project(color-code)
  (set-face-foreground 'modeline color-code)
  ;; (custom-set-faces
  ;;  '(elscreen-tab-current-screen-face
  ;;   ((((class color))
  ;;     (:background "white" :foreground color-code))
  ;;    (t (:underline t))))))
)
  

(add-hook 'elscreen-goto-hook
          'change-frame-background-color-by-project)

;;(debug-on-entry 'change-frame-background-color-by-project)
;;(set-face-background 'default "#000000" (window-frame (frame-selected-window)))
;;(set-background-color "#190000")