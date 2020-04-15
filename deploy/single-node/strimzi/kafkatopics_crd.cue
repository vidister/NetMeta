package k8s

k8s: crds: "kafkatopics.kafka.strimzi.io": spec: {
	group: "kafka.strimzi.io"
	versions: [{
		name:    "v1beta1"
		served:  true
		storage: true
	}, {
		name:    "v1alpha1"
		served:  true
		storage: false
	}]
	version: "v1beta1"
	scope:   "Namespaced"
	names: {
		kind:     "KafkaTopic"
		listKind: "KafkaTopicList"
		singular: "kafkatopic"
		plural:   "kafkatopics"
		shortNames: [
			"kt",
		]
		categories: [
			"strimzi",
		]
	}
	additionalPrinterColumns: [{
		name:        "Partitions"
		description: "The desired number of partitions in the topic"
		JSONPath:    ".spec.partitions"
		type:        "integer"
	}, {
		name:        "Replication factor"
		description: "The desired number of replicas of each partition"
		JSONPath:    ".spec.replicas"
		type:        "integer"
	}]
	subresources: status: {}
	validation: openAPIV3Schema: properties: {
		spec: {
			type: "object"
			properties: {
				partitions: {
					type:    "integer"
					minimum: 1
				}
				replicas: {
					type:    "integer"
					minimum: 1
					maximum: 32767
				}
				config: type:    "object"
				topicName: type: "string"
			}
			required: [
				"partitions",
				"replicas",
			]
		}
		status: {
			type: "object"
			properties: {
				conditions: {
					type: "array"
					items: {
						type: "object"
						properties: {
							type: type:               "string"
							status: type:             "string"
							lastTransitionTime: type: "string"
							reason: type:             "string"
							message: type:            "string"
						}
					}
				}
				observedGeneration: type: "integer"
			}
		}
	}
}
