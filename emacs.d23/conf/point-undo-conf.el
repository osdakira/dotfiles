;; coding: utf-8


(require 'point-undo)
(define-key global-map (kbd "M-[") 'point-undo)
(define-key global-map (kbd "M-]") 'point-redo)

