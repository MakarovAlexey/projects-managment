(defpackage #:projects-managment
  (:use :cl :manardb)
  (:export :project
           :task-group-child
           :task-group
           :task
           :comment
           :document-list
           :document
           :name-of
           :task-groups-of
           :document-lists-of
           :parent-of
           :predecessors-of
           :children-of
           :days-of
           :begin-date-of
           :end-date-of
           :complite-date-of
           :executor-of
           :comments-of
           :author-of
           :text-of
           :documents-of
           :properties-of
           :document-list-of
           :properties-of
           :stream-of))

(defpackage #:large-object
  (:use #:cl #:postmodern #:trivial-gray-streams)
  (:export #:+INV-ARCHIVE+
	   #:+INV-WRITE+
	   #:+INV-READ+
	   #:+LARGE-OBJECT-BUFFER-SIZE+
	   #:lo-create
	   #:lo-unlink
	   #:lo-open
	   #:lo-close
	   #:lo-write
	   #:lo-read))

(defpackage #:large-object.test
  (:use #:cl #:large-object #:lift))