# GstarCAD Hyperlink Tools

Attach a URL to objects, list the links on a picked object and clear them again in one command.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Drawings increasingly link out to specifications, product pages and issue trackers. These commands attach a URL to any selected objects, list the hyperlinks on a picked object, and clear links from a selection in one command, without opening the hyperlink dialog each time.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/hyperlink-add.lsp` | ;; hyperlink-add.lsp - Attach a URL to selected objects
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
 |
| `scripts/hyperlink-list.lsp` | ;; hyperlink-list.lsp - List the hyperlinks on a picked object
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
 |
| `scripts/hyperlink-remove.lsp` | ;; hyperlink-remove.lsp - Remove hyperlinks from selected objects
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
