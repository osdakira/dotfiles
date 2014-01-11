(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
(keyboard-translate ?\C-h ?\C-?)   ;; C-h is backspace
(global-set-key (kbd "C-?") 'help) ;; C-? is help
(global-unset-key [insert])
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-c l") 'toggle-truncate-lines) ;; 折り返しをトグル
(fset 'yes-or-no-p 'y-or-n-p)
(standard-display-ascii ?\n "$\n")  ;; 末尾に$
(cua-mode t) ; cua-modeをオン
(setq cua-enable-cua-keys nil) ; CUAキーバインドを無効にする
(global-hl-line-mode)
(setq show-paren-delay 0) ; 表示までの秒数。初期値は0.125
(global-auto-revert-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-interval 100)
 '(backward-delete-char-untabify-method (quote hungry))
 '(blink-cursor-mode nil)
 '(case-fold-search nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (tango-dark)))
 '(enable-recursive-minibuffers t)
 '(global-font-lock-mode t)
 '(history-length 300)0
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message "")
 '(kill-ring-max 100)
 '(make-backup-files nil)
 '(recentf-max-saved-items 3000)
 '(recentf-max-menu-items 1)0
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(save-place t nil (saveplace))
 '(scroll-conservatively 1)
 '(search-highlight t)
 '(set-default-file-coding-system (quote utf-8-unix))
 '(show-paren-mode t)
 '(show-paren-style (quote expression))
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(visible-bell t)
 '(warning-minimum-level :emergency))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; ミニバッファの履歴を保存する
(savehist-mode 1)

