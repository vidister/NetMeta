// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/apimachinery/pkg/watch

package watch

// Decoder allows StreamWatcher to watch any stream for which a Decoder can be written.
Decoder :: _

// Reporter hides the details of how an error is turned into a runtime.Object for
// reporting on a watch stream since this package may not import a higher level report.
Reporter :: _
