(require 'key-combo)
(key-combo-load-default)
;; (key-combo-mode 1)
;; (key-combo-load-default-1 (current-global-map)
;;                             key-combo-global-default)
;; (key-combo-define-global (kbd "{") '("{" "{% `!!' %}" "{{ `!!' }}" "{# `!!' #}"))
(key-combo-define-global (kbd "{") '(" { " "{% `!!' %}" "{{ `!!' }}" "{# `!!' #}"))
(key-combo-define-global (kbd "[") '("[`!!']" "[" "[["))
;; (key-combo-define-global (kbd "\"") '("\"" "\"\"" "\"\"\" \"\"\""))
;; (key-combo-define-global (kbd "\"\"") '("\"\"" "\"\"\" \"\"\""))
;; (key-combo-define-global (kbd "(") '("(`!!')"))
(key-combo-define-global (kbd "=") '("=" " = " "=" " == "))
;; (key-combo-define-global (kbd "==") '(" == "))
(key-combo-define-global (kbd ",") '(", " ","))
;; (key-combo-mode 1)
;; (key-combo-define-global (kbd "=") '(" = " "=="))
;; (key-combo-define-global (kbd "+") '(" + " "+"))
;; (key-combo-define-global (kbd "(") '("(`!!')"))
;; (key-combo-define-global (kbd "()") '("()"))
(key-combo-define-global (kbd "\"") '("\"`!!'\""))
(key-combo-define-global (kbd "-") '("-" " - " "->" ))
(key-combo-define-global (kbd "&") '("&" " & " " && "))
;; (key-combo-define-global (kbd "|") '("|" " || "))
;; (key-combo-define-global (kbd "<") '("<" "<% `!!' %>" "<%= `!!' %>" "<%- `!!' %>" "<%# `!!' %>"))
(key-combo-define-global (kbd "<") '("<" "<%- `!!' -%>" "<%= `!!' %>" "<%- `!!' %>" "<%# `!!' %>"))
