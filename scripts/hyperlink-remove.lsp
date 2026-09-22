;; hyperlink-remove.lsp - Remove hyperlinks from selected objects
;; Command: HLREMOVE
(defun c:HLREMOVE ( / ss )
  (setq ss (ssget "\nSelect objects to clear: "))
  (if ss
    (progn
      (command "_.-HYPERLINK" "" ss "")
      (princ "\nHyperlinks cleared.")
    )
  )
  (princ)
)
