(in-package :large-object)

(defconstant +INV-ARCHIVE+ #x10000)     ; fe-lobj.c
(defconstant +INV-WRITE+   #x20000)
(defconstant +INV-READ+    #x40000)
(defconstant +LARGE-OBJECT-BUFFER-SIZE+ 1024)

(defprepared-with-names lo-create (&optional (oid 0))
  ((:select (:lo-create '$1)) oid) :single)

(defprepared-with-names lo-open (oid mode)
  ((:select (:lo-open '$1 '$2)) oid mode) :single)

(defprepared-with-names lo-write (fd buf)
  ((:select (:lowrite '$1 '$2)) fd buf) :single)

(defprepared-with-names lo-read (fd len)
  ((:select (:loread '$1 '$2)) fd len) :single)

(defprepared-with-names lo-lseek (fd offset int whence)
  ((:select (:lo-lseek '$1 '$2 '$3 '$4)) fd offset int whence) :single)

(defprepared-with-names lo-tell (fd)
  ((:select (:lo-tell '$1)) fd) :single)

(defprepared-with-names lo-close (fd)
  ((:select (:lo-close '$1)) fd) :single)

(defprepared-with-names lo-unlink (oid)
  ((:select (:lo-unlink '$1)) oid) :single)

(defclass large-object-stream (trivial-gray-stream-mixin)
  ((fd :initarg :fd :reader fd-of)
   (mode :initarg :mode :reader mode-of)
   (oid :initarg :oid :reader oid-of)))

;;(defmethod stream-write-sequence ((stream large-object-stream) sequence start end)
;;  (lo-write (fd-of stream) )

;;(defmethod stream-read-sequence ((stream large-object-stream) sequence start end)
;;  ())

;;(defmethod stream-file-position ((stream large-object-stream))
;;  (=> file position))
	   
;;(defmethod (setf stream-file-position) (position-spec (stream large-object-stream))
;;  => successp)

;;(defprepared-with-names lo_import (pathname)
;;  ((:select (:lo-create oid)) :single))

;;(defprepared-with-names lo_export (oid pathname)
;;  ((:select (:lo-create oid)) :single))