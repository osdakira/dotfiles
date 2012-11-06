(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (goto-char (point-max))
     (eval-print-last-sexp))))
(el-get 'sync)

;; (package-initialize)

(add-to-list 'load-path "~/.emacs.d/conf")
(load "basic-conf")
(load "key-combo-conf")
(load "fonts-conf")
(load "env-conf")
(load "anything-conf")
(load "flymake-conf")

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; 最近使ったファイルの表示数
(setq recentf-max-menu-items 10)

;; 最近開いたファイルの保存数を増やす
(setq recentf-max-saved-items 3000)

;; ミニバッファの履歴を保存する
(savehist-mode 1)

;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; 自動コンパイル
;; http://www.emacswiki.org/emacs/auto-async-byte-compile.el
(when (require 'auto-async-byte-compile nil t)
  ;; 自動コンパイルを無効にするファイル名の正規表現
  (setq auto-async-byte-compile-exclude-files-regexp "init.el")
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-interval 100)
 '(backward-delete-char-untabify-method (quote hungry))
 '(blink-cursor-mode nil)
 '(c-basic-offset 4)
 '(case-fold-search nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (molokai)))
 '(custom-safe-themes (quote ("cd881cd785e681c826a455d367697e60a2131a051801ae96d0f33cdaabd8d487" "6615e5aefae7d222a0c252c81aac52c4efb2218d35dfbb93c023c4b94d3fa0db" default)))
 '(enable-recursive-minibuffers t)
 '(frame-title-format (format "emacs : %%f") t)
 '(global-font-lock-mode t)
 '(history-length 100)
 '(indent-level 4)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(kill-ring-max 100)
 '(make-backup-files nil)
 '(python-indent-offset 4)
 '(recentf-max-saved-items 1000)
 '(save-place t nil (saveplace))
 '(scroll-conservatively 1)
 '(scroll-step 1)
 '(search-highlight t)
 '(set-default-file-coding-system (quote utf-8-unix))
 '(show-paren-mode t)
 '(show-paren-style (quote expression))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(visible-bell t)
 ;; '(which-function-mode t)
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
