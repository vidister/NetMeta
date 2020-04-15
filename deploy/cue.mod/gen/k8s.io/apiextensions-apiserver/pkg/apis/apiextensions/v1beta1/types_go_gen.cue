// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1beta1

package v1beta1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
	"k8s.io/apimachinery/pkg/types"
)

// ConversionStrategyType describes different conversion types.
ConversionStrategyType :: string // enumConversionStrategyType

enumConversionStrategyType ::
	NoneConverter |
	WebhookConverter

// KubeAPIApprovedAnnotation is an annotation that must be set to create a CRD for the k8s.io, *.k8s.io, kubernetes.io, or *.kubernetes.io namespaces.
// The value should be a link to a URL where the current spec was approved, so updates to the spec should also update the URL.
// If the API is unapproved, you may set the annotation to a string starting with `"unapproved"`.  For instance, `"unapproved, temporarily squatting"` or `"unapproved, experimental-only"`.  This is discouraged.
KubeAPIApprovedAnnotation :: "api-approved.kubernetes.io"

// NoneConverter is a converter that only sets apiversion of the CR and leave everything else unchanged.
NoneConverter :: ConversionStrategyType & "None"

// WebhookConverter is a converter that calls to an external webhook to convert the CR.
WebhookConverter :: ConversionStrategyType & "Webhook"

// CustomResourceDefinitionSpec describes how a user wants their resource to appear
CustomResourceDefinitionSpec :: {
	// group is the API group of the defined custom resource.
	// The custom resources are served under `/apis/<group>/...`.
	// Must match the name of the CustomResourceDefinition (in the form `<names.plural>.<group>`).
	group: string @go(Group) @protobuf(1,bytes,opt)

	// version is the API version of the defined custom resource.
	// The custom resources are served under `/apis/<group>/<version>/...`.
	// Must match the name of the first item in the `versions` list if `version` and `versions` are both specified.
	// Optional if `versions` is specified.
	// Deprecated: use `versions` instead.
	// +optional
	version?: string @go(Version) @protobuf(2,bytes,opt)

	// names specify the resource and kind names for the custom resource.
	names: CustomResourceDefinitionNames @go(Names) @protobuf(3,bytes,opt)

	// scope indicates whether the defined custom resource is cluster- or namespace-scoped.
	// Allowed values are `Cluster` and `Namespaced`. Default is `Namespaced`.
	scope: ResourceScope @go(Scope) @protobuf(4,bytes,opt,casttype=ResourceScope)

	// validation describes the schema used for validation and pruning of the custom resource.
	// If present, this validation schema is used to validate all versions.
	// Top-level and per-version schemas are mutually exclusive.
	// +optional
	validation?: null | CustomResourceValidation @go(Validation,*CustomResourceValidation) @protobuf(5,bytes,opt)

	// subresources specify what subresources the defined custom resource has.
	// If present, this field configures subresources for all versions.
	// Top-level and per-version subresources are mutually exclusive.
	// +optional
	subresources?: null | CustomResourceSubresources @go(Subresources,*CustomResourceSubresources) @protobuf(6,bytes,opt)

	// versions is the list of all API versions of the defined custom resource.
	// Optional if `version` is specified.
	// The name of the first item in the `versions` list must match the `version` field if `version` and `versions` are both specified.
	// Version names are used to compute the order in which served versions are listed in API discovery.
	// If the version string is "kube-like", it will sort above non "kube-like" version strings, which are ordered
	// lexicographically. "Kube-like" versions start with a "v", then are followed by a number (the major version),
	// then optionally the string "alpha" or "beta" and another number (the minor version). These are sorted first
	// by GA > beta > alpha (where GA is a version with no suffix such as beta or alpha), and then by comparing
	// major version, then minor version. An example sorted list of versions:
	// v10, v2, v1, v11beta2, v10beta3, v3beta1, v12alpha1, v11alpha2, foo1, foo10.
	// +optional
	versions?: [...CustomResourceDefinitionVersion] @go(Versions,[]CustomResourceDefinitionVersion) @protobuf(7,bytes,rep)

	// additionalPrinterColumns specifies additional columns returned in Table output.
	// See https://kubernetes.io/docs/reference/using-api/api-concepts/#receiving-resources-as-tables for details.
	// If present, this field configures columns for all versions.
	// Top-level and per-version columns are mutually exclusive.
	// If no top-level or per-version columns are specified, a single column displaying the age of the custom resource is used.
	// +optional
	additionalPrinterColumns?: [...CustomResourceColumnDefinition] @go(AdditionalPrinterColumns,[]CustomResourceColumnDefinition) @protobuf(8,bytes,rep)

	// conversion defines conversion settings for the CRD.
	// +optional
	conversion?: null | CustomResourceConversion @go(Conversion,*CustomResourceConversion) @protobuf(9,bytes,opt)

	// preserveUnknownFields indicates that object fields which are not specified
	// in the OpenAPI schema should be preserved when persisting to storage.
	// apiVersion, kind, metadata and known fields inside metadata are always preserved.
	// If false, schemas must be defined for all versions.
	// Defaults to true in v1beta for backwards compatibility.
	// Deprecated: will be required to be false in v1. Preservation of unknown fields can be specified
	// in the validation schema using the `x-kubernetes-preserve-unknown-fields: true` extension.
	// See https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/#pruning-versus-preserving-unknown-fields for details.
	// +optional
	preserveUnknownFields?: null | bool @go(PreserveUnknownFields,*bool) @protobuf(10,varint,opt)
}

// CustomResourceConversion describes how to convert different versions of a CR.
CustomResourceConversion :: {
	// strategy specifies how custom resources are converted between versions. Allowed values are:
	// - `None`: The converter only change the apiVersion and would not touch any other field in the custom resource.
	// - `Webhook`: API Server will call to an external webhook to do the conversion. Additional information
	//   is needed for this option. This requires spec.preserveUnknownFields to be false, and spec.conversion.webhookClientConfig to be set.
	strategy: ConversionStrategyType @go(Strategy) @protobuf(1,bytes)

	// webhookClientConfig is the instructions for how to call the webhook if strategy is `Webhook`.
	// Required when `strategy` is set to `Webhook`.
	// +optional
	webhookClientConfig?: null | WebhookClientConfig @go(WebhookClientConfig,*WebhookClientConfig) @protobuf(2,bytes)

	// conversionReviewVersions is an ordered list of preferred `ConversionReview`
	// versions the Webhook expects. The API server will use the first version in
	// the list which it supports. If none of the versions specified in this list
	// are supported by API server, conversion will fail for the custom resource.
	// If a persisted Webhook configuration specifies allowed versions and does not
	// include any versions known to the API Server, calls to the webhook will fail.
	// Defaults to `["v1beta1"]`.
	// +optional
	conversionReviewVersions?: [...string] @go(ConversionReviewVersions,[]string) @protobuf(3,bytes,rep)
}

// WebhookClientConfig contains the information to make a TLS connection with the webhook.
WebhookClientConfig :: {
	// url gives the location of the webhook, in standard URL form
	// (`scheme://host:port/path`). Exactly one of `url` or `service`
	// must be specified.
	//
	// The `host` should not refer to a service running in the cluster; use
	// the `service` field instead. The host might be resolved via external
	// DNS in some apiservers (e.g., `kube-apiserver` cannot resolve
	// in-cluster DNS as that would be a layering violation). `host` may
	// also be an IP address.
	//
	// Please note that using `localhost` or `127.0.0.1` as a `host` is
	// risky unless you take great care to run this webhook on all hosts
	// which run an apiserver which might need to make calls to this
	// webhook. Such installs are likely to be non-portable, i.e., not easy
	// to turn up in a new cluster.
	//
	// The scheme must be "https"; the URL must begin with "https://".
	//
	// A path is optional, and if present may be any string permissible in
	// a URL. You may use the path to pass an arbitrary string to the
	// webhook, for example, a cluster identifier.
	//
	// Attempting to use a user or basic auth e.g. "user:password@" is not
	// allowed. Fragments ("#...") and query parameters ("?...") are not
	// allowed, either.
	//
	// +optional
	url?: null | string @go(URL,*string) @protobuf(3,bytes,opt)

	// service is a reference to the service for this webhook. Either
	// service or url must be specified.
	//
	// If the webhook is running within the cluster, then you should use `service`.
	//
	// +optional
	service?: null | ServiceReference @go(Service,*ServiceReference) @protobuf(1,bytes,opt)

	// caBundle is a PEM encoded CA bundle which will be used to validate the webhook's server certificate.
	// If unspecified, system trust roots on the apiserver are used.
	// +optional
	caBundle?: bytes @go(CABundle,[]byte) @protobuf(2,bytes,opt)
}

// ServiceReference holds a reference to Service.legacy.k8s.io
ServiceReference :: {
	// namespace is the namespace of the service.
	// Required
	namespace: string @go(Namespace) @protobuf(1,bytes,opt)

	// name is the name of the service.
	// Required
	name: string @go(Name) @protobuf(2,bytes,opt)

	// path is an optional URL path at which the webhook will be contacted.
	// +optional
	path?: null | string @go(Path,*string) @protobuf(3,bytes,opt)

	// port is an optional service port at which the webhook will be contacted.
	// `port` should be a valid port number (1-65535, inclusive).
	// Defaults to 443 for backward compatibility.
	// +optional
	port?: null | int32 @go(Port,*int32) @protobuf(4,varint,opt)
}

// CustomResourceDefinitionVersion describes a version for CRD.
CustomResourceDefinitionVersion :: {
	// name is the version name, e.g. “v1”, “v2beta1”, etc.
	// The custom resources are served under this version at `/apis/<group>/<version>/...` if `served` is true.
	name: string @go(Name) @protobuf(1,bytes,opt)

	// served is a flag enabling/disabling this version from being served via REST APIs
	served: bool @go(Served) @protobuf(2,varint,opt)

	// storage indicates this version should be used when persisting custom resources to storage.
	// There must be exactly one version with storage=true.
	storage: bool @go(Storage) @protobuf(3,varint,opt)

	// schema describes the schema used for validation and pruning of this version of the custom resource.
	// Top-level and per-version schemas are mutually exclusive.
	// Per-version schemas must not all be set to identical values (top-level validation schema should be used instead).
	// +optional
	schema?: null | CustomResourceValidation @go(Schema,*CustomResourceValidation) @protobuf(4,bytes,opt)

	// subresources specify what subresources this version of the defined custom resource have.
	// Top-level and per-version subresources are mutually exclusive.
	// Per-version subresources must not all be set to identical values (top-level subresources should be used instead).
	// +optional
	subresources?: null | CustomResourceSubresources @go(Subresources,*CustomResourceSubresources) @protobuf(5,bytes,opt)

	// additionalPrinterColumns specifies additional columns returned in Table output.
	// See https://kubernetes.io/docs/reference/using-api/api-concepts/#receiving-resources-as-tables for details.
	// Top-level and per-version columns are mutually exclusive.
	// Per-version columns must not all be set to identical values (top-level columns should be used instead).
	// If no top-level or per-version columns are specified, a single column displaying the age of the custom resource is used.
	// +optional
	additionalPrinterColumns?: [...CustomResourceColumnDefinition] @go(AdditionalPrinterColumns,[]CustomResourceColumnDefinition) @protobuf(6,bytes,rep)
}

// CustomResourceColumnDefinition specifies a column for server side printing.
CustomResourceColumnDefinition :: {
	// name is a human readable name for the column.
	name: string @go(Name) @protobuf(1,bytes,opt)

	// type is an OpenAPI type definition for this column.
	// See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types for details.
	type: string @go(Type) @protobuf(2,bytes,opt)

	// format is an optional OpenAPI type definition for this column. The 'name' format is applied
	// to the primary identifier column to assist in clients identifying column is the resource name.
	// See https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md#data-types for details.
	// +optional
	format?: string @go(Format) @protobuf(3,bytes,opt)

	// description is a human readable description of this column.
	// +optional
	description?: string @go(Description) @protobuf(4,bytes,opt)

	// priority is an integer defining the relative importance of this column compared to others. Lower
	// numbers are considered higher priority. Columns that may be omitted in limited space scenarios
	// should be given a priority greater than 0.
	// +optional
	priority?: int32 @go(Priority) @protobuf(5,bytes,opt)

	// JSONPath is a simple JSON path (i.e. with array notation) which is evaluated against
	// each custom resource to produce the value for this column.
	JSONPath: string @protobuf(6,bytes,opt)
}

// CustomResourceDefinitionNames indicates the names to serve this CustomResourceDefinition
CustomResourceDefinitionNames :: {
	// plural is the plural name of the resource to serve.
	// The custom resources are served under `/apis/<group>/<version>/.../<plural>`.
	// Must match the name of the CustomResourceDefinition (in the form `<names.plural>.<group>`).
	// Must be all lowercase.
	plural: string @go(Plural) @protobuf(1,bytes,opt)

	// singular is the singular name of the resource. It must be all lowercase. Defaults to lowercased `kind`.
	// +optional
	singular?: string @go(Singular) @protobuf(2,bytes,opt)

	// shortNames are short names for the resource, exposed in API discovery documents,
	// and used by clients to support invocations like `kubectl get <shortname>`.
	// It must be all lowercase.
	// +optional
	shortNames?: [...string] @go(ShortNames,[]string) @protobuf(3,bytes,opt)

	// kind is the serialized kind of the resource. It is normally CamelCase and singular.
	// Custom resource instances will use this value as the `kind` attribute in API calls.
	kind: string @go(Kind) @protobuf(4,bytes,opt)

	// listKind is the serialized kind of the list for this resource. Defaults to "`kind`List".
	// +optional
	listKind?: string @go(ListKind) @protobuf(5,bytes,opt)

	// categories is a list of grouped resources this custom resource belongs to (e.g. 'all').
	// This is published in API discovery documents, and used by clients to support invocations like
	// `kubectl get all`.
	// +optional
	categories?: [...string] @go(Categories,[]string) @protobuf(6,bytes,rep)
}

// ResourceScope is an enum defining the different scopes available to a custom resource
ResourceScope :: string // enumResourceScope

enumResourceScope ::
	ClusterScoped |
	NamespaceScoped

ClusterScoped ::   ResourceScope & "Cluster"
NamespaceScoped :: ResourceScope & "Namespaced"

ConditionStatus :: string // enumConditionStatus

enumConditionStatus ::
	ConditionTrue |
	ConditionFalse |
	ConditionUnknown

ConditionTrue ::    ConditionStatus & "True"
ConditionFalse ::   ConditionStatus & "False"
ConditionUnknown :: ConditionStatus & "Unknown"

// CustomResourceDefinitionConditionType is a valid value for CustomResourceDefinitionCondition.Type
CustomResourceDefinitionConditionType :: string // enumCustomResourceDefinitionConditionType

enumCustomResourceDefinitionConditionType ::
	Established |
	NamesAccepted |
	NonStructuralSchema |
	Terminating |
	KubernetesAPIApprovalPolicyConformant

// Established means that the resource has become active. A resource is established when all names are
// accepted without a conflict for the first time. A resource stays established until deleted, even during
// a later NamesAccepted due to changed names. Note that not all names can be changed.
Established :: CustomResourceDefinitionConditionType & "Established"

// NamesAccepted means the names chosen for this CustomResourceDefinition do not conflict with others in
// the group and are therefore accepted.
NamesAccepted :: CustomResourceDefinitionConditionType & "NamesAccepted"

// NonStructuralSchema means that one or more OpenAPI schema is not structural.
//
// A schema is structural if it specifies types for all values, with the only exceptions of those with
// - x-kubernetes-int-or-string: true — for fields which can be integer or string
// - x-kubernetes-preserve-unknown-fields: true — for raw, unspecified JSON values
// and there is no type, additionalProperties, default, nullable or x-kubernetes-* vendor extenions
// specified under allOf, anyOf, oneOf or not.
//
// Non-structural schemas will not be allowed anymore in v1 API groups. Moreover, new features will not be
// available for non-structural CRDs:
// - pruning
// - defaulting
// - read-only
// - OpenAPI publishing
// - webhook conversion
NonStructuralSchema :: CustomResourceDefinitionConditionType & "NonStructuralSchema"

// Terminating means that the CustomResourceDefinition has been deleted and is cleaning up.
Terminating :: CustomResourceDefinitionConditionType & "Terminating"

// KubernetesAPIApprovalPolicyConformant indicates that an API in *.k8s.io or *.kubernetes.io is or is not approved.  For CRDs
// outside those groups, this condition will not be set.  For CRDs inside those groups, the condition will
// be true if .metadata.annotations["api-approved.kubernetes.io"] is set to a URL, otherwise it will be false.
// See https://github.com/kubernetes/enhancements/pull/1111 for more details.
KubernetesAPIApprovalPolicyConformant :: CustomResourceDefinitionConditionType & "KubernetesAPIApprovalPolicyConformant"

// CustomResourceDefinitionCondition contains details for the current condition of this pod.
CustomResourceDefinitionCondition :: {
	// type is the type of the condition. Types include Established, NamesAccepted and Terminating.
	type: CustomResourceDefinitionConditionType @go(Type) @protobuf(1,bytes,opt,casttype=CustomResourceDefinitionConditionType)

	// status is the status of the condition.
	// Can be True, False, Unknown.
	status: ConditionStatus @go(Status) @protobuf(2,bytes,opt,casttype=ConditionStatus)

	// lastTransitionTime last time the condition transitioned from one status to another.
	// +optional
	lastTransitionTime?: metav1.Time @go(LastTransitionTime) @protobuf(3,bytes,opt)

	// reason is a unique, one-word, CamelCase reason for the condition's last transition.
	// +optional
	reason?: string @go(Reason) @protobuf(4,bytes,opt)

	// message is a human-readable message indicating details about last transition.
	// +optional
	message?: string @go(Message) @protobuf(5,bytes,opt)
}

// CustomResourceDefinitionStatus indicates the state of the CustomResourceDefinition
CustomResourceDefinitionStatus :: {
	// conditions indicate state for particular aspects of a CustomResourceDefinition
	// +optional
	conditions: [...CustomResourceDefinitionCondition] @go(Conditions,[]CustomResourceDefinitionCondition) @protobuf(1,bytes,opt)

	// acceptedNames are the names that are actually being used to serve discovery.
	// They may be different than the names in spec.
	// +optional
	acceptedNames: CustomResourceDefinitionNames @go(AcceptedNames) @protobuf(2,bytes,opt)

	// storedVersions lists all versions of CustomResources that were ever persisted. Tracking these
	// versions allows a migration path for stored versions in etcd. The field is mutable
	// so a migration controller can finish a migration to another version (ensuring
	// no old objects are left in storage), and then remove the rest of the
	// versions from this list.
	// Versions may not be removed from `spec.versions` while they exist in this list.
	// +optional
	storedVersions: [...string] @go(StoredVersions,[]string) @protobuf(3,bytes,rep)
}

CustomResourceCleanupFinalizer :: "customresourcecleanup.apiextensions.k8s.io"

// CustomResourceDefinition represents a resource that should be exposed on the API server.  Its name MUST be in the format
// <.spec.name>.<.spec.group>.
// Deprecated in v1.16, planned for removal in v1.19. Use apiextensions.k8s.io/v1 CustomResourceDefinition instead.
CustomResourceDefinition :: {
	metav1.TypeMeta
	metadata?: metav1.ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// spec describes how the user wants the resources to appear
	spec: CustomResourceDefinitionSpec @go(Spec) @protobuf(2,bytes,opt)

	// status indicates the actual state of the CustomResourceDefinition
	// +optional
	status?: CustomResourceDefinitionStatus @go(Status) @protobuf(3,bytes,opt)
}

// CustomResourceDefinitionList is a list of CustomResourceDefinition objects.
CustomResourceDefinitionList :: {
	metav1.TypeMeta
	metadata?: metav1.ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// items list individual CustomResourceDefinition objects
	items: [...CustomResourceDefinition] @go(Items,[]CustomResourceDefinition) @protobuf(2,bytes,rep)
}

// CustomResourceValidation is a list of validation methods for CustomResources.
CustomResourceValidation :: {
	// openAPIV3Schema is the OpenAPI v3 schema to use for validation and pruning.
	// +optional
	openAPIV3Schema?: null | JSONSchemaProps @go(OpenAPIV3Schema,*JSONSchemaProps) @protobuf(1,bytes,opt)
}

// CustomResourceSubresources defines the status and scale subresources for CustomResources.
CustomResourceSubresources :: {
	// status indicates the custom resource should serve a `/status` subresource.
	// When enabled:
	// 1. requests to the custom resource primary endpoint ignore changes to the `status` stanza of the object.
	// 2. requests to the custom resource `/status` subresource ignore changes to anything other than the `status` stanza of the object.
	// +optional
	status?: null | CustomResourceSubresourceStatus @go(Status,*CustomResourceSubresourceStatus) @protobuf(1,bytes,opt)

	// scale indicates the custom resource should serve a `/scale` subresource that returns an `autoscaling/v1` Scale object.
	// +optional
	scale?: null | CustomResourceSubresourceScale @go(Scale,*CustomResourceSubresourceScale) @protobuf(2,bytes,opt)
}

// CustomResourceSubresourceStatus defines how to serve the status subresource for CustomResources.
// Status is represented by the `.status` JSON path inside of a CustomResource. When set,
// * exposes a /status subresource for the custom resource
// * PUT requests to the /status subresource take a custom resource object, and ignore changes to anything except the status stanza
// * PUT/POST/PATCH requests to the custom resource ignore changes to the status stanza
CustomResourceSubresourceStatus :: {
}

// CustomResourceSubresourceScale defines how to serve the scale subresource for CustomResources.
CustomResourceSubresourceScale :: {
	// specReplicasPath defines the JSON path inside of a custom resource that corresponds to Scale `spec.replicas`.
	// Only JSON paths without the array notation are allowed.
	// Must be a JSON Path under `.spec`.
	// If there is no value under the given path in the custom resource, the `/scale` subresource will return an error on GET.
	specReplicasPath: string @go(SpecReplicasPath) @protobuf(1,bytes)

	// statusReplicasPath defines the JSON path inside of a custom resource that corresponds to Scale `status.replicas`.
	// Only JSON paths without the array notation are allowed.
	// Must be a JSON Path under `.status`.
	// If there is no value under the given path in the custom resource, the `status.replicas` value in the `/scale` subresource
	// will default to 0.
	statusReplicasPath: string @go(StatusReplicasPath) @protobuf(2,bytes,opt)

	// labelSelectorPath defines the JSON path inside of a custom resource that corresponds to Scale `status.selector`.
	// Only JSON paths without the array notation are allowed.
	// Must be a JSON Path under `.status` or `.spec`.
	// Must be set to work with HorizontalPodAutoscaler.
	// The field pointed by this JSON path must be a string field (not a complex selector struct)
	// which contains a serialized label selector in string form.
	// More info: https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions#scale-subresource
	// If there is no value under the given path in the custom resource, the `status.selector` value in the `/scale`
	// subresource will default to the empty string.
	// +optional
	labelSelectorPath?: null | string @go(LabelSelectorPath,*string) @protobuf(3,bytes,opt)
}

// ConversionReview describes a conversion request/response.
ConversionReview :: {
	metav1.TypeMeta

	// request describes the attributes for the conversion request.
	// +optional
	request?: null | ConversionRequest @go(Request,*ConversionRequest) @protobuf(1,bytes,opt)

	// response describes the attributes for the conversion response.
	// +optional
	response?: null | ConversionResponse @go(Response,*ConversionResponse) @protobuf(2,bytes,opt)
}

// ConversionRequest describes the conversion request parameters.
ConversionRequest :: {
	// uid is an identifier for the individual request/response. It allows distinguishing instances of requests which are
	// otherwise identical (parallel requests, etc).
	// The UID is meant to track the round trip (request/response) between the Kubernetes API server and the webhook, not the user request.
	// It is suitable for correlating log entries between the webhook and apiserver, for either auditing or debugging.
	uid: types.UID @go(UID) @protobuf(1,bytes)

	// desiredAPIVersion is the version to convert given objects to. e.g. "myapi.example.com/v1"
	desiredAPIVersion: string @go(DesiredAPIVersion) @protobuf(2,bytes)

	// objects is the list of custom resource objects to be converted.
	objects: [...runtime.RawExtension] @go(Objects,[]runtime.RawExtension) @protobuf(3,bytes,rep)
}

// ConversionResponse describes a conversion response.
ConversionResponse :: {
	// uid is an identifier for the individual request/response.
	// This should be copied over from the corresponding `request.uid`.
	uid: types.UID @go(UID) @protobuf(1,bytes)

	// convertedObjects is the list of converted version of `request.objects` if the `result` is successful, otherwise empty.
	// The webhook is expected to set `apiVersion` of these objects to the `request.desiredAPIVersion`. The list
	// must also have the same size as the input list with the same objects in the same order (equal kind, metadata.uid, metadata.name and metadata.namespace).
	// The webhook is allowed to mutate labels and annotations. Any other change to the metadata is silently ignored.
	convertedObjects: [...runtime.RawExtension] @go(ConvertedObjects,[]runtime.RawExtension) @protobuf(2,bytes,rep)

	// result contains the result of conversion with extra details if the conversion failed. `result.status` determines if
	// the conversion failed or succeeded. The `result.status` field is required and represents the success or failure of the
	// conversion. A successful conversion must set `result.status` to `Success`. A failed conversion must set
	// `result.status` to `Failure` and provide more details in `result.message` and return http status 200. The `result.message`
	// will be used to construct an error message for the end user.
	result: metav1.Status @go(Result) @protobuf(3,bytes)
}
