(defun idris-name-at-point-extents (where)
  "Return a two-element list consisting of the buffer positions of the start and end of the name at WHERE.

An error is signaled if there is no name at WHERE."
  (interactive "d")
  (let ((ref (cl-remove-if
              #'null
              (cons (get-text-property where 'idris-ref)
                    (cl-loop for overlay in (overlays-at where)
                             when (overlay-get overlay 'idris-ref)
                             collecting overlay)))))
    (if (null ref)
        (error "No name at position %s" where)
      (let ((o (car ref)))
        (list (overlay-start o)
              (overlay-end o))))))

(defun idris-elab-hole-arg (action args)
  "Run and replace the hole with the result"
  (let ((result (car
                 (idris-eval
                  `(:elab-edit ,action ,args
                               ,(idris-get-line-num)
                               ,(current-column))))))
    (save-excursion
      (apply 'delete-region
             (idris-name-at-point-extents (point)))
      (insert result))))

(defun idris-easy ()
  "Solve an easy hole"
  (interactive)
  (idris-elab-hole-arg "Examples.easy" `(,(idris-name-at-point))))
