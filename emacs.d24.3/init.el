;; init settings
;; Replace Command-Key and Option-Key
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

;; set by emacs configuration

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(auto-save-interval 1000)
 '(backward-delete-char-untabify-method (quote hungry))
 '(blink-cursor-mode nil)
 '(case-fold-search nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-safe-themes (quote ("466cdb687a83da9c0e9bb995023600ae00c43efe41fdf31c264fd17285214f95" default)))
 '(debug-on-error t)
 ;; '(debug-on-quit t)
 ;; '(enable-recursive-minibuffers t)
 '(history-length 300)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message "")
 '(kill-ring-max 100)
 '(make-backup-files nil)
 '(recentf-max-menu-items 10)
 '(recentf-max-saved-items 3000)
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(save-place t nil (saveplace))
 '(scroll-conservatively 1)
 '(scroll-step 1)
 '(search-highlight t)
 '(set-default-file-coding-system (quote utf-8-unix))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(set-frame-parameter nil 'alpha 80 )
;; (set-face-underline-p 'modeline t) ; モードラインには下線をつける
;; (set-face-bold-p 'modeline t) ; モードラインは太字
;; (setq frame-background-mode 'dark)
(setq visible-bell t)
(setq warning-minimum-level :emergency)
(load-theme 'molokai t)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; ミニバッファの履歴を保存する
(savehist-mode t)


;; (defun my-dynamic-modeline ()
;;   (cond
;;    ((numberp (string-match "workstation" buffer-file-name))
;;     (set-face-foreground 'modeline "#00ffff"))
;;    ((numberp (string-match "mina-game" buffer-file-name))
;;     (set-face-foreground 'modeline "#ffff00"))
;;    (t
;;     (set-face-foreground 'modeline "white"))))
;; (add-hook 'find-file-hook 'my-dynamic-modeline)
;; (add-hook 'select-window-functions 'my-dynamic-modeline)

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1)
  ;; (my-dynamic-modeline)
  )
(global-set-key (kbd "C-t") 'other-window-or-split)


;; 行末の空白を強調表示
;; (setq-default show-trailing-whitespace t)
;; (set-face-background 'trailing-whitespace "#b14770")
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 行間
(setq-default line-spacing 0)

;; grep-a-lot grep バッファを沢山作る
(require 'grep-a-lot)

(require 'wgrep)
(define-key wgrep-mode-map (kbd "C-x C-s") '(lambda () (interactive) (let ((wgrep-auto-save-buffer t)) (wgrep-finish-edit))))
;; grep-mode > wgrep-mode への移行
(setq wgrep-enable-key "r")
;; * To apply all changes wheather or not buffer is read-only.
                                        ;(setq wgrep-change-readonly-file t)
;; バッファ編集適用後の一括保存を grep-mode でバインド
(define-key grep-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)

(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


;; 大文字小文字変換
(defun seq-upcase-backward-word ()
  (interactive)
  (backward-word)
  (upcase-word 1))
(defun seq-capitalize-backward-word ()
  (interactive)
  (backward-word)
  (capitalize-word 1))
(defun seq-downcase-backward-word ()
  (interactive)
  (backward-word)
  (downcase-word 1))
(global-set-key "\M-u" 'seq-upcase-backward-word)
(global-set-key "\M-c" 'seq-capitalize-backward-word)
(global-set-key "\M-l" 'seq-downcase-backward-word)


;; (setenv "PATH"
;;         (concat
;;          (substitute-in-file-name
;;           (substring (shell-command-to-string "grep PATH ~/.bashrc") 12 -1))
;;          '":"
;;          (getenv "PATH")))

;;; P82-83 パスの設定
;; (add-to-list 'exec-path "/opt/local/bin")
;; (add-to-list 'exec-path "/usr/local/bin")
;; (add-to-list 'exec-path "~/bin")

;; バックアップとオートセーブファイルを~/.emacs.d/backups/へ集める
;; (add-to-list 'backup-directory-alist
;;              (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "/tmp/") t)))


(when (eq window-system 'ns)
  (let ((my-font-height 120)
        (my-font (cond
                  (t   "Monaco")  ;; XCode 3.1 で使っているフォント
                  (nil "Menlo")   ;; XCode 3.2 で使ってるフォント
                  ))
        (my-font-ja "Hiragino Maru Gothic Pro"))
    (setq mac-allow-anti-aliasing t)

    ;; フォントサイズの微調節 (12ptで合うように)
    (setq face-font-rescale-alist
          '(("^-apple-hiragino.*" . 1.2)
            (".*osaka-bold.*" . 1.2)
            (".*osaka-medium.*" . 1.2)
            (".*courier-bold-.*-mac-roman" . 1.0)
            (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
            (".*monaco-bold-.*-mac-roman" . 0.9)
            ("-cdac$" . 1.3)))

    ;; デフォルトフォント設定
    (when my-font
      (set-face-attribute 'default nil :family my-font :height my-font-height)
      ;;(set-frame-font (format "%s-%d" my-font (/ my-font-height 10)))
      )

    ;; 日本語文字に別のフォントを指定
    (when my-font-ja
      (let ((fn (frame-parameter nil 'font))
            (rg "iso10646-1"))
        (set-fontset-font fn 'katakana-jisx0201 `(,my-font-ja . ,rg))
        (set-fontset-font fn 'japanese-jisx0208 `(,my-font-ja . ,rg))
        (set-fontset-font fn 'japanese-jisx0212 `(,my-font-ja . ,rg))))))

(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs)
  )


;; 改行やタブを可視化する whitespace-mode
;; (setq whitespace-display-mappings
;;       '((space-mark ?\x3000 [?\□]) ; zenkaku space
;;         (newline-mark 10 [8629 10]) ; newlne
;;         (tab-mark 9 [187 9] [92 9]) ; tab » 187
;;         )
;;       whitespace-style
;;       '(spaces
;;         ;; tabs
;;         trailing
;;         newline
;;         space-mark
;;         tab-mark
;;         newline-mark))
;; whitespace-modeで全角スペース文字を可視化　
;; (setq whitespace-space-regexp "\\(\x3000+\\)")
;; whitespace-mode をオン
;; (global-whitespace-mode t)


(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "M-@") 'er/contract-region) ;; リージョンを狭める


(require 'auto-complete-config)
(ac-config-default)
(setq ac-delay 0.1) ;; auto-completeまでの時間
(setq ac-auto-show-menu 0.2) ;; メニューが表示されるまで
(setq ac-use-menu-map t) ;; 補完メニューをC-p C-nで操作できるようにする(通常はTABで上や下に移動する)
(setq ac-use-fuzzy t) ;; 曖昧マッチな補完が出来るようにする。

;; (add-hook 'emacs-lisp-mode-hook '(lambda () (require 'eldoc-extension) (eldoc-mode t) ))
(global-auto-complete-mode)
(add-to-list 'ac-modes 'cofee-mode)
(add-to-list 'ac-modes 'markdown-mode)


;; (require 'autopair)
;; (autopair-global-mode) ;; to enable in all buffers

(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode t)


;;(ctags-update-minor-mode)

;; (global-set-key "\M-?" 'etags-select-find-tag-at-point)
;; (global-set-key "\M-." 'etags-select-find-tag)

;; https://github.com/luozengbin/dot.emacs.d/blob/master/site-start.d/init_dired.el
;;
;; 基本設定
;;______________________________________________________________________
;; ディレクトリを先に表示する
;; (setq ls-lisp-dirs-first t)

;; サイズ表示を分かりやすくする
(setq dired-listing-switches "-alh")

;; ;; 画像を直接開けるように
;; (auto-image-file-mode t)

;; diredのコピー、削除操作のネストを自動化する
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

;; (require 'goto-chg)
;; (global-set-key "\M-[" 'goto-last-change)
;; (global-set-key "\M-]" 'goto-last-change-reverse)


(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))


;; ;; key-chord
;; (require 'key-chord)
;; (key-chord-mode 1)
;; (setq key-chord-two-keys-delay 0.05)

;; ;; key setting
;; (key-chord-define-global "gl" 'goto-line)
;; (key-chord-define-global "as" 'auto-save-buffers-toggle)
;; (key-chord-define-global "re" 'replace-string)
;; (key-chord-define-global "zx" 'undo)


(require 'key-combo)
(key-combo-mode 1)
(key-combo-load-default)
(key-combo-define-global (kbd "C-a") '(back-to-indentation
                                       beginning-of-buffer key-combo-return))
(key-combo-define-global (kbd "<") '("<" "<%- `!!' -%>" "<%= `!!' %>" "<%- `!!' %>" "<%# `!!' %>"))
(key-combo-define-global (kbd "=") '("=" " = " "=" " == "))
(key-combo-define-global (kbd "|") '("|" " | " " || "))



;; (require 'lineno)

(require 'multi-term)
(setq multi-term-program "/bin/bash")


(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; (global-num3-mode)

;; (rainbow-mode)
(add-hook 'css-hook 'rainbow-mode)
(add-hook 'scss-hook 'rainbow-mode)

;; インデント幅を2にする
;; コンパイルは compass watchで行うので自動コンパイルをオフ
(defun scss-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil)
   )
  )
(add-hook 'scss-mode-hook
          '(lambda() (scss-custom)))

;; (require 'smart-mode-line)
;; (sml/setup)

;; (autoload 'ssh-config-mode "ssh-config-mode" t)
;; (add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
;; (add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))
;; (add-hook 'ssh-config-mode-hook 'turn-on-font-lock)

;; (global-undo-tree-mode)

;;   (require 'yas-jit)
;;   (setq yas/root-directory snippet-directory)
;;   (yas/jit-load)


;; [Mac の emacs で find-file のデフォルトディレクトリを "~/" にする。 - Qiita [キータ]](http://qiita.com/t2psyto/items/05776f010792ba967152)
;; (setq default-directory "~/")
;; (setq command-line-default-directory "~/")


;; Google日本語入力を使う場合はおすすめ
;; (setq default-input-method "MacOSX")
;; (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `title "あ")

(global-auto-highlight-symbol-mode)

;; これがあると、hungry が効く。理由は知らない。
(auto-indent-global-mode)

;; ruby-mode
;; マジックコメントを入れない
(setq ruby-insert-encoding-magic-comment nil)
;; (setq enh-ruby-insert-encoding-magic-comment nil)
;; TODO FIXME を強調表示
;; (add-hook 'ruby-mode-hook 'fic-ext-mode)
;; flycheck
(add-hook 'ruby-mode-hook 'flycheck-mode)
;; (add-hook 'enh-ruby-mode-hook 'flycheck-mode)
(add-hook 'after-init-hook 'global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(mode-enabled save))
;; (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

;; 対応する block を強調表示
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay)
(setq ruby-block-highlight-toggle 'minibuffer)
(setq ruby-block-highlight-toggle t)

;; (require 'ruby-end)

;; (require 'ruby-tools)
;; (define-key ruby-mode-map (kbd "C-c C-d") 'xmp)
;; (define-key ruby-mode-map (kbd "C-;") nil)

;; (setq rbenv-installation-dir (concat (getenv "HOME") "/.homebrew/var/rbenv/"))
(custom-set-variables '(rbenv-installation-dir (concat (getenv "HOME") "/.homebrew/var/rbenv/")))
(require 'rbenv)
(global-rbenv-mode)

(require 'rubocop)
(add-hook 'ruby-mode-hook 'rubocop-mode)
(add-hook 'enh-ruby-mode-hook 'rubocop-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(global-unset-key [insert])
(define-key web-mode-map (kbd "C-;") 'nil)
(add-hook 'web-mode-hook 'auto-complete-mode)

;; (add-hook 'ruby-mode-hook 'robe-mode)
;;  - M-. to jump to the definition
;;  - M-, to jump back
;;  - C-c C-d to see the documentation
;;  - C-c C-k to refresh Rails environment
;;  - C-M-i to complete the symbol at point


;; rspec-mode と ruby-test-mode がある
;; rspec-mode
;;; Commentary:
;;
;; This minor mode provides some enhancements to ruby-mode in
;; the contexts of RSpec specifications.  Namely, it provides the
;; following capabilities:
;;
;;  * toggle back and forth between a spec and it's target (bound to
;;    `\C-c ,t`)
;;
;;  * verify the spec file associated with the current buffer (bound to `\C-c ,v`)
;;
;;  * verify the spec defined in the current buffer if it is a spec
;;    file (bound to `\C-c ,v`)
;;
;;  * verify the example defined at the point of the current buffer (bound to `\C-c ,s`)
;;
;;  * re-run the last verification process (bound to `\C-c ,r`)
;;
;;  * toggle the pendingness of the example at the point (bound to
;;    `\C-c ,d`)
;;
;;  * disable the example at the point by making it pending
;;
;;  * reenable the disabled example at the point
;;
;;  * run all specs related to the current buffer (`\C-c ,m`)
;;
;;  * run the current spec and all after it (`\C-c ,c`)
;;
;;  * run spec for entire project (bound to `\C-c ,a`)
;;

(defun execute-rspec ()
  (interactive)
  (do-applescript (format "tell application \"iTerm\"
  activate
  tell current session of current terminal
    write text \"bundle exec spring rspec %s:%s\"
  end tell
  end tell
  tell application \"System Events\"
    keystroke return
  end tell"
                          buffer-file-name (line-number-at-pos))))

(define-key ruby-mode-map (kbd "C-c r") 'execute-rspec)

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))

(global-rinari-mode t)

;; (require 'foreign-regexp)
;; (custom-set-variables
;;  '(foreign-regexp/regexp-type 'ruby) ;; Choose by your preference.
;;  '(reb-re-syntax 'foreign-regexp)) ;; Tell re-builder to use foreign regexp.


(tabbar-mode 1)
;; グループ化しない
(setq tabbar-buffer-groups-function nil)
;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
;; タブ同士の間隔
(setq tabbar-separator '(0.8))

;; 外観変更
(set-face-attribute
 'tabbar-default nil
 :family "Comic Sans MS"
 :background "black"
 :foreground "gray72"
 :height 1.0)
(set-face-attribute
 'tabbar-unselected nil
 :background "black"
 :foreground "grey72"
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background "black"
 :foreground "yellow"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box nil)
(set-face-attribute
 'tabbar-separator nil
 :height 1.5)

;; タブに表示させるバッファの設定
;; (defvar my-tabbar-displayed-buffers
;;   '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*" "*Faces*" "*vc-")
;;   "*Regexps matches buffer names always included tabs.")
(defvar my-tabbar-displayed-buffers
  '("*scratch*" "*vc-")
  "*Regexps matches buffer names always included tabs.")

(defun my-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `my-tabbar-displayed-buffers'
are always included."
  (let* ((hides (list ?\  ?\*))
         (re (regexp-opt my-tabbar-displayed-buffers))
         (cur-buf (current-buffer))
         (tabs (delq nil
                     (mapcar (lambda (buf)
                               (let ((name (buffer-name buf)))
                                 (when (or (string-match re name)
                                           (not (memq (aref name 0) hides)))
                                   buf)))
                             (buffer-list)))))
    ;; Always include the current buffer.
    (if (memq cur-buf tabs)
        tabs
      (cons cur-buf tabs))))

(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)


;; Firefoxライクなキーバインドに
(global-set-key [(control tab)]       'tabbar-forward)
(global-set-key [(control shift tab)] 'tabbar-backward)
(global-set-key [(control shift w)] 'kill-this-buffer)

;; (custom-set-valiables '(ac-ignore-case nil))

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; [emacs:init.el - PastelWiki](http://pastelwill.jp/wiki/doku.php?id=emacs:init.el#全角スペースと行末タブ_半角スペースを強調表示する)
;; Avoid adding a new line at the end of buffer
(setq next-line-add-newlines nil)
;; Limit the final word to a line break code (automatically correct)
(setq require-final-newline t)

(require 'point-undo nil t)
(define-key global-map "\M-[" 'point-undo)
(define-key global-map "\M-]" 'point-redo)

;; (add-hook 'sgml-mode-hook 'zencoding-mode)
;; (add-hook 'html-mode-hook 'zencoding-mode)
;; (add-hook 'web-mode-hook 'zencoding-mode)
;; (eval-after-autoload-if-found
;;  '(zencoding-mode zencoding-expand-line) "zencoding-mode" "Zen-coding" t nil
;;  '((define-key zencoding-mode-keymap (kbd "M-<return>") 'zencoding-expand-line)))

;; [Emacs標準のファイラdiredの基本的な使い方と便利なTipsいくつか - Qiita [キータ]](http://qiita.com/l3msh0@github/items/8665122e01f6f5ef502f)
;; コントロール用のバッファを同一フレーム内に表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのバッファを上下ではなく左右に並べる
(setq ediff-split-window-function 'split-window-horizontally)

;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copies 'always)
;; diredバッファでC-sした時にファイル名だけにマッチするように
(setq dired-isearch-filenames t)

;; (require 'smartrep)

(add-hook 'ruby-mode-hook 'git-gutter+-mode)
(add-hook 'enh-ruby-mode-hook 'git-gutter+-mode)
(add-hook 'python-mode-hook 'git-gutter+-mode)
(setq ruby-deep-indent-paren-style nil)

;; mysql
;; (autoload 'edbi:open-db-viewer "edbi")

;; (require 'blank-mode)

(mouse-wheel-mode nil)

(require 'helm-config)
(helm-mode 1)

;; 自動補完を無効にする
(setq helm-ff-auto-update-initial-value nil)
;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
;; For find-file etc.
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;; For helm-find-files etc.
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)


;; 文字列を入力してから検索するまでのタイムラグを設定する（デフォルトは 0.1）
(setq helm-input-idle-delay 0.2)

;; helm-source-buffers-list でバッファ名を表示する幅を調整する
(setq helm-buffer-max-length 50)

;; helm-follow-mode （C-c C-f で ON/OFF）の前回の状態を維持する
(setq helm-follow-mode-persistent t)

(global-set-key (kbd "C-;") 'helm-mini)
(define-key global-map (kbd "M-x")     'helm-M-x)
;; (define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "C-x C-f") 'find-file)
(define-key global-map (kbd "C-x C-r") 'helm-recentf)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
(define-key global-map (kbd "C-c i")   'helm-imenu)
(define-key global-map (kbd "C-x b")   'helm-buffers-list)


(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))

;;; 処理を変更したいコマンドをリストに登録していく
(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))

;; vcを起動しないようにする
(custom-set-variables
 '(vc-handled-backends nil))
(setq vc-handled-backends nil)

;; 不要なhookを外す
(remove-hook 'find-file-hook 'vc-find-file-hook)
(remove-hook 'kill-buffer-hook 'vc-kill-buffer-hook)


(custom-set-variables '(coffee-tab-width 2))
;; automatically clean up bad whitespace
(setq whitespace-action '(auto-cleanup))
;; only show bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab))


(require 'visual-regexp)
(require 'visual-regexp-steroids)
;; (define-key global-map (kbd "C-c r") 'vr/replace)
;; (define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)
(global-set-key (kbd "C-M-%") 'vr/query-replace)
(define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
(define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s

;; (global-set-key (kbd "C-c r") 'anzu-query-replace)
;; (global-set-key (kbd "C-c R") 'anzu-query-replace-regexp)
;; (global-set-key (kbd "M-%") 'anzu-query-replace)
;; (global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)


(elscreen-start)
(elscreen-toggle-display-tab)

(require 'recentf-ext)

;; cask の管理
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
