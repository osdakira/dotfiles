(require 'helm-config)

(defun helm-mini ()
  "Preconfigured `helm' lightweight version \(buffer -> recentf\)."
  (interactive)
  (helm-other-buffer '(helm-c-source-recentf
                       helm-c-source-buffers-list
                       helm-c-source-buffer-not-found)
                     "*helm mini*"))

(global-set-key (kbd "C-;") 'helm-mini)
;; (global-set-key (kbd "C-;") 'helm-recentf)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;(global-set-key (kbd "C-x C-f") 'helm-find-files)
(setq helm-buffer-max-length '50)

(require 'helm-c-moccur)
(global-set-key (kbd "M-o") 'helm-c-moccur-occur-by-moccur)
;; (global-set-key (kbd "C-M-o") 'helm-c-moccur-dmoccur)
;; (add-hook 'dired-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "O") 'helm-c-moccur-dired-do-moccur-by-moccur)))
;; (global-set-key (kbd "C-M-s") 'helm-c-moccur-isearch-forward)
;; (global-set-key (kbd "C-M-r") 'helm-c-moccur-isearch-backward)

(require 'helm-gtags)
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
             (local-set-key (kbd "M-*") 'helm-gtags-pop-stack)
             ;; (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
             (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
             (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
             ;; (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
             (local-set-key (kbd "C-c C-f") 'helm-gtags-find-files)
             (setq gtags-path-style 'relative)
             (setq helm-c-gtags-use-otherwin t)
             ))
;; (setq gtags-path-style 'absolute)
(add-hook 'python-mode-hook '(lambda () (helm-gtags-mode)))
(add-hook 'coffee-mode-hook '(lambda () (helm-gtags-mode)))
(add-hook 'ruby-mode-hook '(lambda () (helm-gtags-mode)))
(add-hook 'javascript-mode-hook '(lambda () (helm-gtags-mode)))

(require 'helm-c-yasnippet)
(setq helm-c-yas-space-match-any-greedy t) ;[default: nil]
(global-set-key (kbd "C-c y") 'helm-c-yas-complete)
(yas--initialize)
