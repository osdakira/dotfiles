(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         ;; (local-set-key "\C-t" 'gtags-pop-stack)
         ))

(add-hook 'c-mode-common-hook
          '(lambda()
             (gtags-mode 1)
             (gtags-make-complete-list)
             ))


;; http://eigyr.dip.jp/gtags.html#sec5

(require 'gtags)
(add-hook 'python-mode-hook
          (lambda ()
            (gtags-mode 1)
            ;;(setq gtags-libpath `((,(expand-file-name "~/.tags/python") . )))
            ))

;; $ cd /usr/include
;; $ gtags -vv ~/.tags/c
;; $ cd /usr/local/include
;; $ gtags -vv ~/.tags/c_local

;; (add-hook 'c-mode-hook
;;           (lambda ()
;;             (gtags-mode 1)
;;             (setq gtags-libpath `((,(expand-file-name "~/.tags/c") . "/usr/include")
;;                                   (,(expand-file-name "~/.tags/c_local") . "/usr/local/include")))))
