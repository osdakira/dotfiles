;;;
;;; django-html
;;;
;;; http://www.dpawson.co.uk/relaxng/nxml/nxmlGeneral.html#d357e432
;;; http://www.irt.org/articles/js136/

(load-library "autostart")
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))
;;(setq mumamo-background-colors nil) 
;;(setq mumamo-chunk-coloring 'no-chunks-colored)
(add-hook 'django-html-mumamo-mode-hook 
          '(lambda () 
             (auto-complete-mode t)
             ;;(setq indent-tabs-mode t)
             ))


;;----------------------------------------------------------
;; css mode: CSS 編集のための Major Mode
;;----------------------------------------------------------
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))

(add-hook 'django-html-mumamo-mode-hook
          (lambda ()
            (setq nxml-child-indent 4)
            (setq indent-tabs-mode nil)
            (setq tab-width 4)))

(add-hook 'nxml-mode-hook
          (lambda ()
            ;;(setq auto-fill-mode -1)
            ;;(setq nxml-slash-auto-complete-flag t)
            (setq nxml-child-indent 4)
            (setq indent-tabs-mode nil)
            (setq tab-width 4)
            ))


(setq django-indent-width 4)
(add-hook 'django-mode-hook 
          '(lambda () 
             (auto-complete-mode t)
             (setq indent-tabs-mode nil)
             ;;(setq tab-width 4)
             ))