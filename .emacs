(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)


(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    material-theme))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(load-theme 'material t) ;; load material theme
(elpy-enable)

(global-visual-line-mode t)
(global-linum-mode t)
(setq linum-format "%3d ")


(setq TeX-PDF-mode t)
(setq-default TeX-master nil)
(setq TeX-parse-self t)
(setq TeX-auto-save t)

(auto-fill-mode t)
(reftex-mode t)
(setq TeX-electric-math (cons "$" "$") ) ; auto close dollars
;; Use zathura for previews
(setq TeX-source-correlate-mode t)
;;(add-to-list 'TeX-view-program-selection '(output-pdf "Zathura"))


(add-to-list 'default-frame-alist '(height . 61))
(add-to-list 'default-frame-alist '(width . 140))

(require 'iso-transl)

(require 'tex-site)

(menu-bar-mode 0)
