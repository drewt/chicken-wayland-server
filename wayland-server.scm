;; Copyright 2019 Drew Thoreson
;;
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to
;; deal in the Software without restriction, including without limitation the
;; rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
;; sell copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
;; IN THE SOFTWARE.

(foreign-declare "#include <wayland-server.h>")

#>
struct scheme_wl_listener {
    struct wl_listener listener;
    void *callback_root;
};
<#

(include "wayland-types.scm")

(module (wayland-server)
        (wl-event-loop-create
         wl-event-loop-destroy
         wl-event-loop-add-fd
         wl-event-source-fd-update
         wl-event-loop-add-timer
         wl-event-loop-add-signal
         wl-event-source-timer-update
         wl-event-source-remove
         wl-event-source-check
         wl-event-loop-dispatch
         wl-event-loop-dispatch-idle
         wl-event-loop-add-idle
         wl-event-loop-get-fd
         wl-event-loop-add-destroy-listener
         ;wl-event-loop-get-destroy-listener

         wl-display-create
         wl-display-destroy
         wl-display-get-event-loop
         wl-display-add-socket
         wl-display-add-socket-auto
         wl-display-add-socket-fd
         wl-display-terminate
         wl-display-run
         wl-display-flush-clients
         wl-display-destroy-clients
         wl-display-get-serial
         wl-display-next-serial
         wl-display-add-destroy-listener
         wl-display-add-client-created-listener
         ;wl-display-get-destroy-listener
         wl-display-set-global-filter
         wl-display-get-client-list
         wl-display-init-shm
         wl-display-add-shm-format
         wl-display-add-protocol-logger

         wl-global-create
         wl-global-destroy
         wl-global-get-interface
         wl-global-get-user-data

         wl-client-create
         wl-client-get-link
         wl-client-from-link
         ;wl-client-for-each
         wl-client-destroy
         wl-client-flush
         wl-client-get-credentials
         wl-client-get-fd
         wl-client-add-destroy-listener
         ;wl-client-get-destroy-listener
         wl-client-get-object
         wl-client-post-no-memory
         wl-client-add-resource-created-listener
         ;wl-client-for-each-resource
         wl-client-get-display

         make-wl-listener
         free-wl-listener
         remove-wl-listener
         wl-listener-notify
         wl-signal-init
         wl-signal-add 
         ;wl-signal-get
         wl-signal-emit

         ;wl-resource-post-event
         wl-resource-post-event-array
         ;wl-resource-queue-event
         wl-resource-queue-event-array
         ;wl-resource-post-error
         wl-resource-post-no-memory
         wl-resource-create
         wl-resource-set-implementation
         wl-resource-set-dispatcher
         wl-resource-destroy
         wl-resource-get-id
         wl-resource-get-link
         wl-resource-from-link
         wl-resource-find-for-client
         wl-resource-get-client
         wl-resource-set-user-data
         wl-resource-get-user-data
         wl-resource-get-version
         wl-resource-set-destructor
         wl-resource-instance-of
         wl-resource-get-class
         wl-resource-add-destroy-listener
         ;wl-resource-get-destroy-listener
         ;wl-resource-for-each
         ;wl-resource-for-each-safe

         wl-shm-buffer-get
         wl-shm-buffer-begin-access
         wl-shm-buffer-end-access
         wl-shm-buffer-get-data
         wl-shm-buffer-get-stride
         wl-shm-buffer-get-format
         wl-shm-buffer-get-width
         wl-shm-buffer-get-height
         wl-shm-buffer-ref-pool
         wl-shm-pool-unref
         ;wl-shm-buffer-create

         wl-protocol-logger/request
         wl-protocol-logger/event
         wl-protocol-logger-message-resource
         wl-protocol-logger-message-message-opcode
         wl-protocol-logger-message-message
         wl-protocol-logger-message-arguments-count
         wl-protocol-logger-message-arguments
         wl-log-set-handler-server
         wl-protocol-logger-destroy

         wl-seat-capability/pointer
         wl-seat-capability/keyboard
         wl-seat-capability/touch

         make-wl-list
         free-wl-list
         wl-list-next
         wl-list-prev
         wl-list-init
         wl-list-insert
         wl-list-remove
         wl-list-length
         wl-list-empty?
         wl-list-insert-list
         wl-list-for-each
         wl-list-for-each/safe
         wl-list-for-each/reverse
         wl-list-for-each/reverse-safe
         wl-list->list

         make-wl-array
         free-wl-array
         wl-array-init
         wl-array-release
         wl-array-add
         wl-array-copy
         wl-array-for-each

         wl-fixed-to-double
         wl-fixed-from-double
         wl-fixed-to-int
         wl-fixed-from-int

         make-wl-argument
         wl-argument-i
         wl-argument-u
         wl-argument-f
         wl-argument-s
         wl-argument-o
         wl-argument-n
         wl-argument-a
         wl-argument-h

         wl-iterator/stop
         wl-iterator/continue
         )
  (import (scheme)
          (srfi 17)
          (chicken base)
          (chicken foreign)
          (chicken memory)
          (bind))

  ; FIXME: use configure script to determine correct size
  (bind-type "pid_t" int32)
  (bind-type "uid_t" unsigned-int32)
  (bind-type "gid_t" unsigned-int32)
  (bind-rename wl_list_empty wl-list-empty?)
  (bind-options export-constants: #t
              mutable-fields: #t
              default-renaming: "")
  (bind-file "wayland-server-core.h")
  (bind-file "wayland-util.h")

  ; Define a series of foreign values of the same type.
  (define-syntax define-foreign-values
    (syntax-rules ()
      ((define-foreign-values type)
        (begin))
      ((define-foreign-values type (scm-name c-name) . rest)
        (begin
          (define scm-name (foreign-value c-name type))
          (define-foreign-values type . rest)))))

  ; {{{ wayland-server-core

  (define-foreign-values int
    (wl-event/readable "WL_EVENT_READABLE")
    (wl-event/writable "WL_EVENT_WRITABLE")
    (wl-event/hangup   "WL_EVENT_HANGUP")
    (wl-event/ERROR    "WL_EVENT_ERROR"))

  (define wl-event-loop-add-destroy-listener
    (foreign-lambda* void ((wl-event-loop* loop) (scheme-wl-listener* listener))
      "wl_event_loop_add_destroy_listener(loop, &listener->listener);"))

  (define wl-display-add-destroy-listener
    (foreign-lambda* void ((wl-display* display) (scheme-wl-listener* listener))
      "wl_display_add_destroy_listener(display, &listener->listener);"))

  (define wl-display-add-client-created-listener
    (foreign-lambda* void ((wl-display* display) (scheme-wl-listener* listener))
      "wl_display_add_client_created_listener(display, &listener->listener);"))

  ; TODO
  ;wl-client-for-each

  ; TODO
  ;wl-client-for-each-resource

  ;;
  ;; wl_listener structs are intended to be embedded within larger structs,
  ;; which can then be accessed using the wl_container_of macro.  This does
  ;; not translate well into Scheme, so we have to get a bit clever.
  ;;
  ;; Rather than exposing raw wl_listener structs in these bindings, we wrap
  ;; them in a scheme_wl_listener, which also stores a Scheme callback. The
  ;; notify function for the wl_listener retrieves the scheme_wl_listener
  ;; and invokes the stored callback.
  ;;
  ;; To use the Scheme bindings, you should first set up a lexical
  ;; environment where all the data needed in the callback is available, and
  ;; then call make-wl-listener with a lambda constructed in that environment.
  ;;

  (define-external (scheme_wl_listener_notify (wl-listener* listener) (c-pointer data)) void
    (let ((wrapper (wl-listener->scheme-listener listener)))
      ((wl-listener-notify wrapper) data)))

  (define make-wl-listener
    (foreign-lambda* scheme-wl-listener* ((scheme-object callback))
      "struct scheme_wl_listener *listener = malloc(sizeof(struct scheme_wl_listener));"
      "listener->listener.notify = scheme_wl_listener_notify;"
      "listener->callback_root = CHICKEN_new_gc_root();"
      "CHICKEN_gc_root_set(listener->callback_root, callback);"
      "C_return(listener);"))

  (define free-wl-listener
    (foreign-lambda* void ((scheme-wl-listener* listener))
      "CHICKEN_delete_gc_root(listener->callback_root);"
      "free(listener);"))

  (define remove-wl-listener
    (foreign-lambda* void ((scheme-wl-listener* listener))
      "wl_list_remove(&listener->listener.link);"))

  (define wl-listener-notify
    (getter-with-setter
      (foreign-lambda* scheme-object ((scheme-wl-listener* listener))
        "C_return(CHICKEN_gc_root_ref(listener->callback_root));")
      (foreign-lambda* void ((scheme-wl-listener* listener) (scheme-object callback))
        "CHICKEN_gc_root_set(listener->callback_root, callback);")))

  (define wl-listener->scheme-listener
    (foreign-lambda* scheme-wl-listener* ((wl-listener* listener))
      "struct scheme_wl_listener *r = wl_container_of(listener, r, listener);"
      "C_return(r);"))

  (define wl-signal-add
    (foreign-lambda* void ((wl-signal* signal) (scheme-wl-listener* listener))
      "wl_signal_add(signal, &listener->listener);"))

  ; TODO: variadic
  ;wl-resource-post-event

  ; TODO: variadic
  ;wl-resource-queue-event

  ; TODO: variadic
  ;wl-resource-post-error

  (define wl-resource-add-destroy-listener
    (foreign-lambda* void ((wl-resource* resource) (scheme-wl-listener* listener))
      "wl_resource_add_destroy_listener(resource, &listener->listener);"))

  ; TODO
  ;wl-resource-for-each

  ; TODO
  ;wl-resource-for-each-safe

  (define-foreign-values wl-protocol-logger-type
    (wl-protocol-logger/request "WL_PROTOCOL_LOGGER_REQUEST")
    (wl-protocol-logger/event   "WL_PROTOCOL_LOGGER_EVENT"))

  (define-foreign-values wl-seat-capability
    (wl-seat-capability/pointer  "WL_SEAT_CAPABILITY_POINTER")
    (wl-seat-capability/keyboard "WL_SEAT_CAPABILITY_KEYBOARD")
    (wl-seat-capability/touch    "WL_SEAT_CAPABILITY_TOUCH"))

  ; }}} wayland-server-core
  ; {{{ wayland-util
  (define free-wl-list free)
  (define free-wl-array free) ; XXX: does NOT call wl_array_release

  ;;
  ;; As usual, we have to work around data structures that assume we
  ;; can use container_of. These iterators take as an optional argument
  ;; a function to convert wl-list nodes into the "real" objects (or
  ;; anything else). This achieves the same result in a different way.
  ;;
  (define (wl-list-for-each head fun #!optional (convert values))
    (let loop ((node (wl-list-next head)))
      (unless (pointer=? node head)
        (fun (convert node))
        (loop (wl-list-next node)))))

  (define (wl-list-for-each/safe head fun #!optional (convert values))
    (let loop ((node (wl-list-next head))
               (next (wl-list-next (wl-list-next head))))
      (unless (pointer=? node head)
        (fun (convert node))
        (loop next (wl-list-next next)))))

  (define (wl-list-for-each/reverse head fun #!optional (convert values))
    (let loop ((node (wl-list-prev head)))
      (unless (pointer=? node head)
        (fun (convert node))
        (loop (wl-list-prev node)))))
  
  (define (wl-list-for-each/reverse-safe head fun #!optional (convert values))
    (let loop ((node (wl-list-prev head))
               (prev (wl-list-prev (wl-list-prev head))))
      (unless (pointer=? node head)
        (fun (convert node))
        (loop prev (wl-list-prev prev)))))

  (define (wl-list->list wlist)
    (let loop ((node (wl-list-next wlist)) (result '()))
      (if (pointer=? node wlist)
        (reverse result)
        (loop (wl-list-next node) (cons node result)))))

  ;; XXX: The caller has to pass the size of the objects stored in the
  ;;      array explicitly.  Thankfully, there's foreign-type-size.
  (define (wl-array-for-each array size fun #!optional (convert values))
    (define array-next
      (foreign-lambda* c-pointer ((c-pointer ptr) (size_t size))
        "C_return((char*)ptr + size);"))
    (define array-end?
      (foreign-lambda* bool ((wl-array* array) (c-pointer ptr) (size_t size))
        "C_return((char*)ptr >= ((char*)array->data + array->size));"))
    (let loop ((ptr (wl-array-data array)))
      (unless (array-end? array ptr size)
        (fun (convert ptr))
        (loop (array-next ptr size)))))

  (define-foreign-values wl-iterator-result
    (wl-iterator/stop     "WL_ITERATOR_STOP")
    (wl-iterator/continue "WL_ITERATOR_CONTINUE"))
  )
  ; }}} wayland-util
