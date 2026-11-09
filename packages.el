;;; packages.el --- Package setup -*- lexical-binding: t; -*-

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://stable.melpa.org/packages/") t)

; Normal startup activates packages before init.el; batch checks do not.
(unless package--initialized
  (package-initialize))

; Run explicitly with M-x aqua-install-packages when setting up Emacs.
(defun aqua-install-packages ()
  "Refresh package archives and install missing `package-selected-packages'."
  (interactive)
  (let ((missing-packages
         (delq nil (mapcar (lambda (package)
                            (unless (package-installed-p package)
                              package))
                          package-selected-packages))))
    (if missing-packages
        (progn
          (package-refresh-contents)
          (dolist (package missing-packages)
            (package-install package)))
      (message "All configured packages are already installed"))))
