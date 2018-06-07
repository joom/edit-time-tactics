;; add this to idris-commands.el
(defun replace-region (beg end new-text)
  "Replace the region from BEG to END with NEW-TEXT."
  (save-excursion
    (delete-region beg end)
    (goto-char beg)
    (insert new-text)))

(defun idris-elab-edit (name &rest args)
  "Run the Elab editing action NAME with arguments ARGS."
  (car (idris-eval `(:elab-edit ,name ,args ,(idris-get-line-num) ,(current-column)))))

(defun idris-simplify-regex ()
  "Replace selection with simplified regex."
  (interactive)
  (let* ((regexp (buffer-substring-no-properties
                  (region-beginning) (region-end)))
         (result (idris-elab-edit "simplifyInEditor" regexp)))
    (replace-region (region-beginning) (region-end) result)))

; add this to idris-keys.el, in the idris-define-editing-keys function
(define-key map (kbd "C-c C-g") 'idris-simplify-regex)
