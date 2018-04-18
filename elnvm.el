;;; nvm management -*- lexical-binding: t -*-

(defvar node nil
  "A variable set to the nodejs program binary.")
(defvar npm nil
  "A variable set to the npm program binary.")
(defvar nodejs nil
  "A variable set to the nodejs program binary")

(defun nvm-get-path (completion-fn)
  "Use a bash login shell to get the current nvm version.

Argument COMPLETION-FN function taking one argument receives the
completed operation."
  (let* ((proc (start-process
                "nicnvm"
                (prog1 (get-buffer-create "*nvm*")
                  (with-current-buffer (get-buffer "*nvm*")
                    (erase-buffer)))
                "bash" "--login"))
         (filter (set-process-filter
                  proc
                  (lambda (p data)
                    (with-current-buffer "*nvm*"
                      (insert data))
                    (if (string-match-p ".*\\$ $" data)
                        (process-send-string p "nvm which current\n")
                      ;; else
                      (let ((nvm-response
                             (progn
                               (string-match "\\(.*\\)\n$" data)
                               (match-string 1 data))))
                        (delete-process proc)
                        (funcall completion-fn nvm-response)))))))
    proc))

(defun nvm-init ()
  "Initialize the current Emacs NVM env using bash nvm."
  (nvm-get-path
   (lambda (node-path)
     (let ((node-dir (file-name-directory node-path)))
       (message "nvm node-dir: %s" node-dir)
       (setenv "PATH" (concat (getenv "PATH") ":" node-dir))
       (setq nodejs (expand-file-name "node" node-dir))
       (setq node (expand-file-name "node" node-dir))
       (setq npm (expand-file-name "npm" node-dir))))))

(nvm-init)

;;; elnvm.el ends here
