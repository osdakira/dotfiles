;; anything
(require 'anything-startup)
(global-set-key (kbd "C-;") 'anything)
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "M-i") 'anything-imenu)
(global-set-key (kbd "M-C-.") 'anything-etags+-select)
;; tag jump
;; (require 'anything-etags)
;; (require 'anything-gtags)
;; (define-key global-map (kbd "C-x t")
;;   (lambda ()
;;     "Tag jump using etags, gtags and `anything'."
;;     (interactive)
;;     (let* ((initial-pattern (regexp-quote (or (thing-at-point 'symbol) ""))))
;;       (anything (list anything-c-source-gtags-select
;;                       anything-c-source-etags-select))
;;       "Find Tag: " nil)))
