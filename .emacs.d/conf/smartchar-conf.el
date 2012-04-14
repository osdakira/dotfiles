;; http://d.hatena.ne.jp/handlename/20101211/1292079384

;; INSTALL
;; (install-elisp "https://github.com/imakado/emacs-smartchr/raw/master/smartchr.el")

(require 'smartchr)

(global-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"" "\"\"\"\n`!!'\n\"\"\"")))

(defun my-smartchr-setting ()
  (local-set-key (kbd "=") (smartchr '(" = " "=" " == " )))
  (local-set-key (kbd "+") (smartchr '(" + " "+" " += " )))
  ;;(local-set-key (kbd "{") (smartchr '("{ `!!' }" "{\n`!!'\n}" "{")))
  ;;(local-set-key (kbd "(") (smartchr '("(" "(`!!')")))
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  (local-set-key (kbd "'") (smartchr '("'`!!''" "'")))
  ;;(local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd "#") (smartchr '("# " "#")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  (local-set-key (kbd ",") (smartchr '(", ")))
  ;;(local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  ;;(local-set-key (kbd "C-m") (smartchr '("\n" "\n\n" "\n\n\n" "\n\n\n\n\n" "\n\n\n\n\n\n\n" "\n\n\n\n\n\n\n\n\n\n\n\n")))
  ;;(local-set-key (kbd "+") (smartchr '(" + " "++" " += " "+")))
  ;;(local-set-key (kbd "-") (smartchr '(" - " "--" " -= " "-")))
  ;;(local-set-key (kbd ">") (smartchr '(">" "->" ">>")))
  )

;; (add-hook 'php-mode-hook 'my-smartchr-setting)
;; (add-hook 'javascript-mode-hook 'my-smartchr-setting)
(add-hook 'python-mode-hook 'my-smartchr-setting)
(add-hook 'c-mode-hook 'my-smartchr-setting)

(defun my-smartchr-setting-django ()
  (local-set-key (kbd "{") (smartchr '("{" "{`!!'}" "{% `!!' %}" "{{ `!!' }}" "{# `!!' #}")))
  )
(add-hook 'nxml-mode-hook 'my-smartchr-setting-django)
(add-hook 'html-mode-hook 'my-smartchr-setting-django)
(add-hook 'django-mode-hook 'my-smartchr-setting-django)


(defun org-smartchr-setting ()
  (local-set-key (kbd "-") (smartchr '("- " "- [ ] ")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  (local-set-key (kbd "*") (smartchr '("* " "** " "*** ")))
  )
(add-hook 'org-mode-hook 'org-smartchr-setting)