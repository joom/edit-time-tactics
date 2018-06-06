; add this to idris-commands.el
(defun idris-simplify-regex ()
  "Replace selection with simplified regex"
  (interactive)
  (let* ((arg `(,(buffer-substring-no-properties
                  (region-beginning) (region-end))))
         (result (car (idris-eval `(:elab-edit "simplifyInEditor" ,arg
                                    ,(idris-get-line-num)
                                    ,(current-column))))))
    (save-excursion
      (delete-region (region-beginning) (region-end))
      (insert result))))

; add this to idris-keys.el, in the idris-define-editing-keys function
(define-key map (kbd "C-c C-g") 'idris-simplify-regex)
