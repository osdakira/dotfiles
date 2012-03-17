;;;
;;; auto-complete
;;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict/")
(setq ac-delay 0.1)
(setq ac-auto-show-menu 0.2)
(setq ac-menu-height 20)
(setq ac-use-comphist nil)
(setq ac-candidate-limit 25)
(setq ac-use-quick-help nil)
(setq global-auto-complete-mode t)
(ac-config-default)
(append ac-modes '(django-html-mumamo-mode))