;; hyperlink-add.lsp - Attach a URL to selected objects
;; Command: HLADD
;; Usage: type a URL, then select the objects that should link to it
(defun c:HLADD ( / url ss )
  (setq url (getstring T "\nURL (e.g. https://www.gstarcad.net): "))
  (if (/= url "")
    (progn
      (setq ss (ssget "\nSelect objects to link: "))
      (if ss
        (progn
          (command "_.-HYPERLINK" url ss "")
          (princ "\nHyperlink attached.")
        )
      )
    )
  )
  (princ)
)
