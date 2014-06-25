(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(setq initial-scratch-message
  (format ";; scratch buffer created %s\n\n"
  (format-time-string "%Y-%m-%d at %T"))
)

(setq column-number-mode t)
(setq line-number-mode t)
(global-font-lock-mode t)

(defun command-line-find-file-read-only (switch)
   (find-file-read-only (pop command-line-args-left)))

(add-to-list 'command-switch-alist
             '("--read-only" . command-line-find-file-read-only))


; tab stops
(setq tab-width 4
      cperl-indent-level 4
      cperl-tab-always-indent 1)

; use spaces instead of tabs
(defun set-tabs-equals-spaces-hook ()
     (setq tab-width 4 indent-tabs-mode nil))
(setq-default indent-tabs-mode nil)

;(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)

(setq cperl-indent-level 4)
(setq auto-mode-alist (append '(("\\.\\([pP][Llm]\\|al\\|t\\)$" . cperl-mode))  auto-mode-alist ))
(setq interpreter-mode-alist (append interpreter-mode-alist '(("perl" . cperl-mode))))

(add-hook 'perl-mode-hook
	  '(lambda nil
	     (local-set-key "\ep" 'indent-all)
	     (set-tabs-equals-spaces-hook)
	     )
	  )
(add-hook 'cperl-mode-hook
	  '(lambda nil
	     (local-set-key "\ep" 'indent-all)
	     (set-tabs-equals-spaces-hook)
	     )
	  )

(load "~/.emacs.d/modes/php-mode")
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; Change title bar to ~/file-directory if the current buffer is a
;; real file or buffer name if it is just a buffer.
(setq frame-title-format
      '("emacs %S: " (buffer-file-name "%f" (dired-directory dired-directory "%b"))))

; map M-g to goto-line
(global-set-key (kbd "M-g") 'goto-line)

;; enable visual feedback on selections
(setq transient-mark-mode t)

(defun smart-split ()
  "Split the frame into 80-column sub-windows, and make sure no window has
   fewer than 80 columns."
  (interactive)
  (defun smart-split-helper (w)
    "Helper function to split a given window into two, the first of which has 
     80 columns."
    (if (> (window-width w) (* 2 81))
    (let ((w2 (split-window w 87 t)))
      (smart-split-helper w2))))
  (smart-split-helper nil))

;-------------------------------------------------------------------------------
(defun big-split ()
  "Split the frame into two 80-column, 60-row sub-windows"
  (interactive)
  ;(set-frame-position (selected-frame) 594 640)
  (set-frame-size (selected-frame) 168 60)
  (split-window-horizontally)
)
;-------------------------------------------------------------------------------
(defun huge-split ()
  "Split the frame into three 80-column, 60-row sub-windows"
  (interactive)
  ;(set-frame-position (selected-frame) 594 640)
  (set-frame-size (selected-frame) 255 60)
  (smart-split)
)
;-------------------------------------------------------------------------------
(defun vast-split ()
  "Split the frame into four 80-column, 60-row sub-windows"
  (interactive)
  ;(set-frame-position (selected-frame) 594 640)
  (set-frame-size (selected-frame) 342 60)
  (smart-split)
)
;-------------------------------------------------------------------------------
(defun home-split ()
  "Split the frame into six 80-column, 100-row sub-windows"
  (interactive)
  ;(set-frame-position (selected-frame) 594 640)
  (set-frame-size (selected-frame) 516 100)
  (smart-split)
)
;-------------------------------------------------------------------------------

; start the server
(server-start)

(defun read-only-file (file)
  "Open a file in a buffer and make the buffer read-only"
  (interactive)
  (find-file file)
  (toggle-read-only))

(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-unix t))
(defun dos-file ()
  "Change the current buffer to Latin 1 with DOS line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-dos t))
(defun mac-file ()
  "Change the current buffer to Latin 1 with Mac line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-mac t))

;-------------------------------------------------------------------------------

(defun no-trailing-whitespace ()
  (interactive)
  (goto-char 1)
  (while (search-forward-regexp "[ ]+
" nil t)
    (replace-match "
" t nil)))

;-------------------------------------------------------------------------------

 (global-set-key
  (kbd "<f5>")
  (lambda (&optional force-reverting)
    "Interactive call to revert-buffer. Ignoring the auto-save
 file and not requesting for confirmation. When the current buffer
 is modified, the command refuses to revert it, unless you specify
 the optional argument: force-reverting to true."
    (interactive "P")
    ;;(message "force-reverting value is %s" force-reverting)
    (if (or force-reverting (not (buffer-modified-p)))
        (revert-buffer :ignore-auto :noconfirm)
      (error "The buffer has been modified"))))

;-------------------------------------------------------------------------------

;(require 'fill-column-indicator)
