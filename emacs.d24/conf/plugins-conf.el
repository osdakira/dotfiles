(require 'inline-string-rectangle)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
;; (global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
(global-set-key (kbd "C-*") 'mark-all-like-this)

;; (add-hook 'sgml-mode-hook
;;           (lambda ()
;;             (require 'rename-sgml-tag)
;;             (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)))


(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "M-@") 'er/contract-region) ;; リージョンを狭める


;; (require 'migemo)
;; (setq migemo-command "~/.emacs.d/lib/bin/cmigemo")
;; ;; (setq migemo-options '("-q" "--emacs"))
;; (setq migemo-options '("-q" "--emacs" "-i" "\g"))
;; (setq migemo-dictionary "~/.emacs.d/lib/share/migemo/utf-8/migemo-dict")
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)
;; (setq migemo-coding-system 'utf-8-unix)
;; (load-library "migemo")
;; ;; (setq migemo-after-conv-function nil)
;; (migemo-init)
;; ;; (require 'helm-migemo)
;; ;; (define-key global-map [(control ?:)] 'helm-migemo)


(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
