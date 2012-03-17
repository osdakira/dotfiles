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



(standard-display-ascii ?\n "$\n")
(defface my-eol-face
  '((t (:foreground "gray")))
  "eol")
(defvar my-eol-face
  '(("\n" . 'my-eol-face)))
(add-hook 'font-lock-mode-hook
          (lambda () (font-lock-add-keywords nil my-eol-face)))





;; (defun my-window-size-save ()
;;   (let* ((rlist (frame-parameters (selected-frame)))
;;          (ilist initial-frame-alist)
;;          (nCHeight (frame-height))
;;          (nCWidth (frame-width))
;;          (tMargin (if (integerp (cdr (assoc 'top rlist)))
;;                       (cdr (assoc 'top rlist)) 0))
;;          (lMargin (if (integerp (cdr (assoc 'left rlist)))
;;                       (cdr (assoc 'left rlist)) 0))
;;          buf
;;          (file "~/.framesize.el"))
;;     (if (get-file-buffer (expand-file-name file))
;;         (setq buf (get-file-buffer (expand-file-name file)))
;;       (setq buf (find-file-noselect file)))
;;     (set-buffer buf)
;;     (erase-buffer)
;;     (insert (concat
;;              ;; 初期値をいじるよりも modify-frame-parameters
;;              ;; で変えるだけの方がいい?
;;              "(delete 'width initial-frame-alist)\n"
;;              "(delete 'height initial-frame-alist)\n"
;;              "(delete 'top initial-frame-alist)\n"
;;              "(delete 'left initial-frame-alist)\n"
;;              "(setq initial-frame-alist (append (list\n"
;;              "'(width . " (int-to-string nCWidth) ")\n"
;;              "'(height . " (int-to-string nCHeight) ")\n"
;;              "'(top . " (int-to-string tMargin) ")\n"
;;              "'(left . " (int-to-string lMargin) "))\n"
;;              "initial-frame-alist))\n"
;;              ;;"(setq default-frame-alist initial-frame-alist)"
;;              ))
;;     (save-buffer)
;;     ))

;; (defun my-window-size-load ()
;;   (let* ((file "~/.framesize.el"))
;;     (if (file-exists-p file)
;;         (load file))))

;; (my-window-size-load)

;; ;; Call the function above at C-x C-c.
;; (defadvice save-buffers-kill-emacs
;;   (before save-frame-size activate)
;;   (my-window-size-save))



;; (set-face-background 'show-paren-match-face nil)       ; カッコ内のフェイス
;; (set-face-underline-p 'show-paren-match-face "yellow") ; カッコ内のフェイス


;; (create-fontset-from-ascii-font "Menlo-12:weight=normal:slant=normal" nil "menlokakugo")
;; (set-fontset-font "fontset-menlokakugo"
;;                   'unicode
;;                   (font-spec :family "Hiragino Kaku Gothic ProN" :size 14)
;;                   nil
;;                   'append)
;; (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))



;; (when (>= emacs-major-version 23)
;;  (set-face-attribute 'default nil
;;                      :family "monaco"
;;                      :height 140)
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'japanese-jisx0208
;;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'japanese-jisx0212
;;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'mule-unicode-0100-24ff
;;   '("monaco" . "iso10646-1"))
;;  (setq face-font-rescale-alist
;;       '(("^-apple-hiragino.*" . 1.2)
;;         (".*osaka-bold.*" . 1.2)
;;         (".*osaka-medium.*" . 1.2)
;;         (".*courier-bold-.*-mac-roman" . 1.0)
;;         (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
;;         (".*monaco-bold-.*-mac-roman" . 0.9)
;;         ("-cdac$" . 1.3))))



;; (setq my-font "-*-*-medium-r-normal--14-*-*-*-*-*-fontset-hiramaru")
;; (setq fixed-width-use-QuickDraw-for-ascii t)
;; (setq mac-allow-anti-aliasing t)
;; (if (= emacs-major-version 22)
;;     (require 'carbon-font))
;; (set-default-font my-font)
;; (add-to-list 'default-frame-alist `(font . ,my-font))
;; (when (= emacs-major-version 23)
;;   (set-fontset-font
;;    (frame-parameter nil 'font)
;;    'japanese-jisx0208
;;    '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;;   (setq face-font-rescale-alist
;; 	'(("^-apple-hiragino.*" . 1.2)
;; 	  (".*osaka-bold.*" . 1.2)
;; 	  (".*osaka-medium.*" . 1.2)
;; 	  (".*courier-bold-.*-mac-roman" . 1.0)
;; 	  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
;; 	  (".*monaco-bold-.*-mac-roman" . 0.9)
;; 	  ("-cdac$" . 1.3))))
