;; hyperlink-list.lsp - List the hyperlinks on a picked object
;; Command: HLLIST
(defun c:HLLIST ( / en obj links i n url )
  (vl-load-com)
  (setq en (car (entsel "\nPick an object: ")))
  (if en
    (progn
      (setq obj (vlax-ename->vla-object en))
      (if (vlax-property-available-p obj 'Hyperlinks)
        (progn
          (setq links (vlax-get obj 'Hyperlinks)
                n (vla-get-Count links)
                i 0)
          (if (= n 0)
            (princ "\nNo hyperlinks on this object.")
            (repeat n
              (setq url (vla-get-URL (vla-item links i)))
              (princ (strcat "\n" url))
              (setq i (1+ i))
            )
          )
        )
        (princ "\nThis object type cannot carry hyperlinks.")
      )
    )
  )
  (princ)
)
