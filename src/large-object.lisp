(in-package #:large-object)

(defconstant +INV-ARCHIVE+ #x10000)     ; fe-lobj.c
(defconstant +INV-WRITE+   #x20000)
(defconstant +INV-READ+    #x40000)

(defconstant +SEEK-SET+ 0)
(defconstant +SEEK-CUR+ 1)
(defconstant +SEEK-END+ 2)

(defconstant +LARGE-OBJECT-BUFFER-SIZE+ 1024)

(defprepared-with-names lo-create (&optional (oid 0))
  ((:select (:lo-create '$1)) oid) :single)

(defprepared-with-names lo-open (oid mode)
  ((:select (:lo-open '$1 '$2)) oid mode) :single)

(defprepared-with-names lo-write (fd buf)
  ((:select (:lowrite '$1 '$2)) fd buf) :single)

(defprepared-with-names lo-read (fd len)
  ((:select (:loread '$1 '$2)) fd len) :single)

(defprepared-with-names lo-lseek (fd offset whence)
  ((:select (:lo-lseek '$1 '$2 '$3)) fd offset whence) :single)

(defprepared-with-names lo-tell (fd)
  ((:select (:lo-tell '$1)) fd) :single)

(defprepared-with-names lo-close (fd)
  ((:select (:lo-close '$1)) fd) :single)

(defprepared-with-names lo-unlink (oid)
  ((:select (:lo-unlink '$1)) oid) :single)

(defclass large-object-stream
    (fundamental-binary-stream
     trivial-gray-stream-mixin)
  ((fd :initarg :fd :reader fd-of)))

(defmethod stream-element-type ((stream large-object-stream))
  '(unsigned-byte 8))

(defun open-large-object (oid mode)
  (make-instance 'large-object-stream
		 :fd (lo-open oid mode)))

(defmethod stream-write-sequence ((stream large-object-stream)
				  sequence start end
				  &key &allow-other-keys)
  (lo-write (fd-of stream) (subseq sequence start end)))

(defmethod stream-read-sequence ((stream large-object-stream)
				 sequence start end
				 &key &allow-other-keys)
  (loop for element being the elements of (lo-read (fd-of stream) (- end start))
     for index from start below end
     do (setf (elt sequence index) element)
     finally (return index)))

(defmethod stream-file-position ((stream large-object-stream))
  (lo-tell (fd-of stream)))

(defmethod (setf stream-file-position) (position-spec (stream large-object-stream))
  (apply #'lo-lseek (fd-of stream) position-spec))

;;(defprepared-with-names lo_import (pathname)
;;  ((:select (:lo-create oid)) :single))

;;(defprepared-with-names lo_export (oid pathname)
;;  ((:select (:lo-create oid)) :single))