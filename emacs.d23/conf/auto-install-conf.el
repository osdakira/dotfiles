;; (install-elisp "http://www.emacswiki.org/emacs/download/auto-install.el")
;; auto-install による elisp のインストール
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup)
  ;;(setq auto-install-use-wget t)
  )
