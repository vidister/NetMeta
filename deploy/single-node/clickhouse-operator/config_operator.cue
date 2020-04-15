package k8s

import (
	"encoding/yaml"
)

k8s: configmaps: "etc-clickhouse-operator-confd-files": metadata: labels: app: "clickhouse-operator"

k8s: configmaps: "etc-clickhouse-operator-files": {
	metadata: labels: app: "clickhouse-operator"
	data: "config.yaml": yaml.Marshal({
		// List of namespaces where clickhouse-operator watches for events.
		// Concurrently running operators should watch on different namespaces
		//watchNamespaces:
		//  - dev
		//  - test
		//  - info
		//  - onemore

		// Additional Configuration Files Section

		// Path to folder where ClickHouse configuration files common for all instances within CHI are located.
		chCommonConfigsPath: "config.d"

		// Path to folder where ClickHouse configuration files unique for each instance (host) within CHI are located.
		chHostConfigsPath: "conf.d"

		// Path to folder where ClickHouse configuration files with users settings are located.
		// Files are common for all instances within CHI
		chUsersConfigsPath: "users.d"

		// Path to folder where ClickHouseInstallation .yaml manifests are located.
		// Manifests are applied in sorted alpha-numeric order
		chiTemplatesPath: "templates.d"

		// Cluster Create/Update/Delete Objects Section

		// How many seconds to wait for created/updated StatefulSet to be Ready
		statefulSetUpdateTimeout: 300

		// How many seconds to wait between checks for created/updated StatefulSet status
		statefulSetUpdatePollPeriod: 5

		// What to do in case created StatefulSet is not in Ready after `statefulSetUpdateTimeout` seconds
		// Possible options:
		// 1. abort - do nothing, just break the process and wait for admin
		// 2. delete - delete newly created problematic StatefulSet
		// 3. ignore - ignore error, pretend nothing happened and move on to the next StatefulSet
		onStatefulSetCreateFailureAction: "ignore"

		// What to do in case updated StatefulSet is not in Ready after `statefulSetUpdateTimeout` seconds
		// Possible options:
		// 1. abort - do nothing, just break the process and wait for admin
		// 2. rollback - delete Pod and rollback StatefulSet to previous Generation.
		// Pod would be recreated by StatefulSet based on rollback-ed configuration
		// 3. ignore - ignore error, pretend nothing happened and move on to the next StatefulSet
		onStatefulSetUpdateFailureAction: "rollback"

		// ClickHouse Settings

		// Default values for ClickHouse user configuration
		// 1. user/profile - string
		// 2. user/quota - string
		// 3. user/networks/ip - multiple strings
		// 4. user/password - string
		chConfigUserDefaultProfile: "default"
		chConfigUserDefaultQuota:   "default"
		chConfigUserDefaultNetworksIP: ["::1", "127.0.0.1"]
		chConfigUserDefaultPassword: "default"

		// Default host_regexp to limit network connectivity from outside
		ChConfigNetworksHostRegexpTemplate: #"(chi-{chi}-[^.]+\\d+-\\d+|clickhouse\\-{chi})\\.{namespace}\\.svc\\.cluster\\.local$"#

		// Operator's access to ClickHouse instances

		// ClickHouse credentials (username, password and port) to be used by operator to connect to ClickHouse instances for:
		// 1. Metrics requests
		// 2. Schema maintenance
		// 3. DROP DNS CACHE
		// User with such credentials can be specified in additional ClickHouse .xml config files,
		// located in `chUsersConfigsPath` folder
		chUsername: "clickhouse_operator"
		chPassword: "clickhouse_operator_password" // TODO(leo): Secure credentials
		chPort:     8123

		// Log parameters

		logtostderr:      "true"
		alsologtostderr:  "false"
		stderrthreshold:  ""
		vmodule:          ""
		log_backtrace_at: ""
		v:                "1"
	})
}
