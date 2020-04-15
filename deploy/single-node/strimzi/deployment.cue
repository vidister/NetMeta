package k8s

k8s: deployments: "strimzi-cluster-operator": spec: {
	replicas: 1
	selector: matchLabels: {
		name:              "strimzi-cluster-operator"
		"strimzi.io/kind": "cluster-operator"
	}
	template: {
		metadata: labels: {
			name:              "strimzi-cluster-operator"
			"strimzi.io/kind": "cluster-operator"
		}
		spec: {
			serviceAccountName: "strimzi-cluster-operator"
			containers: [{
				name:  "strimzi-cluster-operator"
				image: "strimzi/operator:0.17.0"
				args: [
					"/opt/strimzi/bin/cluster_operator_run.sh",
				]
				env: [{
					name: "STRIMZI_NAMESPACE"
					valueFrom: fieldRef: fieldPath: "metadata.namespace"
				}, {
					name:  "STRIMZI_FULL_RECONCILIATION_INTERVAL_MS"
					value: "120000"
				}, {
					name:  "STRIMZI_OPERATION_TIMEOUT_MS"
					value: "300000"
				}, {
					name:  "STRIMZI_DEFAULT_TLS_SIDECAR_ENTITY_OPERATOR_IMAGE"
					value: "strimzi/kafka:0.17.0-kafka-2.4.0"
				}, {
					name:  "STRIMZI_DEFAULT_TLS_SIDECAR_KAFKA_IMAGE"
					value: "strimzi/kafka:0.17.0-kafka-2.4.0"
				}, {
					name:  "STRIMZI_DEFAULT_TLS_SIDECAR_ZOOKEEPER_IMAGE"
					value: "strimzi/kafka:0.17.0-kafka-2.4.0"
				}, {
					name:  "STRIMZI_DEFAULT_KAFKA_EXPORTER_IMAGE"
					value: "strimzi/kafka:0.17.0-kafka-2.4.0"
				}, {
					name: "STRIMZI_KAFKA_IMAGES"
					value: """
		2.3.1=strimzi/kafka:0.17.0-kafka-2.3.1
		2.4.0=strimzi/kafka:0.17.0-kafka-2.4.0

		"""
				}, {
					name: "STRIMZI_KAFKA_CONNECT_IMAGES"
					value: """
		2.3.1=strimzi/kafka:0.17.0-kafka-2.3.1
		2.4.0=strimzi/kafka:0.17.0-kafka-2.4.0

		"""
				}, {
					name: "STRIMZI_KAFKA_CONNECT_S2I_IMAGES"
					value: """
		2.3.1=strimzi/kafka:0.17.0-kafka-2.3.1
		2.4.0=strimzi/kafka:0.17.0-kafka-2.4.0

		"""
				}, {
					name: "STRIMZI_KAFKA_MIRROR_MAKER_IMAGES"
					value: """
		2.3.1=strimzi/kafka:0.17.0-kafka-2.3.1
		2.4.0=strimzi/kafka:0.17.0-kafka-2.4.0

		"""
				}, {
					name: "STRIMZI_KAFKA_MIRROR_MAKER_2_IMAGES"
					value: """
		2.4.0=strimzi/kafka:0.17.0-kafka-2.4.0

		"""
				}, {
					name:  "STRIMZI_DEFAULT_TOPIC_OPERATOR_IMAGE"
					value: "strimzi/operator:0.17.0"
				}, {
					name:  "STRIMZI_DEFAULT_USER_OPERATOR_IMAGE"
					value: "strimzi/operator:0.17.0"
				}, {
					name:  "STRIMZI_DEFAULT_KAFKA_INIT_IMAGE"
					value: "strimzi/operator:0.17.0"
				}, {
					name:  "STRIMZI_DEFAULT_KAFKA_BRIDGE_IMAGE"
					value: "strimzi/kafka-bridge:0.15.2"
				}, {
					name:  "STRIMZI_DEFAULT_JMXTRANS_IMAGE"
					value: "strimzi/jmxtrans:0.17.0"
				}, {
					name:  "STRIMZI_LOG_LEVEL"
					value: "INFO"
				}]
				livenessProbe: {
					httpGet: {
						path: "/healthy"
						port: 8080
					}
					initialDelaySeconds: 10
					periodSeconds:       30
				}
				readinessProbe: {
					httpGet: {
						path: "/ready"
						port: 8080
					}
					initialDelaySeconds: 10
					periodSeconds:       30
				}
				resources: {
					limits: {
						cpu:    "1000m"
						memory: "256Mi"
					}
					requests: {
						cpu:    "200m"
						memory: "256Mi"
					}
				}
			}]
		}
	}
	strategy: type: "Recreate"
}
