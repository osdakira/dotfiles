;; フォント設定
;; (set-fontset-font "fontset-default" 'japanese-jisx0208 ' ( "Ricty" . "iso10646-*"))

;; (let* ((size 15)
;;        (asciifont "Ricty")
;;        (jpfont "Ricty")
;;        (h (* size 10))
;;        (fontspec (font-spec :family asciifont))
;;        (jp-fontspec (font-spec :family jpfont)))
;;   (set-face-attribute 'default nil :family asciifont :height h)
;;   (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
;;   (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
;;   (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
;;   (set-fontset-font nil '(#x0080 . #x024F) fontspec)
;;   (set-fontset-font nil '(#x0370 . #x03FF) fontspec))


;; (create-fontset-from-ascii-font "Ricty-11:weight=normal:slant=normal" nil "ricty")
;; (set-fontset-font "fontset-ricty"
;;                   'unicode
;;                   (font-spec :family "Ricty" :size 11)
;;                   nil
;;                   'append)
;; (add-to-list 'default-frame-alist '(font . "fontset-ricty"))

;; (create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
;; (set-fontset-font "fontset-menlokakugo"
;;                   'unicode
;;                   (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
;;                   nil
;;                   'append)
;; (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))


;; (set-face-attribute 'default nil
;;                      :family "Ricty"  ;; 英数
;;                      :height 140)
;; (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty"))


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


;;; 改行やタブを可視化する whitespace-mode
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
;; ;; whitespace-modeで全角スペース文字を可視化　
;; (setq whitespace-space-regexp "\\(\x3000+\\)")
;; ;; whitespace-mode をオン
;; (global-whitespace-mode t)
